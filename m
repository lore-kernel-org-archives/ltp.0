Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MeAsE-0002Nb-NN
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:52:26 +0000
Received: from qw-out-1920.google.com ([74.125.92.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MeAs8-0003lN-D5
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:52:26 +0000
Received: by qw-out-1920.google.com with SMTP id 5so20184qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Aug 2009 09:52:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090820160705.30926.960.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160705.30926.960.sendpatchset@localhost.localdomain>
Date: Thu, 20 Aug 2009 09:52:15 -0700
Message-ID: <364299f40908200952l402269bfy65eb0fc3f50702bc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch to fix make install issue in ebizzy
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

On Thu, Aug 20, 2009 at 9:07 AM, Poornima
Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> install: was missing in Makefile of ebizzy, hence make install was throwi=
ng error.
> This patch will fix make install error.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
>
> diff -uprN ltp-full-20090731_orig/utils/benchmark/ebizzy-0.3/Makefile ltp=
-full-20090731/utils/benchmark/ebizzy-0.3/Makefile
> --- ltp-full-20090731_orig/utils/benchmark/ebizzy-0.3/Makefile =A02009-08=
-20 19:59:13.000000000 +0530
> +++ ltp-full-20090731/utils/benchmark/ebizzy-0.3/Makefile =A0 =A0 =A0 200=
9-08-20 20:23:19.000000000 +0530
> @@ -4,5 +4,7 @@ configure:
> =A0 =A0 =A0 =A0./configure
> =A0ebizzy: configure
> =A0 =A0 =A0 =A0gcc -Wall -Wshadow -lpthread =A0-o ebizzy ebizzy.c
> +install:
> +
> =A0clean:
> =A0 =A0 =A0 =A0rm -f ebizzy *~

No need to address this. It's already been addressed in my
makefile-infra-rework patch.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
