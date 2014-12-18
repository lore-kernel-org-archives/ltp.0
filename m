Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lijinyue@huawei.com>) id 1Y1aZj-0000VQ-Kl
	for ltp-list@lists.sourceforge.net; Thu, 18 Dec 2014 12:53:03 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Y1aZe-0000lY-0z
	for ltp-list@lists.sourceforge.net; Thu, 18 Dec 2014 12:53:03 +0000
From: lijinyue <lijinyue@huawei.com>
Date: Thu, 18 Dec 2014 12:00:24 +0000
Message-ID: <1418904024-29740-1-git-send-email-lijinyue@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] controllers/cgroup_fj:fix mount error for mount tools
	above v2.21
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
Cc: dingguofu@huawei.com, zhanyongming@huawei.com

For util-linux version above v2.21(eg, Red Hat Enterprise Linux 7.0, util-linux v2.23.2),
some tests in run_cgroup_test_fj.sh will test failed.
eg:
        cgroup_test_fj    1  TFAIL  :  case13(function  2 1 1 2 1 2 3 2 1)    FAIL

The reason is that mount version above v2.21 will cause mount error in the following scenes:
        (mount from util-linux 2.23.2)
        mkdir /dev/cgroup
        mount -t cgroup -o cpuset,release_agent=  cgroup /dev/cgroup

        error output:
        mount: special device cgroup does not exist
While, for mount version v2.19.1(eg, SLES 11 sp2, mount from util-linux 2.19.1 )
        mount will success like this:
        cgroup on /dev/cgroup type cgroup (rw,cpuset,release_agent=)

So we kindly make run_cgroup_test_fj.sh test more smoothly with different util-linux.

Signed-off-by: Realeam <lijinyue@huawei.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 9b49725..6d3915f 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -583,7 +583,7 @@ mount_cgroup ()
 			PARAMETER_O="$noprefix_use_str"
 		fi
 	fi
-	if [ "$release_agent_para_str" != "" ]; then
+	if [ "$release_agent_para_str" != "" -a "$release_agent_para_str" != " " ]; then
 		if [ "$PARAMETER_O" != "" ]; then
 			PARAMETER_O="$PARAMETER_O"",release_agent=""$release_agent_para_str"
 		else
-- 
1.8.2.2


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
