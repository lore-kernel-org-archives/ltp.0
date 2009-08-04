Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MYLAR-0007b5-8J
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 14:39:07 +0000
Received: from qw-out-1920.google.com ([74.125.92.145])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYLAJ-0006VG-8Y
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 14:39:07 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1884619qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 04 Aug 2009 07:38:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1249387714.15587.38.camel@subratamodak.linux.ibm.com>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
	<1249387714.15587.38.camel@subratamodak.linux.ibm.com>
Date: Tue, 4 Aug 2009 07:38:53 -0700
Message-ID: <364299f40908040738n32fb4983j1fa09f0d50449cf8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/4] utimensat: Remove utimensat_user from script
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
To: subrata@linux.vnet.ibm.com
Cc: monstr@monstr.eu, ltp-list@lists.sourceforge.net

On Tue, Aug 4, 2009 at 5:08 AM, Subrata Modak<subrata@linux.vnet.ibm.com> w=
rote:
> On Mon, 2009-08-03 at 15:24 +0200, michal.simek@petalogix.com wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>> We can use nobody user instead of creating new one
>> for this special test. Latest busybox source
>> code not support userdel, useradd that's why
>> is better to use user which exists.
>>
>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>
> Ok.

If that's the case, then a lot of testcases need to change in
network/ipv6, network/tcp_cmds, etc...
-Garrett

>> =A0.../kernel/syscalls/utimensat/utimensat_tests.sh =A0 | =A0 =A04 +---
>> =A01 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/te=
stcases/kernel/syscalls/utimensat/utimensat_tests.sh
>> index 19c59c7..d0e940a 100644
>> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
>> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
>> @@ -243,8 +243,7 @@ run_test()
>> =A0}
>> =A0#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> -user_tester=3Dutimensat_tester
>> -useradd $user_tester
>> +user_tester=3Dnobody
>> =A0sudo -u $user_tester mkdir -p $TEST_DIR
>>
>> =A0chown root $LTPROOT/testcases/bin/$TEST_PROG
>> @@ -434,7 +433,6 @@ echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
>>
>> =A0echo
>>
>> -userdel -r utimensat_tester
>> =A0rm -rf $TEST_PROG
>> =A0uname -a
>> =A0date
>
>
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay
> trial. Simplify your report design, integration and deployment - and focu=
s on
> what you do best, core application coding. Discover what's new with
> Crystal Reports now. =A0http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
