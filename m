Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MeAtD-0002VG-PZ
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:53:27 +0000
Received: from qw-out-1920.google.com ([74.125.92.145])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MeAt9-0006Rx-KV
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:53:27 +0000
Received: by qw-out-1920.google.com with SMTP id 5so20657qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Aug 2009 09:53:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Date: Thu, 20 Aug 2009 09:53:16 -0700
Message-ID: <364299f40908200953v3ce12243y6956cbbc679b9edd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch to fix kernbench integration issue
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

On Thu, Aug 20, 2009 at 9:06 AM, Poornima
Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> Kernbench script's mode was not getting modified to executable as 'utils =
install'
> was missing in LTP Makefile. Hence this patch fixes this issue.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-full-20090731_orig/Makefile ltp-full-20090731/Makefile
> --- ltp-full-20090731_orig/Makefile =A0 =A0 2009-08-20 19:59:13.000000000=
 +0530
> +++ ltp-full-20090731/Makefile =A02009-08-20 20:19:09.000000000 +0530
> @@ -40,6 +40,7 @@ install: all
> =A0 =A0 =A0 =A0@$(MAKE) -C m4 install
> =A0 =A0 =A0 =A0@$(MAKE) -C doc/man1 install
> =A0 =A0 =A0 =A0@$(MAKE) -C doc/man3 install
> + =A0 =A0 =A0 @$(MAKE) -C utils install
> =A0ifneq ($(strip $(SKIP_IDCHECK)),1)
> =A0 =A0 =A0 =A0@./IDcheck.sh
> =A0endif

No need to worry about this item either. It's already addressed in my
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
