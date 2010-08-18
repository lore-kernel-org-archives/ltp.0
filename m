Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ole7Q-00052s-Vk
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 08:35:32 +0000
Received: from mail-bw0-f46.google.com ([209.85.214.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ole7M-0006FL-Ss
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 08:35:32 +0000
MIME-Version: 1.0
In-Reply-To: <1282116783.4855.8.camel@PEK-RLIANG-D1>
References: <1282116783.4855.8.camel@PEK-RLIANG-D1>
Date: Wed, 18 Aug 2010 01:35:22 -0700
Message-ID: <AANLkTikMdgDLAPOHAqH3qbLQsfLZoHuTYxi8PQTk8X8z@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal -
 11 --- exiting
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
To: renxiu liang <renxiu.liang@windriver.com>
Cc: ltp-list@lists.sf.net

On Wed, Aug 18, 2010 at 12:33 AM, renxiu liang
<renxiu.liang@windriver.com> wrote:
> Hi,
>
> We met the mtest06 failure several times; this is because in
> mtest06/mmap1.c, when handling the signal 11 in sig_handler, it doesn't
> cover another two race conditions:
> one is si_code equals "SEGV_MAPERR" but si_address does not equal to
> map_address; and one is si_code equals to "SEGV_ACCERR";
>
> see below error log:
>
> <<<test_start>>>
> tag=3Dmtest06 stime=3D1270902396
> cmdline=3D" =A0mmap1 -x 0.05"
> contacts=3D""
> analysis=3Dexit
> initiation_status=3D"ok"
> <<<test_output>>>
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0pid[5456]: map, change contents, unma=
p files
> 1000 times
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0created thread[1216369840]
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0pid[5456] - read contents of memory 0=
x48002000
> 1000 times
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
> ......
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
> mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
> caught unexpected signal - 11 --- exiting
> <<<execution_status>>>
> duration=3D1 termination_type=3Dexited termination_id=3D255 corefile=3Dno
> cutime=3D0 cstime=3D4
> <<<test_end>>>
>
> I made a patch to cover all the three race conditions in one case in
> sig_handler(),
> then run mtest06 repeatedly on different archs, test will not fail by
> catching signal 11.
>
> See attached patch.

    I saw the first email :)... I just hadn't gotten an opportunity to
look at the manpage to see whether or not what you're proposing makes
sense.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
