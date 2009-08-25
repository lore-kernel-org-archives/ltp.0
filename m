Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MfpA3-00045c-T0
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 06:05:39 +0000
Received: from mail-pz0-f203.google.com ([209.85.222.203])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mfp9v-0000xb-GU
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 06:05:39 +0000
MIME-Version: 1.0
In-Reply-To: <364299f40908241629x7dcfcbc2sdb2322198b7b729c@mail.gmail.com>
References: <d51f89b0908240516n1b4ca28m988feb00f077fbd7@mail.gmail.com>
	<364299f40908241629x7dcfcbc2sdb2322198b7b729c@mail.gmail.com>
Date: Tue, 25 Aug 2009 11:35:25 +0530
Message-ID: <d51f89b0908242305x19faae50h741f0d3bd9de5df1@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] Patch for smt_smp_affinity
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
Cc: ltp-list <ltp-list@lists.sf.net>

Thanks Garrett...

On Tue, Aug 25, 2009 at 4:59 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Mon, Aug 24, 2009 at 5:16 AM, rohit verma<rohit.170309@gmail.com> wrot=
e:
>> Dear Subrata,
>>
>> smt_smp_ affinity test case is passing on Fedora but fails on Ubuntu
>> for the same H/W.On Ubuntu system, after doing strace i observed that
>> system call sched_getaffinity was returning -1 [ERROR:EINVAL] due to
>> second argument.
>>
>> sched_getaffinity(pid, sizeof(unsigned int), &mask1)
>>
>> Please find attached herewith the patch which fixes the issue.
>
> Rohit,
> =A0 =A0Good catch -- one style note though: tst_resm doesn't require a
> "\n" because that's automatically appended to each message.
> Thanks,
> -Garrett
>



-- =

Regards,
Rohit

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
