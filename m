Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QEkhi-0000go-MS
	for ltp-list@lists.sourceforge.net; Tue, 26 Apr 2011 16:01:34 +0000
Date: Tue, 26 Apr 2011 18:27:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110426162701.GB30153@saboteur.suse.cz>
References: <1624817233.26998.1303211901975.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20110426155618.GA28253@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110426155618.GA28253@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH v3] kill05: fix sporadic failures
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > 1. misusage of getpwnam causes ltpuser1 and ltpuser2 to point
> > to same passwd structure, from getpwnam(3):
> > "The return value may point to a static area, and may be overwritten by
> > subsequent calls to getpwent(3)."
> > Fix this by copying the results from returned pointer.
> 
> I see, that was caused by replacing the my_getpwnam() by
> SAFE_GETPWNAM().
> 
> Anyway my_getpwnam() is wrong hackend interface, we should get rid of
> it. For next time Garrett note that getpwnam() is one of these
> non-reentrant interfaces and do it correctly ;).

I've just commited a little better patch for the getpwnam() issue. Could
you please create patch that fixes the race condition only (against the
latest git).

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
