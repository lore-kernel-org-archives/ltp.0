Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NXoEU-0003r7-AY
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 04:01:22 +0000
Received: from out04.sjc.mx.trendmicro.com ([216.99.131.8])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NXoER-0005Bu-IR
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 04:01:21 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000701ca998a$51aed7b0$f50c8710$@co.jp>
	<364299f41001200525v31721544t521c73aceaa4b515@mail.gmail.com>
In-Reply-To: <364299f41001200525v31721544t521c73aceaa4b515@mail.gmail.com>
Date: Thu, 21 Jan 2010 13:01:09 +0900
Message-ID: <000001ca9a4e$5daaed50$1900c7f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] 2010-01-20 cvs build failed
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garrett,


>Solved. Typo that I didn't pick up earlier..

I succeeded to build in RHEL5.4 system with 2010-01-21 cvs.

>You have to use make all when compiling `all' with make instead of just
specifying `make' with 3.81 because make 3.80 doesn't have a concept of
default goals/targets.

Thank you for your advice.
It was my mistake.
I succeeded to build in RHEL4.8 system by using "make3.80"!
Great!


Thank you--


-Tomonori Mitani


-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] =

Sent: Wednesday, January 20, 2010 10:26 PM
To: Mitani
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] 2010-01-20 cvs build failed

On Tue, Jan 19, 2010 at 8:37 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Thank you for your great effort for "make3.80" supporting.
>
> But in my system, there are several problems.
>
> Because it is necessary to report about them hastily, I report them
> without investigation first of all.
>
> I tried to make with 2010-01-20 version cvs in my several systems.
> =A0- RHEL5.4 x86
> =A0- RHEL5.4 x86_64
> =A0- RHEL5.4 ia64
> =A0- RHEL4.8 x86 (using make3.80/3.81)
> =A0- RHEL4.8 x86_64 (using make3.80/3.81)
>
> I show below the results.
>
>
> 1) <RHEL5.4 x86>
> "make" succeeded, but "make install" failed as follows:
> ------------
> mkdir -m 00755 -p "//opt/ltp"
> mkdir -m 00755 -p "//opt/ltp/bin"
> make -C "doc" \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-f "/home/LTP/ltp-2010-01-20/doc/Makefile"=
 install
> make[1]: Entering directory `/home/LTP/ltp-2010-01-20/doc'
> make[2]: Entering directory `/home/LTP/ltp-2010-01-20/doc/man1'
> make[2]: *** No rule to make target `/opt/ltp/share/man/man1', needed by
> `/opt/ltp/share/man/man1/doio.1'. =A0Stop.
> make[2]: Leaving directory `/home/LTP/ltp-2010-01-20/doc/man1'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/home/LTP/ltp-2010-01-20/doc'
> make: *** [doc-install] Error 2
> ------------

Solved. Typo that I didn't pick up earlier..

> 2) <RHEL5.4 x86_64>
> 3) <RHEL5.4 ia64>
> 4) <RHEL4.8 x86> (using make3.81)
> 5) <RHEL4.8 x86_64> (using make3.81)
> In above systems, results were same as <RHEL5.4 x86>.
>
>
> 6) <RHEL4.8 x86> (using make3.80)
> Strangely, the "make" command returned immediately.
> "echo $?" was 0. But log was only several lines as follows:

You have to use make all when compiling `all' with make instead of
just specifying `make' with 3.81 because make 3.80 doesn't have a
concept of default goals/targets.

> ------------
> make -C testcases/realtime autotools
> make[1]: Entering directory `/home/LTP/ltp-2010-01-20/testcases/realtime'
> autoheader
> make[1]: Leaving directory `/home/LTP/ltp-2010-01-20/testcases/realtime'
> ------------
>
> Is this message same as what is written in the "INSTALL" file?
>
> Just in case, I tried "make install".
> But the result was as follows:
>
> ------------
> make -C "pan" \
> =A0 =A0 =A0 =A0-f "/home/LTP/ltp-2010-01-20/pan/Makefile" install
> make[1]: Entering directory `/home/LTP/ltp-2010-01-20/pan'
> test -d "/opt/ltp/bin" || mkdir -p "/opt/ltp/bin"
> install -m 00775 "/home/LTP/ltp-2010-01-20/pan/ltp-bump"
> "/opt/ltp/bin/ltp-bump"
> install: cannot stat `/home/LTP/ltp-2010-01-20/pan/ltp-bump': No such file
> or directory
> make[1]: *** [/opt/ltp/bin/ltp-bump] Error 1
> make[1]: Leaving directory `/home/LTP/ltp-2010-01-20/pan'
> make: *** [pan-install] Error 2
> ------------
>
>
> 7) <RHEL4.8 x86_64> (using make3.80)
> Results were same as <RHEL4.8 x86> (using make3.80).

HTH,
-Garrett



---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
