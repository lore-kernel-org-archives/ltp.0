Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YQAr8-0001XJ-83
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 08:28:38 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQAr5-0007eF-Ph
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 08:28:38 +0000
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Tue, 24 Feb 2015 16:27:39 +0800
Message-ID: <1424766459-22439-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1424766459-22439-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1424766459-22439-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] lib/tst_virt.c: distinguish between KVM and QEMU
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: jjaburek@redhat.com

KVM guest is on top of QEMU, It's necessary that figure out
the difference between the two.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 lib/tst_virt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index eb3b487..1d9960e 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -100,14 +100,24 @@ static int is_kvm(void)
 	FILE *cpuinfo;
 	char line[64];
 	int found;
+    char sig[SIG_MAX_LEN];
 
-	/* this doesn't work with custom -cpu values, since there's
-	 * no easy, reasonable or reliable way to work around those */
 	cpuinfo = SAFE_FOPEN(NULL, "/proc/cpuinfo", "r");
 	found = 0;
 	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
 		if (strstr(line, "QEMU Virtual CPU")) {
-			found = 1;
+            /*
+             * Is it an KVM(on top of QEMU) or Only a QEMU?
+             */
+            if (cpu_sign(&sig[0]) == 0) {
+                if (strcmp(sig, "KVMKVMKVM") == 0) {
+                    found = 1;
+                } else {
+                    // QEMU Guest
+                }
+            } else {
+                found = 1;
+            }
 			break;
 		}
 	}
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
