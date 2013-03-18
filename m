Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UHbBa-0004qR-DA
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 14:37:14 +0000
Date: Mon, 18 Mar 2013 15:37:50 +0100
From: chrubis@suse.cz
Message-ID: <20130318143750.GF3423@rei>
References: <20130318132626.GD3423@rei>
	<1209119378.20265155.1363614409485.JavaMail.root@redhat.com>
	<CAG2jQ8i1oovEVtF2hayXzeBzpWb78q=ntN_EJ3w0KJ3KpeXCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG2jQ8i1oovEVtF2hayXzeBzpWb78q=ntN_EJ3w0KJ3KpeXCzQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4] syscalls/getdents: Add parameter to test
 getdents64 syscall
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
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> > > You don't need to bother to free the buffers when the next thing
> >> > > the
> >> > > test does is exit, the whole heap along with malloc data
> >> > > structures
> >> > > will
> >> > > be freed (unmapped) by the kernel anyway.
> >> >
> >> > I think it's nice thing to cleanup. Say, if test corrupted heap,
> >> > free could alert you. Also there are tools, which may complain,
> >> > that there's a leak now. I think LTP supports at least valgrind.
> >>
> >> So what about compromise, defining them as variables instead of the
> >> allocation?
> >
> > That would work. You really want that free() gone, don't you? :-).
> >
> 
> Yeah I was about to ask the same thing. I see no problem with keeping free()
> around and I don't think there is an urgent need to convert these
> pointers to variables.

I've changed them to be variables and the getdents64 now seems to
segfault randomly. I will look closely at the code, my guess is that
the size of the structure is counted/propagated wrongly somewhere.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
