Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QILN7-0006hS-QP
	for ltp-list@lists.sourceforge.net; Fri, 06 May 2011 13:47:09 +0000
Date: Fri, 6 May 2011 15:41:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110506134147.GA23206@saboteur.suse.cz>
References: <201104292305.31174.vapier@gentoo.org>
	<5da8d206a0df7808faed5039ade03c433af02abc.1304148727.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5da8d206a0df7808faed5039ade03c433af02abc.1304148727.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v5] thp testcase come from CVE reproducer
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> diff --git a/runtest/mm b/runtest/mm
> index f2d50d6..dded529 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -78,3 +78,5 @@ oom01 oom01
>  oom02 oom02
>  oom03 oom03
>  oom04 oom04
> +
> +thp01 thp01 -I 600

On my machine this runs for 10 minutes (-I 1 runs for more than
second). Is this amount of iterations really needed?

The rest looks good enough.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
