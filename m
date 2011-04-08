Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q8CeN-0001jU-MY
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 14:27:03 +0000
Date: Fri, 8 Apr 2011 16:50:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110408145056.GB21327@saboteur.suse.cz>
References: <4D9DA7A1.7000901@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D9DA7A1.7000901@redhat.com>
Subject: Re: [LTP] mem/libmm usage?
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
> Hi, in mem/libmm directory, I found there's a library libmm.a been
> built, and mem/ dir, hugetlb/ dir both include the lib in their
> Makefiles, However, I can't see who is using the functions in the lib.
> Anyone who knows its usage, or it could be removed from mem/ dir?

It seems that most of the tests links against this library. Also it
seems that they don't need to. And the makefiles in mem/ are little
messed up.

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
