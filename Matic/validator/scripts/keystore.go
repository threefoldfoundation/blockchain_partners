package main

import (
	"encoding/hex"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"time"

	"github.com/maticnetwork/bor/accounts/keystore"
	ethCommon "github.com/maticnetwork/bor/common"
	"github.com/maticnetwork/bor/crypto"
	"github.com/pborman/uuid"
)

func main() {
	argsWithoutProg := os.Args[1:]

	s := strings.ReplaceAll(argsWithoutProg[0], "0x", "")
	pk, err := crypto.HexToECDSA(s)
	if err != nil {
		panic(err)
	}

	id := uuid.NewRandom()
	key := &keystore.Key{
		Id:         id,
		Address:    crypto.PubkeyToAddress(pk.PublicKey),
		PrivateKey: pk,
	}

	// read files
	pwText, err := ioutil.ReadFile(argsWithoutProg[1])
	if err != nil {
		panic(err)
	}

	lines := strings.Split(string(pwText), "\n")

	// Sanitise DOS line endings.
	for i := range lines {
		lines[i] = strings.TrimRight(lines[i], "\r")
	}

	pw := lines[0]

	keyjson, err := keystore.EncryptKey(key, string(pw), keystore.StandardScryptN, keystore.StandardScryptP)
	if err != nil {
		panic(err)
	}

	// Then write the new keyfile in place of the old one.
	if err := ioutil.WriteFile(keyFileName(key.Address), keyjson, 0600); err != nil {
		panic(err)
	}
}

// keyFileName implements the naming convention for keyfiles:
// UTC--<created_at UTC ISO8601>-<address hex>
func keyFileName(keyAddr ethCommon.Address) string {
	ts := time.Now().UTC()
	return fmt.Sprintf("UTC--%s--%s", toISO8601(ts), hex.EncodeToString(keyAddr[:]))
}

func toISO8601(t time.Time) string {
	var tz string
	name, offset := t.Zone()
	if name == "UTC" {
		tz = "Z"
	} else {
		tz = fmt.Sprintf("%03d00", offset/3600)
	}
	return fmt.Sprintf("%04d-%02d-%02dT%02d-%02d-%02d.%09d%s",
		t.Year(), t.Month(), t.Day(), t.Hour(), t.Minute(), t.Second(), t.Nanosecond(), tz)
}
