From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Dec 2018 15:14:13 +0100
Subject: [LTP] [PATCH 1/3] ver_linux: Print clang version
Message-ID: <20181219141415.3495-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ver_linux | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ver_linux b/ver_linux
index 897571703..bbc89987b 100755
--- a/ver_linux
+++ b/ver_linux
@@ -31,6 +31,7 @@ cat /proc/cmdline
 echo
 
 echo "Gnu C                 " `gcc --version 2>/dev/null | head -n 1`
+echo "Clang                 " `clang --version 2>/dev/null | head -n 1`
 
 make --version 2>&1 | awk -F, '{print $1}' | awk \
       '/GNU Make/{print "Gnu make              ",$NF}'
-- 
2.19.2

