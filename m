Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdymU-0006sG-0n
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:34:30 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdymT-0004rO-4L
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:34:29 +0000
Received: by wwi18 with SMTP id 18so3486938wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 14 Jan 2011 21:34:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201012291135.40157.vapier@gentoo.org>
References: <AANLkTinxp9Aj7MwPqpR13cZRjAYdLVwMkhCteDM-S7Vi@mail.gmail.com>
	<201012291135.40157.vapier@gentoo.org>
Date: Fri, 14 Jan 2011 21:34:23 -0800
Message-ID: <AANLkTi=sSsbYn4HKxNLegDqY49POL1Qt287uDK_=MMOT@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Bug Fix] Skip first case in adjtimex02 test by a safer
	method
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Wed, Dec 29, 2010 at 8:35 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday, December 29, 2010 04:35:29 Vivi wrote:
>> --- testcases/kernel/syscalls/adjtimex/adjtimex02.c
>> +++ testcases/kernel/syscalls/adjtimex/adjtimex02.c
>> @@ -122,12 +122,7 @@
>> =A0 =A0 =A0 =A0 void (*cleanup) ();
>> =A0 =A0 =A0 =A0 int exp_errno;
>> =A0} test_cases[] =3D {
>> -#ifndef UCLINUX
>> - =A0 =A0 =A0 /* Skip since uClinux does not implement memory protection=
 */
>> - =A0 =A0 =A0 {
>> - =A0 =A0 =A0 (struct timex *)-1, NULL, NULL, EFAULT},
>> -#endif
>> - =A0 =A0 =A0 {
>> + =A0 =A0 =A0 { (struct timex *)-1, NULL, NULL, EFAULT},{
>> =A0 =A0 =A0 =A0 &buff, setup2, NULL, EINVAL}, {
>> =A0 =A0 =A0 =A0 &buff, setup3, NULL, EINVAL}, {
>> =A0 =A0 =A0 =A0 &buff, setup4, NULL, EINVAL}, {
>> @@ -159,7 +154,18 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tst_count =3D 0;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < TST_TOTAL; ++i) {
>> +#ifdef UCLINUX
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Skip first case since=
 uClinux does not implement
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* memory protection.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(T=
CONF, "uClinux does not
>> implement" + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " memory
>> protection."); + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +#endif
>
> we should be able to handle bad pointers like -1 and NULL. =A0the kernel'=
s check
> access func should force EFAULT. =A0so why do we need this new if code ?

    If so, then there's a lot of code in LTP that needs to be fixed.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
