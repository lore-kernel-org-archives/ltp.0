From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 May 2020 21:10:24 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] build.sh: Add -Wformat
 -Werror=format-security into CFLAGS
Message-ID: <20200520191024.2068474-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

so it's tested in Travis CI
First version, when it was supported was 3.0.4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I merged this without review, as it's based on old Cyril's ack [1]
First gcc version, where it's supported is gcc 3.

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-February/010988.html
[2] https://gcc.gnu.org/onlinedocs/gcc-3.0.4/gcc/Warning-Options.html

 build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/build.sh b/build.sh
index 50fb527e4..becaf3619 100755
--- a/build.sh
+++ b/build.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2020 Petr Vorel <pvorel@suse.cz>
 # Script for travis builds.
 #
 # TODO: Implement comparison of installed files. List of installed files can
@@ -9,7 +9,7 @@
 
 set -e
 
-CFLAGS="${CFLAGS:--Werror=implicit-function-declaration -fno-common}"
+CFLAGS="${CFLAGS:--Wformat -Werror=format-security -Werror=implicit-function-declaration -fno-common}"
 CC="${CC:-gcc}"
 
 DEFAULT_PREFIX="$HOME/ltp-install"
-- 
2.26.2

