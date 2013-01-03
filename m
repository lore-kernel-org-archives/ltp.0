Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TqbFQ-0007J3-83
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 03:13:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TqbFP-00013x-8J
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 03:13:36 +0000
Message-ID: <50E4F77C.9000403@cn.fujitsu.com>
Date: Thu, 03 Jan 2013 11:14:04 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1356420393-4253-1-git-send-email-jshao@redhat.com>
	<1356511717-31058-1-git-send-email-jshao@redhat.com>
In-Reply-To: <1356511717-31058-1-git-send-email-jshao@redhat.com>
Subject: Re: [LTP] [PATCHv2 1/3] pidns16: split test condition and result
 judge
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Monson Shao <jshao@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/26/2012 04:48 PM, Monson Shao wrote:
> Make it easy to read.
> 
> Signed-off-by: Monson Shao <jshao@redhat.com>
> ---
>  testcases/kernel/containers/pidns/pidns16.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
> index 8a232c6..04a1641 100644
> --- a/testcases/kernel/containers/pidns/pidns16.c
> +++ b/testcases/kernel/containers/pidns/pidns16.c
> @@ -70,17 +70,29 @@ void cleanup()
>  void child_signal_handler(int sig, siginfo_t * si, void *unused)
>  {
>  	static int c = 1;
> +	pid_t expected_pid;
> +
>  	/* Verifying from which process the signal handler is signalled */
>  
> -	if ((c == 1) && (si->si_pid == globalpid))
> -		tst_resm(TINFO, "sig_handler is signalled from pid  %d",
> -			 globalpid);
> -	else if ((c == 2) && (si->si_pid == CHILD_PID))
> -		tst_resm(TINFO, "sig_handler is signalled from pid  %d",
> -			 CHILD_PID);
> +	switch (c) {
> +	case 1:
> +		expected_pid = globalpid;
> +		break;
> +	case 2:
> +		expected_pid = CHILD_PID;
> +		break;
> +	default:
> + 		tst_resm(TBROK, "child should NOT be signalled 3+ times");
> + 		return;

These two lines added spaces before TAB, I edit on site, please take care next time.

Thanks,
Wanlong Gao

> +	}
> +
> +	if (si->si_pid == expected_pid)
> +		tst_resm(TINFO, "child is signalled from expected pid %d",
> +			 expected_pid);
>  	else
> -		tst_resm(TBROK, "Unexpected value for Sending-ProcessID"
> -			 " when signal handler called %d\n", si->si_pid);
> +		tst_resm(TBROK, "child is signalled from unexpected pid %d,"
> +			 " expecting pid %d", si->si_pid, expected_pid);
> +
>  	c++;
>  }
>  
> 


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
