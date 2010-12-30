Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYF6P-0005b4-Ly
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 09:47:21 +0000
Date: Thu, 30 Dec 2010 11:02:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230100245.GB14045@saboteur.suse.cz>
References: <AANLkTinfPDnAj15kpPX+om+JEQ569hUBG53GTkHjPF=Q@mail.gmail.com>
	<201012291129.36647.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201012291129.36647.vapier@gentoo.org>
Subject: Re: [LTP] port several ltp test cases for uClinux platform
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> this change is fine, but your e-mail client is word wrapping things and 
> munging the patch.  please resend after fixing that.

Well I'm not against porting testcases to any system, but rewriting all
occurences of fork() with FORK_OR_VFORK() seems like something that
should be fixed somewhere in system libraries or with LD_PRELOAD.

I know that on uClinux this could be hard to do, however IMHO this
breaks the rule "don't fix tests to work with broken systems".

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
