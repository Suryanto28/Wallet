#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

trboD=${trboD:-$BINDIR/trbod}
trboCLI=${trboCLI:-$BINDIR/trbo-cli}
trboTX=${trboTX:-$BINDIR/trbo-tx}
trboQT=${trboQT:-$BINDIR/qt/trbo-qt}

[ ! -x $trboD ] && echo "$trboD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($trboCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for trbod if --version-string is not set,
# but has different outcomes for bitcoin-qt and trbo-cli.
echo "[COPYRIGHT]" > footer.h2m
$trboD --version | sed -n '1!p' >> footer.h2m

for cmd in $trboD $trboCLI $trboTX $trboQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
