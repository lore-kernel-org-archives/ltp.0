Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PzqBI-0002Jy-7C
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 12:50:28 +0000
Date: Wed, 16 Mar 2011 14:12:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110316131222.GD2096@saboteur.suse.cz>
References: <4D7E0425.7090509@redhat.com>
	<20110316120758.GA2096@saboteur.suse.cz>
	<4D80A5E1.2020002@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D80A5E1.2020002@redhat.com>
Subject: Re: [LTP] [PATCH] fs: fsstress: make test more POSIX compliant
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> >> -	if (no_xfs) {
> >> -		diob.d_miniosz = stb.st_blksize;
> >> -		diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
> >> -		diob.d_mem = stb.st_blksize;
> >> -	}
> >> +	diob.d_miniosz = stb.st_blksize;
> >> +	diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
> >> +	diob.d_mem = stb.st_blksize;
> > 
> > Hmm, why you are removing the if (no_xfs) here (I don't say it's wrong,
> > I only want to know why)?
> 
> The compiler gave warning that diob.d_* may not initialized. I don't
> know what the values diob.d_* should be if XFS exists (no_xfs == 0), but
> I guess they should be the same as when XFS not available.

Actually it's a little more complicated. This change breaks compilation
without -DNO_XFS (that is defined as default in Makefile).

The whole point of NO_XFS and no_xfs is that the test may be compiled
with and without xfs specialities as well as executed with and without
xfs specialities.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
