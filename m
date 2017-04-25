From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Apr 2017 12:03:35 +0200
Subject: [LTP] [PATCH 1/1] ver_linux: Print sysctl settings
Message-ID: <20170425100335.20017-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ver_linux | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ver_linux b/ver_linux
index a403b4e43..f58de9f65 100755
--- a/ver_linux
+++ b/ver_linux
@@ -87,3 +87,7 @@ free
 echo
 echo '/proc/cpuinfo'
 cat /proc/cpuinfo
+
+echo
+echo 'sysctl settings:'
+sysctl -a
-- 
2.12.2

