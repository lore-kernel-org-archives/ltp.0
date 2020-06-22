From: Petr Vorel <petr.vorel@suse.com>
Date: Mon, 22 Jun 2020 09:43:14 +0200
Subject: [LTP] [PATCH 2/2] travis: Add -Werror=return-type
In-Reply-To: <20200622074314.22098-1-petr.vorel@suse.com>
References: <20200622074314.22098-1-petr.vorel@suse.com>
Message-ID: <20200622074314.22098-2-petr.vorel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/build.sh b/build.sh
index becaf3619..7fd9683a8 100755
--- a/build.sh
+++ b/build.sh
@@ -9,7 +9,7 @@
 
 set -e
 
-CFLAGS="${CFLAGS:--Wformat -Werror=format-security -Werror=implicit-function-declaration -fno-common}"
+CFLAGS="${CFLAGS:--Wformat -Werror=format-security -Werror=implicit-function-declaration -Werror=return-type -fno-common}"
 CC="${CC:-gcc}"
 
 DEFAULT_PREFIX="$HOME/ltp-install"
-- 
2.27.0

