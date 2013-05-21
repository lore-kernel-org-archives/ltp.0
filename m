Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Uecod-0002tg-6R
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 03:00:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UecoZ-0006Wk-P2
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 03:00:43 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4L30SHY003087
	for <ltp-list@lists.sourceforge.net>; Tue, 21 May 2013 11:00:28 +0800
Message-ID: <519AE2BB.2070708@cn.fujitsu.com>
Date: Tue, 21 May 2013 10:58:03 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <519477E5.4030807@cn.fujitsu.com>
In-Reply-To: <519477E5.4030807@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] prot_hsymlinks.c: remove the unnecessary calling
 of cleanup
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

Hi,
sirs

any comment for this patch?

This unnecessary calling of cleanup() will cause TC prot_hsymlinks
failing when kernel is older than 3.7.0.

On 05/16/2013 02:08 PM, DAN LI wrote:
> 
> Should not call cleanup here since nothing was setted by setup.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
> b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
> index 1eec0f9..82bc770 100644
> --- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
> +++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
> @@ -196,10 +196,9 @@ static void setup(int argc, char *argv[])
> 
>  	tst_require_root(NULL);
> 
> -	if (tst_kvercmp(3, 7, 0) < 0) {
> -		tst_brkm(TCONF, cleanup,
> +	if (tst_kvercmp(3, 7, 0) < 0)
> +		tst_brkm(TCONF, NULL,
>  			"Test must be run with kernel 3.7 or newer");
> -	}
> 
>  	/* initialize user names */
>  	strcpy(users[ROOT].name, "root");
> 



------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
