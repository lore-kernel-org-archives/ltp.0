Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJl49-0000OC-Qi
	for ltp-list@lists.sourceforge.net; Thu, 04 Oct 2012 13:02:13 +0000
Date: Thu, 4 Oct 2012 15:02:44 +0200
From: chrubis@suse.cz
Message-ID: <20121004130244.GB18130@saboteur.suse.cz>
References: <1344032944-27019-1-git-send-email-vlee@twitter.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1344032944-27019-1-git-send-email-vlee@twitter.com>
Subject: Re: [LTP] [PATCH] ltp_signal.h: Remove inline keyword from
 handler_h.
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
To: Vinson Lee <vlee@twitter.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/include/ltp_signal.h b/include/ltp_signal.h
> index 1ac6f70..093059f 100644
> --- a/include/ltp_signal.h
> +++ b/include/ltp_signal.h
> @@ -69,7 +69,7 @@ struct kernel_sigaction {
>  
>  void (*restore_rt) (void);
>  
> -inline void
> +void
>  handler_h (int signal)
>  {
>  	return;

I've just commited similar patch to this and added your signed-of-by.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
