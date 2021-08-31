From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Aug 2021 08:13:55 +0200
Subject: [LTP] [PATCH 1/1] scripts: Remove detect_distro.sh, git2changelog.sh
Message-ID: <20210831061355.15533-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove other 11 years old unused scripts:

* detect_distro.sh: there is lsb-release
* git2changelog.sh we don't generate changelog from git

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 scripts/detect_distro.sh | 127 ---------------------------------------
 scripts/git2changelog.sh |  28 ---------
 2 files changed, 155 deletions(-)
 delete mode 100755 scripts/detect_distro.sh
 delete mode 100755 scripts/git2changelog.sh

diff --git a/scripts/detect_distro.sh b/scripts/detect_distro.sh
deleted file mode 100755
index df9d927e9..000000000
--- a/scripts/detect_distro.sh
+++ /dev/null
@@ -1,127 +0,0 @@
-#!/bin/sh
-#
-#	Answer the question: what distro are we installing.
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-#
-#
-
-error() {
-	echo "${0##*/}: ERROR: $*" >&2
-}
-
-destdir=
-omit_redhat_minor_version=0
-
-while getopts "d:m" opt; do
-
-	case "$opt" in
-	d)
-		if [ ! -d "$OPTARG" ] ; then
-			error "$OPTARG doesn't exist"
-			exit 1
-		fi
-		destdir=$OPTARG
-		;;
-	m)
-		omit_redhat_minor_version=1
-		;;
-	esac
-done
-
-etc_dir="$destdir/etc"
-
-if [ ! -d "$etc_dir" ] ; then
-	error "$etc_dir doesn't exist"
-	exit 1
-fi
-
-#
-# Precedence list for files to look through for version info...
-#
-# XXX (garrcoop): add more..
-#
-for i in gentoo-release redhat-release; do
-	if [ -f "$etc_dir/$i" ] ; then
-		DISTRO_RELEASE_FILE="$i"
-		break
-	fi
-done
-
-if [ "x$DISTRO_RELEASE_FILE" = x ] ; then
-	error "Couldn't determine distro release file"
-	error "Please send an email with your distro's details, if you believe this is in error"
-	exit 1
-else
-	DISTRO_RELEASE_ABS_FILE="$etc_dir/$DISTRO_RELEASE_FILE"
-
-	case "$i" in
-	gentoo-release)
-		DISTRO=gentoo
-		RELEASE_FORMAT_FILE=1
-		;;
-	redhat-release)
-		RELEASE_FORMAT_FILE=1
-		if grep -q '^Red Hat' "$DISTRO_RELEASE_ABS_FILE"; then
-			DISTRO=redhat
-		elif grep -q '^Fedora' "$DISTRO_RELEASE_ABS_FILE"; then
-			DISTRO=fedora
-		else
-			RELEASE_FORMAT_FILE=0
-		fi
-		;;
-	esac
-
-	if [ $RELEASE_FORMAT_FILE -eq 1 ] ; then
-
-		set -- $(cat "$DISTRO_RELEASE_ABS_FILE")
-
-		while [ 1 ] ; do
-			shift
-			if [ $# -eq 0 -o "x$1" = "xrelease" ] ; then
-				if [ "x$1" = "xrelease" ] ; then
-					shift
-				fi
-				break
-			fi
-		done
-
-		case "$DISTRO" in
-		gentoo)
-			VERSION=$1
-			;;
-		fedora|redhat)
-			MAJOR_VER=$1
-			if [ $omit_redhat_minor_version -eq 0 ] && echo "$@" | grep -q '\(.*Update.*\)'; then
-				MINOR_VER=$(echo "$@" | sed -e 's/[\(\)]//g' -e 's/.*Update //')
-			fi
-			VERSION="$MAJOR_VER${MINOR_VER:+.${MINOR_VER}}"
-			;;
-		esac
-
-	fi
-
-	if [ "x$VERSION" = x ] ; then
-		error "Bad release file: $etc_dir/$DISTRO_RELEASE_FILE"
-		exit 2
-	else
-		echo "$DISTRO-$VERSION"
-	fi
-
-fi
diff --git a/scripts/git2changelog.sh b/scripts/git2changelog.sh
deleted file mode 100755
index 0ff37b29a..000000000
--- a/scripts/git2changelog.sh
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/sh
-#
-# Dumb script for making a ChangeLog.
-#
-# Invoke like:
-#
-# scripts/git2changelog.sh --after="2010-02-01" --until="2010-02-31"
-#
-
-set -e
-
-tmp_changelog=$(mktemp /tmp/changelog.XXXXXX)
-
-trap "[ -f '$tmp_changelog' ] && rm -f '$tmp_changelog'; [ -f '$changelog~' ] && mv '$changelog~' '$changelog'" 0 2 15
-
-changelog="${0%/*}/../ChangeLog"
-
-git log --format="%nCommit: %H%nDate:   %aD%n%n%s%n%b%nChanged Files:" \
-	--name-only "$@" > "$tmp_changelog"
-
-cat "$changelog" >> "$tmp_changelog"
-
-mv "$changelog" "$changelog~"
-
-# This may take a while...
-mv "$tmp_changelog" "$changelog"
-
-rm -f "$changelog~"
-- 
2.33.0

