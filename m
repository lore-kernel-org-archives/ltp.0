From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 11:28:09 +0200
Subject: [LTP] [RFC PATCH 8/8] travis: Build with -fno-common
In-Reply-To: <20200415092809.20240-1-pvorel@suse.cz>
References: <20200415092809.20240-1-pvorel@suse.cz>
Message-ID: <20200415092809.20240-9-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is the default with gcc-10, but use it with all compilers.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/build.sh b/build.sh
index e3d268c83..50fb527e4 100755
--- a/build.sh
+++ b/build.sh
@@ -9,7 +9,7 @@
 
 set -e
 
-CFLAGS="${CFLAGS:--Werror=implicit-function-declaration}"
+CFLAGS="${CFLAGS:--Werror=implicit-function-declaration -fno-common}"
 CC="${CC:-gcc}"
 
 DEFAULT_PREFIX="$HOME/ltp-install"
-- 
2.26.0

