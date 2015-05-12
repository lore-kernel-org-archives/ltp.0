Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Ys59Z-0007G6-13
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 08:03:01 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ys59Y-0007ME-2W
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 08:03:01 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4C81VEa028594
	for <ltp-list@lists.sourceforge.net>; Tue, 12 May 2015 16:01:32 +0800
Message-ID: <5551B385.6080506@cn.fujitsu.com>
Date: Tue, 12 May 2015 16:02:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/5] kernel/syscalls/ipc/lib: Don't allocate
 memory for getpwnam()
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net


Applied all, thank you.

Wanlong Gao

On 05/12/2015 02:27 PM, Wei,Jiangang wrote:
> The getpwnam() function returns a pointer for a passwd
> structure. So,
> It's enough to declare a pointer to this structure,
> not to allocate memory for it.
> 
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/ipc/lib/libipc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/lib/libipc.c b/testcases/kernel/syscalls/ipc/lib/libipc.c
> index f10e257..4de7faa 100644
> --- a/testcases/kernel/syscalls/ipc/lib/libipc.c
> +++ b/testcases/kernel/syscalls/ipc/lib/libipc.c
> @@ -143,12 +143,6 @@ int getuserid(char *user)
>  {
>  	struct passwd *ent;
>  
> -	/* allocate some space for the passwd struct */
> -	if ((ent = malloc(sizeof(struct passwd))) == NULL) {
> -		tst_brkm(TBROK, cleanup, "couldn't allocate space for passwd"
> -			 " structure");
> -	}
> -
>  	/* get the uid value for the user */
>  	if ((ent = getpwnam(user)) == NULL) {
>  		tst_brkm(TBROK, cleanup, "Couldn't get password entry for %s",
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
