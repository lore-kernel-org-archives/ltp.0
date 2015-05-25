Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YwiUr-0001Z3-T9
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2015 02:52:09 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YwiUn-00008s-LC
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2015 02:52:09 +0000
Message-ID: <55628E3B.5050804@huawei.com>
Date: Mon, 25 May 2015 10:51:39 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1432404112-12132-1-git-send-email-liaoqingwei@huawei.com>
	<55605E3A.3040000@huawei.com>
In-Reply-To: <55605E3A.3040000@huawei.com>
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
To: LiaoQingwei <liaoqingwei@huawei.com>
Cc: ltp-list@lists.sourceforge.net

On 2015/5/23 19:02, LiaoQingwei wrote:
> Please forgive my careless,I send a wrong patch,please ignored.The patch v2 maybe right.
> Thanks.
> 
> Most of the time,the reason of mount cgroup failed is the configuration
> is not enabled,for example,CONFIG_CGROUP_CPUACCT=no.
> I think use TCONF message is more helpful,and use basic test interface
> tst_brkm instead of echo failed message.
> 
> Signed-off-by: Liao Qingwei <liaoqingwei@huawei.com>
> ---
>  testcases/kernel/controllers/cpuacct/cpuacct_setup.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
> index 6eab1b4..f9c4fb8 100755
> --- a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
> +++ b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
> @@ -97,10 +97,8 @@ setup()
>         mount -t cgroup -ocpuacct none /dev/cpuacct 2> /dev/null
>         if [ $? -ne 0 ]
>         then
> -               echo "TFAIL: Could not mount cgroup filesystem"
> -               echo "Exiting test"
> -               cleanup
> -               exit 1
> +                tst_brkm TCONF cleanup "Could not mount cgroup filesystem,Maybe the configuration is not enabled"

If want to call tst_brkm(), you should add the test.sh library in the case.
Or even better the test should do some clean up if use the test.sh library,
change "echo" to tst_resm INFO and "echo TFAIL" to tst_brkm TFAIL(remove the exit 1).

In addition, I don't think that call tst_brkm TCONF is suitable if mount failed.
Maybe we can add the message such as "Could not mount cgroup filesystem, and Maybe
the configuration is not enabled ..."

Also, check the patch with 'checkpatch.pl' script, fix warnings and errors.
> +               exit 0
>         fi
> 
>         # Group created earlier may again be visible if not cleaned properly.
> 


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
