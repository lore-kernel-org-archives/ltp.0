From: Lei Yang <Lei.Yang@windriver.com>
Date: Wed, 29 Aug 2018 11:51:24 +0800
Subject: [LTP] [PATCH] netns_helper.sh: use 'ping -6' when ping6 is not
	avaliable
Message-ID: <1535514684-26111-1-git-send-email-Lei.Yang@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ping6 has been merged into ping since 2015 by using "ping -6"
in some distrubiton like open embeded, they droped ping6 completely
this patch will let both "ping -6" and ping6 work

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
---
 testcases/kernel/containers/netns/netns_helper.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index 6aea10b..e3f60e1 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -168,7 +168,12 @@ netns_setup()
 	ipv6)
 		IFCONF_IN6_ARG="inet6 add"
 		IP0=$6; IP1=$7;
-		tping="ping6"; NETMASK=64
+		if which ping6 >/dev/null 2>&1; then
+		    tping="ping6" 
+		else
+		    tping="ping -6"
+		fi
+		NETMASK=64
 		;;
 	*)
 		tst_brkm TBROK "second argument must be an ip version (ipv4|ipv6)"
-- 
1.9.1

