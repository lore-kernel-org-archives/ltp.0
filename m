Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NV8BN-0002tC-AL
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:43:05 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NV8BL-0008RU-Sa
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:43:05 +0000
Received: by pxi1 with SMTP id 1so7109884pxi.25
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 10:42:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100113183344.GA361348@medusa.sis.pasteur.fr>
References: <4B46D5F0.3090801@teldevice.co.jp>
	<20100108112534.GA333981@medusa.sis.pasteur.fr>
	<4B471F8D.7010907@teldevice.co.jp>
	<1263392362.5591.27.camel@subratamodak.linux.ibm.com>
	<364299f41001130952o6a57acd1m1544399fab0cb7f1@mail.gmail.com>
	<20100113183344.GA361348@medusa.sis.pasteur.fr>
Date: Wed, 13 Jan 2010 10:42:56 -0800
Message-ID: <364299f41001131042l1c5b6b15qb6cdc9c4aa0b2483@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP installation configure Error
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>, ltp-list@lists.sourceforge.net

On Wed, Jan 13, 2010 at 10:33 AM, Nicolas Joly <njoly@pasteur.fr> wrote:
> On Wed, Jan 13, 2010 at 09:52:37AM -0800, Garrett Cooper wrote:
> [...]
>> > Please see this patch and kindly make changes accordingly.
>>
>> I don't know what you want to do about the compiler optimization bug,
>> but I made the AC_MSG_WARN AC_MSG_ERROR on purpose because I _wanted_
>> to catch cases that the autoconf test didn't cover so the test itself
>> could be improved. Would you please:
>>
>> 1. Provide your config.log.
>
> Here follow the relevant parts.
>
> njoly@lanfeust [linux:ltp] $ ./configure
> [...]
> checking numaif.h usability... no
> checking numaif.h presence... no
> checking for numaif.h... no
> configure: error: Couldn't find functional copy of quota v2 - are you run=
ning 2.4.x?
>
> config.log:
>
> configure:8448: gcc -c -g -O2 =A0conftest.c >&5
> conftest.c: In function `main':
> conftest.c:51: error: `Q_GETINFO' undeclared (first use in this function)
> conftest.c:51: error: (Each undeclared identifier is reported only once
> conftest.c:51: error: for each function it appears in.)
> configure:8455: $? =3D 1
> configure: failed program was:
> | /* confdefs.h. =A0*/
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> [...]
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | /* end confdefs.h. =A0*/
> |
> | #define _LINUX_QUOTA_VERSION 2
> | #include <sys/types.h>
> | #include <sys/quota.h>
> | #include <unistd.h>
> | int
> | main ()
> | {
> |
> | int main(void) {
> | =A0 =A0 =A0 struct dqblk dq;
> | =A0 =A0 =A0 return quotactl(Q_GETINFO, (const char *) "/dev/null", gete=
uid(),
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caddr_t) &dq);
> | }
> | =A0 ;
> | =A0 return 0;
> | }
> configure:8465: error: Couldn't find functional copy of quota v2 - are yo=
u running 2.4.x ?
>
>> 2. Do `man 2 quotactl' and provide a description of what the function
>> #include requirements are?
>
> QUOTACTL(2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linux Programmer's Manual =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 QUOTACTL(2)
>
> NAME
> =A0 =A0 =A0 quotactl - manipulate disk quota
>
> SYNOPSIS
> =A0 =A0 =A0 #include <sys/types.h>
> =A0 =A0 =A0 #include <sys/quota.h>
>
> =A0 =A0 =A0 int quotactl(int cmd, const char *special, int id, caddr_t ad=
dr);
>
> =A0 =A0 =A0 #include <linux/unistd.h>
>
> =A0 =A0 =A0 #include <errno.h>
>
> =A0 =A0 =A0 _syscall4(int, =A0quotactl, =A0int, =A0cmd, =A0const char *, =
special , int, id,
> =A0 =A0 =A0 caddr_t, addr)

    Ok. Could you please attach your copies of
/usr/include/linux/quota.h and /usr/include/sys/quota.h in a private
email?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
