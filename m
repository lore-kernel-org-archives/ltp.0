Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NhnUN-0005zd-PJ
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:15:03 +0000
Received: from mail-px0-f196.google.com ([209.85.216.196])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NhnUM-00036d-UE
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:15:03 +0000
Received: by pxi34 with SMTP id 34so1503521pxi.6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Feb 2010 09:14:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B7B9EC2.1010004@linux.vnet.ibm.com>
References: <4B728073.3070209@cn.fujitsu.com>
	<4B7B9EC2.1010004@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2010 09:14:56 -0800
Message-ID: <364299f41002170914u3a0d0b02o936a81d1ee601ecc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] timers: support clockid of
	CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Feb 16, 2010 at 11:46 PM, Rishikesh <risrajak@linux.vnet.ibm.com> w=
rote:
> On 02/10/2010 03:16 PM, Shi Weihua wrote:
>> mainline commit da15cfdae03351c689736f8d142618592e3cebc3
>> =A0 (subject: time: Introduce CLOCK_REALTIME_COARSE)
>> added two clocks (CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE) in
>> 2.6.32-rc1, but it has not been responded in ltp. then, the following
>> error message occured.
>> -----
>> clock_gettime03 =A0 =A03 =A0TFAIL =A0: =A0failed to produce expected err=
or [expected errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ERRN=
O=3D???(0): Success
>> clock_gettime03 =A0 =A04 =A0TFAIL =A0: =A0failed to produce expected err=
or [expected errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ERRN=
O=3D???(0): Success
>> timer_create04 =A0 =A01 =A0TFAIL =A0: =A0didn't fail as expected [expect=
ed errno =3D 22 (Invalid argument)]: TEST_ERRNO=3D???(95): Operation not su=
pported
>> timer_create04 =A0 =A02 =A0TFAIL =A0: =A0didn't fail as expected [expect=
ed errno =3D 22 (Invalid argument)]: TEST_ERRNO=3D???(95): Operation not su=
pported
>> -----
>>
>> Following patch fixed this bug. and, passed on 2.6.32-rc1, 2.6.33-rc6, 2=
.6.23.1-42.fc8.
>>
>
> Can anyone provide their review & Acked ?
>
> Thanks "Shi Weihua" for patch.

1. Please provide before and after (once the items were fixed) output.
2. *sigh* These constants should be autoconf conditionalized --
otherwise when Linux devs decide to change their minds about the
values of the constants or the values are different on different
architectures you'll run into red-herring errors. The test should be
resistant to this behavior, but currently isn't. This would also
prevent `ENOSYS'-like errors from showing up on kernels < 2.6.32-rc1.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
