Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S56zO-0005CH-FE
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 02:52:30 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S56zN-0006X7-N9
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 02:52:30 +0000
Received: by obqv19 with SMTP id v19so9387115obq.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 06 Mar 2012 18:52:24 -0800 (PST)
Message-ID: <4F56CD2B.8060308@casparzhang.com>
Date: Wed, 07 Mar 2012 10:51:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1331029739-32353-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1331029739-32353-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH] runltp: Remove excess quotes from final message
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
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

On 03/06/2012 06:28 PM, Markos Chandras wrote:
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  runltp |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/runltp b/runltp
> index 4ef8b38..fc3515b 100755
> --- a/runltp
> +++ b/runltp
> @@ -948,11 +948,11 @@ main()
>      {
>      cat <<-EOF >&1
>          
> -       ###############################################################"
> +       ###############################################################
>          
> -            Done executing testcases."
> +            Done executing testcases.
>              LTP Version:  $version_date
> -       ###############################################################"
> +       ###############################################################
>         
>  	EOF
>      }

Hi, Committed.

Thanks,
Caspar

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
