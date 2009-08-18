Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MdPfA-0002HI-GM
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 14:27:48 +0000
Received: from mail-yw0-f185.google.com ([209.85.211.185])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdPf4-0003gC-NA
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 14:27:43 +0000
Received: by ywh15 with SMTP id 15so5063266ywh.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Aug 2009 07:27:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40908172345o21a2d7a8j11a41eeb8455f596@mail.gmail.com>
References: <f5a7b3810908170941n6885b036ub45f9d14ec5c3768@mail.gmail.com>
	<364299f40908172345o21a2d7a8j11a41eeb8455f596@mail.gmail.com>
Date: Tue, 18 Aug 2009 19:57:37 +0530
Message-ID: <f5a7b3810908180727i7ddbcab4t3b0d74c2f1ac0e6@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX PATCH] ltp-fix-posix-sched_setparam_26-1 warning fix
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Brandon Philips <bphilips@suse.de>

On Tue, Aug 18, 2009 at 12:15 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Mon, Aug 17, 2009 at 9:41 AM, naresh kamboju<naresh.kernel@gmail.com> =
wrote:
>> Hi,
>>
>> I have noticed build warnings for the following test case.
>> This patch will fix warnings by adding <string.h> header file.
>>
>> I have attached patch and below
>> Please review the same
>
Hi,
> =A0 =A0Log before and after?

Build log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Before patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
conformance/interfaces/sched_setparam/26-1: build: FAILED: Compiler output:
cc1: warnings being treated as errors
conformance/interfaces/sched_setparam/26-1.c: In function 'set_nonroot':
conformance/interfaces/sched_setparam/26-1.c:30: warning: implicit
declaration of function 'strcmp'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
After patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
conformance/interfaces/sched_setparam/26-1: build: PASS
conformance/interfaces/sched_setparam/26-1: link: PASS

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Best regards
Naresh Kamboju
> Thanks,
> -Garrett
>

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
