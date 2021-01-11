From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon, 11 Jan 2021 11:07:03 +0800
Subject: [LTP] [PATCH 1/2] build.sh: Remove deprecated CROSS_COMPILE
Message-ID: <20210111030704.5761-1-lizhijian@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The CROSS_COMPILE was no longer used by ltp since 400ac9bbe20.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/build.sh b/build.sh
index 452cc6f4c..602ca419e 100755
--- a/build.sh
+++ b/build.sh
@@ -64,7 +64,7 @@ build_cross()
 	fi
 
 	echo "===== cross-compile ${host} ${1}-tree build into $PREFIX ====="
-	build $1 $2 "--host=$host" CROSS_COMPILE="${host}-"
+	build $1 $2 "--host=$host"
 }
 
 build()
-- 
2.30.0



