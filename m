From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 15 Mar 2017 18:55:10 +0800
Subject: [LTP] [PATCH] runtest/net.nfs: fix version typo
Message-ID: <1489575310-3488-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/net.nfs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index f5984c0..a0781a5 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -12,7 +12,7 @@ nfs41_ipv6_01 nfs01 -6 -v 4.1 -t tcp
 nfs42_ipv6_01 nfs01 -6 -v 4.2 -t tcp
 
 nfs3_02 nfs02 -v 3 -t udp
-nfs4_02 nfs02 -v 3 -t tcp
+nfs4_02 nfs02 -v 4 -t tcp
 nfs41_02 nfs02 -v 4.1 -t tcp
 nfs42_02 nfs02 -v 4.2 -t tcp
 nfs3_ipv6_02 nfs02 -6 -v 3 -t udp
@@ -21,7 +21,7 @@ nfs41_ipv6_02 nfs02 -6 -v 4.1 -t tcp
 nfs42_ipv6_02 nfs02 -6 -v 4.2 -t tcp
 
 nfs3_03 nfs03 -v 3 -t udp
-nfs4_03 nfs03 -v 3 -t tcp
+nfs4_03 nfs03 -v 4 -t tcp
 nfs41_03 nfs03 -v 4.1 -t tcp
 nfs42_03 nfs03 -v 4.2 -t tcp
 nfs3_ipv6_03 nfs03 -6 -v 3 -t udp
@@ -30,7 +30,7 @@ nfs41_ipv6_03 nfs03 -6 -v 4.1 -t tcp
 nfs42_ipv6_03 nfs03 -6 -v 4.2 -t tcp
 
 nfs3_04 nfs04 -v 3 -t udp
-nfs4_04 nfs04 -v 3 -t tcp
+nfs4_04 nfs04 -v 4 -t tcp
 nfs41_04 nfs04 -v 4.1 -t tcp
 nfs42_04 nfs04 -v 4.2 -t tcp
 nfs3_ipv6_04 nfs04 -6 -v 3 -t udp
-- 
1.8.3.1



