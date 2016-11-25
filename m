From: Petr Vorel <petr.vorel@gmail.com>
Date: Fri, 25 Nov 2016 22:01:23 +0100
Subject: [LTP] [PATCH v2 2/4] make-file.sh: simplify, fix bashism
In-Reply-To: <20161125210125.7299-1-petr.vorel@gmail.com>
References: <20161125210125.7299-1-petr.vorel@gmail.com>
Message-ID: <20161125210125.7299-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 tools/make-file.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/make-file.sh b/tools/make-file.sh
index becaeb0..ebfeb50 100755
--- a/tools/make-file.sh
+++ b/tools/make-file.sh
@@ -35,10 +35,6 @@ fi
 
 [ -e "$file" ] && exit 0
 
-if ! perl -e "print 'A' x $size" > "$file" 2> /dev/null ; then
-	if ! awk 'BEGIN { cnt='$size'; while (cnt--) printf "A" }' > "$file" 2> /dev/null ; then
-		( while ((size--)) ; do echo -n A ; done ) > "$file"
-	fi
-fi
+while [ $((size=size-1)) -ge 0 ]; do printf "A" ; done > "$file"
 
 chmod 666 $file
-- 
2.10.2

