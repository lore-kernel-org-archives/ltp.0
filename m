Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NH5Vc-0004ia-Aq
	for ltp-list@lists.sourceforge.net; Sun, 06 Dec 2009 01:01:56 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NH54m-0002qC-Bb
	for ltp-list@lists.sourceforge.net; Sun, 06 Dec 2009 00:34:19 +0000
Received: by pwi12 with SMTP id 12so3064555pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Sat, 05 Dec 2009 16:32:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b193d10.4744f10a.7383.ffffd215SMTPIN_ADDED@mx.google.com>
References: <4b193d10.4744f10a.7383.ffffd215SMTPIN_ADDED@mx.google.com>
Date: Sat, 5 Dec 2009 16:32:51 -0800
Message-ID: <364299f40912051632w51afa950ubc51d6f3ebac0e7c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix the objdump test's makefile (and reenable it)
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 4, 2009 at 8:42 AM, Jiri Palecek <jpalecek@web.de> wrote:
> Hello,
>
> the objdump tests' Makefile is disabled in the current LTP. This patch re=
enables it, and makes it work (at least for me).
>
> Regards
> =A0 =A0Jiri Palecek
>
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> ---
> =A0testcases/commands/ade/Makefile =A0 =A0 =A0 =A0 | =A0 =A03 ---
> =A0testcases/commands/ade/objdump/Makefile | =A0 =A06 +++---
> =A02 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/commands/ade/Makefile b/testcases/commands/ade/Mak=
efile
> index cf7a487..9f57629 100644
> --- a/testcases/commands/ade/Makefile
> +++ b/testcases/commands/ade/Makefile
> @@ -24,7 +24,4 @@ top_srcdir =A0 =A0 =A0 =A0 =A0 =A0?=3D ../../..
>
> =A0include $(top_srcdir)/include/mk/env_pre.mk
>
> -# XXX (garrcoop): objdump's Makefile needs fixing.
> -FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D objdump
> -
> =A0include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/commands/ade/objdump/Makefile b/testcases/commands=
/ade/objdump/Makefile
> index 862438c..ed3ad26 100644
> --- a/testcases/commands/ade/objdump/Makefile
> +++ b/testcases/commands/ade/objdump/Makefile
> @@ -27,13 +27,13 @@ include $(top_srcdir)/include/mk/env_pre.mk
> =A0test: CPPFLAGS +=3D -O
>
> =A0test_arch.obj: test.o
> - =A0 =A0 =A0 mv $< "$@"
> + =A0 =A0 =A0 cp $< "$@"
>
> =A0test_D: test.o
> - =A0 =A0 =A0 $(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION) $@
> + =A0 =A0 =A0 $(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
>
> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D objdump01
> -
> +
> =A0MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D test test_arch.obj test_D
>
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk

Just committed a similar set of fixes to what you proposed above, as
the test itself wasn't clear...

As noted by Jiri, the objdump tests were disabled in the
infrastructure upgrade because they didn't fit exactly into the new
infrastructure.

1. Makefile: Reenable the test.
2. objdump/Makefile: Fix compilation so that it deterministically
compiles with -g (needed for the test, even though it currently fails
because objdump expects DWARF and that's currently unsupported with
ld(1) from what I've been reading).
3. objdump/test.c -> objdump/test_arch.c: for the sake of clarity and
to ensure that the command doesn't conflict with test(1), rename
test.c to test_arch.c.
4. objdump/objdump01: Clarify the purpose and error check --debugging
in the test.

Props go to Jiri for the original observations and suggestions.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. =

Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
