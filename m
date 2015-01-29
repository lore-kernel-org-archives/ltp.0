Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YGrRI-0006eJ-8L
	for ltp-list@lists.sourceforge.net; Thu, 29 Jan 2015 15:55:28 +0000
Date: Thu, 29 Jan 2015 16:55:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150129155518.GA16315@rei.suse.de>
References: <20150119122310.GA27065@rei>
	<CA+icZUV53AWik-bS4a3DwgExD26nhCWxJWb-kGN_nAOWsikuLA@mail.gmail.com>
	<CA+icZUVSnYv3-rh6sBr8vgDsc80Qnr3yK_OZ6AezVHPrDcKXbg@mail.gmail.com>
	<20150120115625.GB11013@rei>
	<CA+icZUW3=TkMvEzs3DXZYt0BC5JjUtXiCsVSt3ikHwxPyzu3=A@mail.gmail.com>
	<20150120132826.GA11824@rei>
	<CA+icZUV13kXzOBnf0Ck9_0UwJPSvKziOoy8_4jORQMzMvWC9LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUV13kXzOBnf0Ck9_0UwJPSvKziOoy8_4jORQMzMvWC9LQ@mail.gmail.com>
Subject: Re: [LTP] The Linux Test Project has been released for JANUARY 2015
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net, libc-alpha@sourceware.org, LKML <linux-kernel@vger.kernel.org>, lwn@lwn.net, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi!
> >> Yupp, that popped up.
> >> How can I disable that gvfsd (here: Ubuntu/precise?
> >
> > Just kill the process, or run the testcases via ssh session.
> >
> >> And can this issue be documented?
> >
> > Hmm, maybe we can change the test cases to complain loudly if the
> > process is found running.
> >
> 
> Good idea.

And should be fixed in latest git. Now the testcases complain about the
failure, give a hint what may be causing it, and if the umount() is not
the the syscall under test, it's retried a few times with short usleep
between.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
