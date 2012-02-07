Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RufZT-00019R-Ak
	for ltp-list@lists.sourceforge.net; Tue, 07 Feb 2012 07:34:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RufZP-0001Kr-F8
	for ltp-list@lists.sourceforge.net; Tue, 07 Feb 2012 07:34:35 +0000
Message-ID: <4F30D3C7.5080303@cn.fujitsu.com>
Date: Tue, 07 Feb 2012 15:33:27 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1328521976-810-1-git-send-email-kai.kang@windriver.com>
	<1328521976-810-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1328521976-810-2-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] mq_timedsend/5-1: make parent has chance to sleep
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On 02/06/2012 05:52 PM, Kang Kai wrote:

> Child process sends the last signal before parent process enter the
> final sleep sometimes, so sleep in parent will not be interrupted then
> the case fails.
> Sleep 1 second before send the last signal in child to make sure parent
> enter the final sleep.


So many sleep() makes me confused.
Anyway, your patch makes sense. so,

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../conformance/interfaces/mq_timedsend/5-1.c      |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> index 96daf72..77fe2e0 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> @@ -82,6 +82,9 @@ int main()
>  		sleep(1);  // give parent time to set up handler
>  		for (i=0; i<MAXMSG+1; i++) {
>          		mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
> +			/* make sure parent enter the final sleep */
> +			if (i == MAXMSG)
> +				sleep(1);
>  			/* send signal to parent each time message is sent */
>  			kill(getppid(), SIGABRT);
>  		}
> @@ -138,4 +141,4 @@ int main()
>  	}
>  
>  	return PTS_UNRESOLVED;
> -}
> \ No newline at end of file
> +}



------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
