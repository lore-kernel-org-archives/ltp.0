Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsCA0-0005Y7-Iz
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 13:22:52 +0000
Date: Thu, 27 Jun 2013 15:24:23 +0200
From: chrubis@suse.cz
Message-ID: <20130627132422.GA21560@rei>
References: <1372336933-2770-1-git-send-email-sedat.dilek@gmail.com>
	<51CC37E2.20304@ti.com>
	<CA+icZUW2hCKtEV-yvYSDrnuVW=MmB0ywTvKTPnStqWgmiAhKmg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUW2hCKtEV-yvYSDrnuVW=MmB0ywTvKTPnStqWgmiAhKmg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] runtest/ipc: Add some IPC syscalls test-cases
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
> >> Add IPC syscalls test-cases from "runtest/syscalls" file also to
> >> "runtest/ipc" for people interested in running IPC tests only.
> >>
> >> Run via './runltp -f ipc'.
> >>
> >> Signed-off-by: Sedat Dilek<sedat.dilek@gmail.com>
> >> ---
> >>   runtest/ipc | 60
> >> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 60 insertions(+)
> >
> >
> > NAK. Duplication is generally a bad idea.
> > This have the side effect of running the same tests twice for people that
> > run ipc and syscalls test scenarios.
> >
> 
> The background of this was an issue in Linux-Next.
> The ipc test-cases were fine, but syscalls test-cases revealed that
> sth. was wrong in that Linux-Next release.
> For me it was not clear to also test the syscalls.
> 
> So, what is with the idea of a "runtest/syscalls-ipc" file (my
> original "v1" patch, this here is "v2")?

I think that we can go with the v1 for now and figure out something
better for the new test execution framework. Are you OK with that?

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
