From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Nov 2020 14:46:25 +0100
Subject: [LTP] [PATCH 1/1] travis: Add libefivar support
In-Reply-To: <20201110120035.20543-1-pvorel@suse.cz>
References: <20201110120035.20543-1-pvorel@suse.cz>
Message-ID: <20201110134625.GA6482@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Travis CI:
> https://travis-ci.org/github/pevik/ltp/builds/742684375

Looks like Debian does not ship libefivar-dev for ppc64el
https://travis-ci.org/github/pevik/ltp/jobs/742684377

Kind regards,
Petr

Fix:
diff --git travis/debian.cross-compile.sh travis/debian.cross-compile.sh
index e27c6c9bc..69ddf225c 100755
--- travis/debian.cross-compile.sh
+++ travis/debian.cross-compile.sh
@@ -2,6 +2,8 @@
 # Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -ex
 
+apt="apt install -y --no-install-recommends"
+
 if [ -z "$ARCH" ]; then
 	echo "missing \$ARCH!" >&2
 	exit 1
@@ -17,9 +19,11 @@ esac
 dpkg --add-architecture $ARCH
 apt update
 
-apt install -y --no-install-recommends \
+$apt \
 	gcc-${gcc_arch}-linux-gnu \
 	libc6-dev-${ARCH}-cross \
-	libefivar-dev:$ARCH \
 	libmnl-dev:$ARCH \
 	libtirpc-dev:$ARCH
+
+# efivar is currently missing on ppc64el
+$apt libefivar-dev:$ARCH || true
