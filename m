Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSOKz-0001b0-7N
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:49:25 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSOKr-0000GD-Nu
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:49:25 +0000
Received: by pxi28 with SMTP id 28so1364714pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 21:49:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.1.00.0907151516430.3715@mail.selltech.ca>
References: <alpine.DEB.1.00.0907151048120.3370@mail.selltech.ca>
	<8368651DACC1964480F951191B94A078D01C80@svexch01.mvista.com>
	<alpine.DEB.1.00.0907151516430.3715@mail.selltech.ca>
Date: Sat, 18 Jul 2009 21:49:17 -0700
Message-ID: <364299f40907182149h1510d57are71332c258aa57e5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP hung on 2.6.31-rc3 kernel and buffer overflow detected
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
To: "Li, Ming Chun" <macli@brc.ubc.ca>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 15, 2009 at 3:26 PM, Li, Ming Chun<macli@brc.ubc.ca> wrote:
> On Wed, 15 Jul 2009, Henry Yei wrote:
>
>> Ming,
>>
>> The first thing to do is figure out what testcase is causing it and run =
that test by itself, then debug from there.
>> This is easy to find out by looking at your output and result files and =
see which was the last reported test.
>>
>> Note: I had no such problem on Ubuntu 9.04, but with the 2.6.28-13 kerne=
l.
>
> I looked at the fail report by
>
> #tail -5 output/LTP_RUN_ON-2009_Jul_14-14h_15m_46s.failed
>
> ftest03 ftest03
> ftest07 ftest07
> fs_di fs_di -d /tmp/
> quota_remount_test01 quota_remount_test01.sh
> Containers container_test.sh
>
> Is container_test.sh test the fault one? How to run that single test
> properly? I ran ./testcases/bin/container_test.sh at command line simply
> gave me error like:
>
> ./testcases/bin/container_test.sh: 13: check_for_unshare: not found
> ./testcases/bin/container_test.sh: 18: check_utsns_enabled: not found
> Uts namespaces not enabled in kernel. =A0Not running utsns tests.
> ./testcases/bin/container_test.sh: 41: check_ipcns_enabled: not found
> ipc namespaces not enabled in kernel. =A0Not running ipcns tests.
> ./testcases/bin/container_test.sh: 49: check_pidns_enabled: not found
> Process id namespaces not enabled in kernel. =A0Not running pidns tests.
> ./testcases/bin/container_test.sh: 57: check_mqns_enabled: not found
> Posix message queues or ipc namespaces not enabled in kernel.
> Not running mqns tests.
> ./testcases/bin/container_test.sh: 66: check_netns_enabled: not found
> Network namespaces not enabled in kernel. =A0Not running netns tests.

Vincent,
    Be sure to add /path/to/ltp/install/testcases/bin to your $PATH
before running container_test.sh.
HTH,
-Garrett

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
