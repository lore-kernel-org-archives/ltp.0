Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdrN0-0007wW-WF
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 21:39:43 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdrN0-0004Rw-35
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 21:39:42 +0000
Received: by wwi18 with SMTP id 18so3235722wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 14 Jan 2011 13:39:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201101141624.59736.vapier@gentoo.org>
References: <4D301BF1.8070101@cn.fujitsu.com>
	<201101141624.59736.vapier@gentoo.org>
Date: Fri, 14 Jan 2011 13:33:38 -0800
Message-ID: <AANLkTik8_=dyDFacvbJs8t6E1iaCmAgUEKOSRtv9fepZ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix a building error.
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

On Fri, Jan 14, 2011 at 1:24 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Friday, January 14, 2011 04:48:33 Peng Haitao wrote:
>> =A0testcases/kernel/syscalls/mallopt/mallopt01.c | =A0 =A01 +
>
> please use descriptive subjects in your patches. =A0this really should be
> something like:
> =A0 =A0 =A0 =A0mallopt01: fix build error due to xxxx
>
>> --- a/testcases/kernel/syscalls/mallopt/mallopt01.c
>> +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
>> @@ -37,6 +37,7 @@
>> =A0#ifdef CONFIG_COLDFIRE
>> =A0#define __MALLOC_STANDARD__
>> =A0#endif
>> +#include <malloc.h>
>
> umm, no. =A0malloc.h is a dead header file and nothing should be includin=
g it.

    It is exposing extra junk in this case that isn't available from
stdlib.h, which unfortunately the test uses. I fixed the build error
for now, but maybe someone upstream should be informed that this
header needs to die a painful death, because all contemporary
documentation says that you need to include stdlib.h, not malloc.h
when working with malloc(3). I was reminded of this recently because I
built some stuff on FreeBSD and FreeBSD has a nice #warning about this
deprecation.
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
