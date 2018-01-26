From: Hoang Van Tuyen <tuyen.hoangvan@toshiba-tsdv.com>
Date: Fri, 26 Jan 2018 09:34:09 +0700
Subject: [LTP] [ltp][PATCH] runltp: Append ${LTPROOT}/bin to PATH variable
Message-ID: <2d5bf039-1b83-5e92-150d-e435e9f7d383@toshiba-tsdv.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some executable files were installed to ${LTPROOT}/bin.
So, We should append ${LTPROOT}/bin to PATH variable.

Signed-off-by: Hoang Van Tuyen <tuyen.hoangvan@toshiba-tsdv.com>
---
  runltp        | 2 +-
  runltplite.sh | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runltp b/runltp
index 302c4a7..51357fa 100755
--- a/runltp
+++ b/runltp
@@ -78,7 +78,7 @@ setup()
      }
      export LTPROOT=${PWD}
      export TMPBASE="/tmp"
-    export PATH="${PATH}:${LTPROOT}/testcases/bin"
+    export PATH="${PATH}:${LTPROOT}/testcases/bin:${LTPROOT}/bin"

      export LTP_DEV_FS_TYPE="ext2"

diff --git a/runltplite.sh b/runltplite.sh
index 17be009..de90534 100755
--- a/runltplite.sh
+++ b/runltplite.sh
@@ -49,7 +49,7 @@ setup()
      export LTPROOT=${PWD}
      export TMPBASE="/tmp"
      export TMP="${TMPBASE}/ltp-$$"
-    export PATH="${PATH}:${LTPROOT}/testcases/bin"
+    export PATH="${PATH}:${LTPROOT}/testcases/bin:${LTPROOT}/bin"

      export LTP_DEV=""
      export LTP_DEV_FS_TYPE="ext2"
-- 
2.1.4

-- 
================================================================
Hoang Van Tuyen (Mr.)
TOSHIBA SOFTWARE DEVELOPMENT (VIETNAM) CO., LTD.
16th Floor, VIT Building, 519 Kim Ma Str., Ba Dinh Dist., Hanoi, Vietnam
Tel: 84-4-22208801 (Company) - Ext.251
Fax: 84-4-22208802 (Company)
Email: tuyen.hoangvan@toshiba-tsdv.com
================================================================


-- 
This mail was scanned by BitDefender
For more information please visit http://www.bitdefender.com

