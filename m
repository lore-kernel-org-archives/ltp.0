Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MTFJ0-0002RC-9f
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:22:54 +0000
Received: from mail-gx0-f220.google.com ([209.85.217.220])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTFIu-0005Bp-Tp
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:22:54 +0000
Received: by gxk20 with SMTP id 20so15054808gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 06:22:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090721044529.GB9807@jenkins.home.ifup.org>
References: <f5a7b3810906300005q2cafdd3dtfe4d659ae6834bb@mail.gmail.com>
	<20090721044529.GB9807@jenkins.home.ifup.org>
Date: Tue, 21 Jul 2009 18:52:47 +0530
Message-ID: <f5a7b3810907210622o1539087al1eca42cc900e9a02@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [PATCH v2] mq_send/5-1.c: Fix race conditions in the test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Brandon Philips <bphilips@suse.de>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>

On Tue, Jul 21, 2009 at 10:15 AM, Brandon Philips<bphilips@suse.de> wrote:
> On 12:35 Tue 30 Jun 2009, naresh kamboju wrote:
>> I have noticed some issue with your patch dated on 12-Dec-2008.
>> I want conform the problem and root cause.
>
> What is the problem?

After applying you=92re Patch to
Include/posixtest.h
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg04867.html

Most of the mq_ and other test cases are failed at Build and linking.
It was almost of the test cases total test case are 1888.

After that I have removed your patch and executed test suite it is working =
fine.

I think you have to revisit your patch and get the difference at your end.

>
>> Could you send me your open posix full Results logs of before and
>> after your patch with ARCH and Kernel versions?
>
> I never ran the full test suite. To be honest I could never figure out
> how to get it running. Are there instructions somewhere?
>
> My fix was triggered by a bug report I got that thought it found a
> Kernel regression based on this test and it looked to me like it was
> caused by that bug.

Yes.
There are Docs to do that.
#Remove your patch dated Dec 12  2008
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg04867.html


# vim LDFLAGS
Uncomment following line.

#Recommended flags:
-D_XOPEN_SOURCE=3D600 -lpthread -lrt -lm

FULL Execution:
Simple command is =93make=94
#pwd
ltp-full-20090630/testcases/open_posix_testsuite
#make

Single DIR Execution:
You can build only one directory of test cases
# export POSIX_TARGET=3Dconformance/interfaces/mq_send/
#make

Please read the followind Documents
1. BUILD
- describes how to set up your developer machine to build and test
2. LDFLAGS
- File that Makefile uses to link to what you specify
3. QUICK-START
- Quick doc to help you around POSIX** Test Suite.

Please share the full results log of your test.

Best regards,
Naresh Kamboju

>
> Cheers,
>
> =A0 =A0 =A0 =A0Brandon
>

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
