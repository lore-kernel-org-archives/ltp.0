From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Jul 2017 15:39:52 +0200
Subject: [LTP] [PATCH 1/1] ver_linux: Print iputils version
Message-ID: <20170719133952.27891-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ align whitespace for printed iproute2 version

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ver_linux | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ver_linux b/ver_linux
index a403b4e43..dc49a4c2f 100755
--- a/ver_linux
+++ b/ver_linux
@@ -63,7 +63,10 @@ ifconfig --version 2>&1 | grep tools | awk \
 'NR==1{print "Net-tools             ", $NF}'
 
 ip -V 2>&1 | awk \
-'NR==1{print "iproute2             ", $NF}'
+'NR==1{print "iproute2              ", $NF}'
+
+ping -V 2>&1 | awk \
+'NR==1{print "iputils               ", $NF}'
 
 # Kbd needs 'loadkeys -h',
 loadkeys -h 2>&1 | awk \
-- 
2.13.2

