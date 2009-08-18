Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MdPce-0006Ox-Uc
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 14:25:12 +0000
Received: from mail-yw0-f185.google.com ([209.85.211.185])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdPce-00005Y-1m
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 14:25:12 +0000
Received: by ywh15 with SMTP id 15so5060724ywh.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Aug 2009 07:25:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40908172344o62861d02rc8e0c3f87de80134@mail.gmail.com>
References: <f5a7b3810908170937u516ee718yd6db8df547752bc4@mail.gmail.com>
	<364299f40908172344o62861d02rc8e0c3f87de80134@mail.gmail.com>
Date: Tue, 18 Aug 2009 19:55:06 +0530
Message-ID: <f5a7b3810908180725l326c08f1l863f8d17c74f0a95@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX PATCHE]ltp-fix-posix-mq_send_5-1 warning
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

On Tue, Aug 18, 2009 at 12:14 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Mon, Aug 17, 2009 at 9:37 AM, naresh kamboju<naresh.kernel@gmail.com> =
wrote:
>> Hi,
>>
>> I have noticed build warnings for the following test case.
>> This patch will fix warnings by removing unused variables in test code.
>>
>> I have attached patch and below
>> Please review the same
>
Hi,
> =A0 =A0Log before and after?

Build log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Before patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
conformance/interfaces/mq_send/5-1: build: FAILED: Compiler output:
cc1: warnings being treated as errors
In file included from conformance/interfaces/mq_send/5-1.c:40:
include/mq_send.h: In function 'sync_pipe_wait_select':
include/mq_send.h:49: warning: unused variable 'buf'
conformance/interfaces/mq_send/5-1.c: In function 'main':
conformance/interfaces/mq_send/5-1.c:107: warning: unused variable 'r'
conformance/interfaces/mq_send/5-1.c:105: warning: unused variable 'act'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
After patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
conformance/interfaces/mq_send/5-1: build: PASS
conformance/interfaces/mq_send/5-1: link: PASS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
