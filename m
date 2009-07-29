Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWEJQ-0006uR-LO
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 18:55:40 +0000
Received: from mail-pz0-f180.google.com ([209.85.222.180])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWEJP-0000js-Q7
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 18:55:40 +0000
Received: by pzk10 with SMTP id 10so25975pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 11:55:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
Date: Wed, 29 Jul 2009 11:55:33 -0700
Message-ID: <364299f40907291155p52d2aa90jd73ecc9818aa6c6a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, Jul 29, 2009 at 11:33 AM, Kumar Gala<galak@kernel.crashing.org> wro=
te:
> I get the following compile error:
>
> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/fstat'
> make[4]: Entering directory `/root/ltp/testcases/kernel/syscalls/
> fstatat'
> cc -Wall =A0-I../../include -g -Wall -I../../../../include -Wall -
> DTST_USE_NEWER64_SYSCALL=3D1 -D_FILE_OFFSET_BITS=3D64 =A0 -c -o
> fstatat01_64.o fstatat01.c
> fstatat01.c:95:37: error: missing binary operator before token "5"
> fstatat01.c: In function 'main':
> fstatat01.c:126: error: expected ')' before numeric constant
> make[4]: *** [fstatat01_64.o] Error 1
> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/fstatat'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp/testcases'
> make: *** [all] Error 2

Got config.log?
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
