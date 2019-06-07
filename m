From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Jun 2019 15:39:44 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] ver_linux: Fix util-linux version for
	some distros
Message-ID: <20190607133944.17045-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some SLES versions on s390x does not contain fdformat in util-linux
package, which breaks util-linux detection:

util-linux             /opt/ltp/ver_linux: line 73: fdformat: command not found

Thus use mkswap which is in util-linux since v2.2 (the same as fdformat)
it's common enough (there is no --disable-mkswap build flag in
util-linux).

While on it, remove also extra "linux " output before version caused by
-F\- awk parameter.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ver_linux | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ver_linux b/ver_linux
index 6c2706bae..8b8ba79a8 100755
--- a/ver_linux
+++ b/ver_linux
@@ -70,7 +70,7 @@ make --version 2>&1 | awk -F, '{print $1}' | awk \
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
       '/BFD/{print "binutils              ",$NF}'
 
-fdformat --version 2>&1 | awk -F\- '{print "util-linux            ", $NF}'
+mkswap -V 2>&1 | awk '{print "util-linux            ", $NF}'
 
 mount --version 2>&1 | awk -F\- '{print "mount                 ", $NF}'
 
-- 
2.21.0

