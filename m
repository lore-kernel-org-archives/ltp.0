From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 8 Jan 2020 12:48:42 +0100
Subject: [LTP] [PATCH 3/4] travis: Merge debian.cross-compile.*.sh
In-Reply-To: <20200108103413.29096-4-pvorel@suse.cz>
References: <20200108103413.29096-1-pvorel@suse.cz>
 <20200108103413.29096-4-pvorel@suse.cz>
Message-ID: <20200108114842.GA29068@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this needs to be fixed, otherwise Debian cross compile jobs fail.

Kind regards,
Petr

diff --git travis/debian.cross-compile.sh travis/debian.cross-compile.sh
index 2f2b7a70c..8557b832b 100755
--- travis/debian.cross-compile.sh
+++ travis/debian.cross-compile.sh
@@ -3,10 +3,16 @@
 set -e
 
 if [ -z "$ARCH" ]; then
-	echo "missing \$ARCH!"
+	echo "missing \$ARCH!" >&2
 	exit 1
 fi
 
+case "$ARCH" in
+arm64) gcc_arch="aarch64";;
+ppc64el) gcc_arch="powerpc64le";;
+*) echo "unsupported arch: '$1'!" >&2; exit 1;;
+esac
+
 dpkg --add-architecture $ARCH
 apt update
 
@@ -17,6 +23,6 @@ none) EXTRA_PACKAGES=;;
 esac
 
 apt install -y --no-install-recommends \
-	gcc-${ARCH}-linux-gnu \
+	gcc-${gcc_arch}-linux-gnu \
 	libc6-dev-${ARCH}-cross \
 	$EXTRA_PACKAGES
