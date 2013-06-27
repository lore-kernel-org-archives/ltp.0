Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsAmZ-0002Fc-No
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 11:54:35 +0000
Date: Thu, 27 Jun 2013 13:56:02 +0200
From: chrubis@suse.cz
Message-ID: <20130627115602.GA5384@rei>
References: <1372208571-9642-1-git-send-email-sedat.dilek@gmail.com>
	<20130626132415.GB16146@rei.suse.cz>
	<CA+icZUWQfEvPne5fiqqyv556dU7LGoNTHri3F5guJKL8UjALyQ@mail.gmail.com>
	<CA+icZUVig_VuU5vrom5spHVC=A4o-L7wGxA0rc+FD_h+x7jd-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUVig_VuU5vrom5spHVC=A4o-L7wGxA0rc+FD_h+x7jd-g@mail.gmail.com>
Subject: Re: [LTP] [PATCH] runtest: Add new syscalls-ipc test-suite
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Yeah, I had that in mind, but as the included test-cases hit other
> > areas I thought about "syscallc-ipc".
> > Might be a good choice for IPC testers to have all tests in runtest/ipc file.
> > I am OK with that.
> >
> 
> Shall I send a v2?

Yes, please.

> Where shall I put the syscalls-ipc test-cases - at the end?
> ...and place some comments?

I would do so and I would add short comment before the newly added ones
that these were added from syscalls or so.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
