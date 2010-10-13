Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hakehuang@gmail.com>) id 1P5tun-0006eu-MO
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 05:30:13 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5tum-0007n3-P4
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 05:30:13 +0000
Received: by gya1 with SMTP id 1so985098gya.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 22:30:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=-CoyH2++-d45KaWq0ZzUsxaQUXN4g4q-vQYrb@mail.gmail.com>
References: <AANLkTimb=F0NaS+Sipp8EzrbRUqPqRf+9-nBZQMPpD=w@mail.gmail.com>
	<AANLkTimhAOpaWN7KDwg_PCQ=_j81A1fddRe5_KaB+RLY@mail.gmail.com>
	<AANLkTinOLVvd1B90s3Hn735YqH+Ku=BmUwyu-w1yZK_Y@mail.gmail.com>
	<AANLkTi=-CoyH2++-d45KaWq0ZzUsxaQUXN4g4q-vQYrb@mail.gmail.com>
Date: Wed, 13 Oct 2010 13:30:07 +0800
Message-ID: <AANLkTin4N8BpJ5xXs8TAV+1xQNjTEO+KzO6h=ZJVjv08@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: Re: [LTP] Patch to record kernel dump message to each testcases log
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

2010/10/13 Garrett Cooper <yanegomi@gmail.com>
>
> On Tue, Oct 12, 2010 at 9:38 PM, hake huang <hakehuang@gmail.com> wrote:
> > Hi
> >
> > I see this simple solution is no quite fit. But the kernel dump message=
 for
> > each test case is necessary for analysing. I can work on this further, =
with
> > below help:
> > 1. Where can I find the reason for the IIRC break?
>
> IIRC -> If I remember correctly.
so I need ask Subrata about this problem, right? what is the existing
functionality?
>
> > 2. Can it=A0 be an option to avoid the size limitation on some embedded
> > system?
>
> No. This is outside the realm of LTP, but we must remain conscious of
> the fact that there are folks running LTP on cellphones, etc, where
> space is very much a luxury.
I see. but why can't they run in quit_mode?
>
> > 3.=A0 A kind of seperating tag is needed for kernel message, right? e.g
> > <kernel_dump_start>dump message<kernel_dump_end>
>
> I think that adding an optional capture feature might be worthwhile,
> but you'll no doubt quickly find with some processes that the dmesg
> buffer will fill up quickly.
I have seen such events, and such cases need to be checked manually.
>
> > 4.=A0 I see in ltp-pan.c the file descriptors, terminals are changed in=
 child
> > process. if the system(3) has problem, the worst cases is there are no
> > kernel messge output in parent process, but the pan can still function =
well.
>
> Can you say that with 100% certainty? One of the potential problems
> with system is the fact that it allocates a shell and depending on how
> processes are executed and how file descriptors are cleaned up,
>
> Actually, pan makes zero attempts at closing open file descriptors and
> the like, so the problem is still very much with pan.
>
So your concerns is about file descriptors which open in ltp process,
I think this is an existing problem. I mean maybe pan need to attempt
to close open file descriptors. system(3) only increases the change of
occurrence caused by this problem, right?
> > if not use system(3), can you give your suggestion on this, exec(3) see=
ms to
> > have the same problem as system(3)?
>
> Yes and no. In this case the problems that exist with open file
> descriptor inheritance, etc are unfortunately no worse from that
> perspective than your proposed code would do, but there are still
> other problems that need to be resolved with your proposed change
> anyhow that are much more pressing.
>
> -Garrett

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
