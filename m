Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liaoqingwei@huawei.com>) id 1Yw7CX-0001KP-9J
	for ltp-list@lists.sourceforge.net; Sat, 23 May 2015 11:02:45 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yw7CR-0003go-5C
	for ltp-list@lists.sourceforge.net; Sat, 23 May 2015 11:02:45 +0000
Message-ID: <55605E3A.3040000@huawei.com>
Date: Sat, 23 May 2015 19:02:18 +0800
From: LiaoQingwei <liaoqingwei@huawei.com>
MIME-Version: 1.0
References: <1432404112-12132-1-git-send-email-liaoqingwei@huawei.com>
In-Reply-To: <1432404112-12132-1-git-send-email-liaoqingwei@huawei.com>
Subject: Re: [LTP] [PATCH v2] controllers/cpuacct: tst_brkm() instead of
 echo failed message
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
To: liaoqingwei <liaoqingwei@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Please forgive my careless,I send a wrong patch,please ignored.The patch v2 maybe right.
Thanks.

Most of the time,the reason of mount cgroup failed is the configuration
is not enabled,for example,CONFIG_CGROUP_CPUACCT=no.
I think use TCONF message is more helpful,and use basic test interface
tst_brkm instead of echo failed message.

Signed-off-by: Liao Qingwei <liaoqingwei@huawei.com>
---
 testcases/kernel/controllers/cpuacct/cpuacct_setup.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
index 6eab1b4..f9c4fb8 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
@@ -97,10 +97,8 @@ setup()
        mount -t cgroup -ocpuacct none /dev/cpuacct 2> /dev/null
        if [ $? -ne 0 ]
        then
-               echo "TFAIL: Could not mount cgroup filesystem"
-               echo "Exiting test"
-               cleanup
-               exit 1
+                tst_brkm TCONF cleanup "Could not mount cgroup filesystem,Maybe the configuration is not enabled"
+               exit 0
        fi

        # Group created earlier may again be visible if not cleaned properly.
-- 
1.9.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
