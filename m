From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 10:56:17 +0200
Subject: [LTP] [PATCH] tools/make-file.sh: Use dd instead of shell loop
Message-ID: <20170330085617.12747-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Which is more than 10x faster.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
---
 tools/make-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/make-file.sh b/tools/make-file.sh
index ebfeb50..d4090b7 100755
--- a/tools/make-file.sh
+++ b/tools/make-file.sh
@@ -35,6 +35,6 @@ fi
 
 [ -e "$file" ] && exit 0
 
-while [ $((size=size-1)) -ge 0 ]; do printf "A" ; done > "$file"
+dd if=/dev/zero bs=1 count="$size" 2>/dev/null | tr "\0" "A" > "$file"
 
 chmod 666 $file
-- 
2.10.2

