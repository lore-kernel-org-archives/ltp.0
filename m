Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q7UJ0-0000yE-KB
	for ltp-list@lists.sourceforge.net; Wed, 06 Apr 2011 15:06:02 +0000
Date: Wed, 6 Apr 2011 17:29:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110406152944.GA12317@saboteur.suse.cz>
References: <1301695288-24912-1-git-send-email-aelder@sgi.com>
	<26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
	<20110406130522.GB6652@saboteur.suse.cz>
	<1302102133.2505.26.camel@doink>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1302102133.2505.26.camel@doink>
Subject: Re: [LTP] [PATCH 1/6] ltp: fix databinchk() definition
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
To: Alex Elder <aelder@sgi.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > -void databinchedk( int mode, unsigned char *buffer, int bsize, int offset, char **errmsg);
> > > +int databinchk( int mode, char *buffer, int bsize, int offset, char **errmsg);
> > 
> > You've forgotten to remove the space here "databinchk( int".
> 
> I'll happily fix that (or whoever commits it is welcome to).
> I was just preserving the exiting formatting.  Might as well
> drop the spaces in the declaration of databingen() next to it
> as well.

Okay. So I'll commit this as it is. Feel free to send another patch that
fixes the whitespace madness.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
