Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YqLkE-00017g-21
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 13:21:42 +0000
Date: Thu, 7 May 2015 15:21:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150507132107.GC28637@rei.suse.de>
References: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430897176-16486-2-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1430897176-16486-2-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/5] kernel/syscalls/ipc/lib: Don't allocate
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

Hi!
>  int getuserid(char *user)
>  {
> -	struct passwd *ent;
> -
> -	/* allocate some space for the passwd struct */
> -	if ((ent = malloc(sizeof(struct passwd))) == NULL) {
> -		tst_brkm(TBROK, cleanup, "couldn't allocate space for passwd"
> -			 " structure");
> -	}
> +	struct passwd *ent = NULL;

Why do you initialize the pointer with NULL? If it's only used to store
the return from getpwnam()...

Otherwise, this is a good catch :)

-- 
Cyril Hrubis
chrubis@suse.cz

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
