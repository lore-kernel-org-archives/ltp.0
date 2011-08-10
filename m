Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qr7aM-0008My-Ls
	for ltp-list@lists.sourceforge.net; Wed, 10 Aug 2011 12:08:34 +0000
Date: Wed, 10 Aug 2011 14:12:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110810121222.GC3179@saboteur.suse.cz>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
	<1309414787-2022-6-git-send-email-yanpai.chen@gmail.com>
	<20110729114534.GA29831@saboteur.suse.cz>
	<CANj_sbC3+eO+6=_S4MO8Wr1o6b7Oo9mbX=EehBFaQb6dj=xOww@mail.gmail.com>
	<CAGH67wROk8oOO85TVCZxfNofy2M1NdQXPTkuEHezgUJy8Jx-zw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH67wROk8oOO85TVCZxfNofy2M1NdQXPTkuEHezgUJy8Jx-zw@mail.gmail.com>
Subject: Re: [LTP] [PATCH 6/7] runtest/fs: change parameters of growfiles
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
Cc: ltp-list@lists.sourceforge.net, ypchen@faraday-tech.com

> >>> --- a/ltp-full-20101031/runtest/fs
> >>> +++ b/ltp-full-20101031/runtest/fs
> >>> @@ -14,9 +14,9 @@ gf12 mkfifo $TMPDIR/gffifo17; growfiles -b -W gf12 =
-e 1 -u -i 0 -L 30 $TMPDIR/gf
> >>> =A0gf13 mkfifo $TMPDIR/gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L=
 30 -I r -r 1-4096 $TMPDIR/gffifo18
> >>> =A0gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 -f g=
lseek19 -S 2 -d $TMPDIR
> >>> =A0gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 -=
f Lgfile1 -d $TMPDIR
> >>> -gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 4089=
90 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
> >>> -gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 4999=
90 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
> >>> =A0gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -=
l -S 2 -f Lgf04_ -d $TMPDIR
> >>> +gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 101 -t 4089=
90 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
> >>> +gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 101 -t 4999=
90 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
> >>> =A0gf19 growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I=
 p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_ -d $TMPDIR
> >>> =A0gf20 growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-25=
6000:512 -R 512-256000 -T 4 -f gfbigio-$$ -d $TMPDIR
> >>> =A0gf21 growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 2048=
0 -T 10 -t 20480 -f gf-bld-$$ -d $TMPDIR
> >>
> >> Any reason why you have changed the order of the execution (the gf18 n=
ow preceeds gf16 and gf17)?
> >>
> > Sorry, that's my mistake.
> > I will resend the patch later.
> >
> >> Also I'm not sure if 'shrinking on the same file' wasn't intentional
> >> (most likely not but I'm not sure yet).
> >>
> > We made the patch here for the following problem:
> > gf16/gf17 create 10 files and keep them growing and shrinking.
> > But shrinking on the same file leads the others to be growing only
> > which may cause the tests run out of memory.
> =

> Keep things simple. Each testcase should operate on a fresh file
> (mk*temp generated filename) to ensure determinism and avoid potential
> issues with execution ordering, memory starvation, etc.

Not really the case here. The tests itself plays with several files at
once making them grow and shrink.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
uberSVN's rich system and user administration capabilities and model =

configuration take the hassle out of deploying and managing Subversion and =

the tools developers use with it. Learn more about uberSVN and get a free =

download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
