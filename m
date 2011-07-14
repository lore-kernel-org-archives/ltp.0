Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QhKba-00073k-SF
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 12:01:22 +0000
Date: Thu, 14 Jul 2011 14:02:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110714120257.GA4811@saboteur.suse.cz>
References: <1310479114-19326-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310479114-19326-1-git-send-email-carmelo.amoroso@st.com>
Subject: Re: [LTP] [PATCH] shmctl01: fix misaligned access
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> On architecture that are not able to handle in hardware
> misaligned access, it could cause the application to be killed by a SIGBUS
> 
> So, the following simple assignment
> 
> void *test;
> *(int *)test = stat_i;
> 
> causes on SH4 the following error:
> 
> Unaligned userspace access in "shmctl01" pid=8547 pc=0x0040221a ins=0x400b
> Sending SIGBUS to "shmctl01" due to unaligned access (PC 40221a PR 40221e)
> 
> Using a 'memcpy' is safe.

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AppSumo Presents a FREE Video for the SourceForge Community by Eric 
Ries, the creator of the Lean Startup Methodology on "Lean Startup 
Secrets Revealed." This video shows you how to validate your ideas, 
optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
