Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NHiTT-0004m8-EU
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 18:38:19 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHiTM-0005bF-Ej
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 18:38:19 +0000
Received: by pwi13 with SMTP id 13so21757pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 07 Dec 2009 10:38:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1260186839.6866.19.camel@subratamodak.linux.ibm.com>
References: <200912041643.nB4GhMmX007322@e1.ny.us.ibm.com>
	<1260186839.6866.19.camel@subratamodak.linux.ibm.com>
Date: Mon, 7 Dec 2009 10:38:06 -0800
Message-ID: <364299f40912071038n5bea3c26uec9cd418abbf08fd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix overreaching clean targets in Makefiles that
	cleaned the readme files
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
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list@lists.sourceforge.net

On Mon, Dec 7, 2009 at 3:53 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-12-04 at 17:31 +0100, Jiri Palecek wrote:
>> Hello,
>>
>> the makefiles in some of the float tests contain the glob "[dr]*" in the=
ir clean targets. Unfortunately, this deletes not only the generated refere=
nce files, but also the readme files shipped in those directories. This pat=
ch fixes it by changing CLEAN_TARGETS to more specific patterns (that captu=
re all generated files in all float tests, however).
>>
>> Regards
>> =A0 =A0 Jiri Palecek
>>
>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>
> Thanks.
>
> Regards--
> Subrata
>
>> ---
>> =A0testcases/misc/math/float/iperb/Makefile | =A0 =A03 ++-
>> =A0testcases/misc/math/float/trigo/Makefile | =A0 =A03 ++-
>> =A02 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/misc/math/float/iperb/Makefile b/testcases/misc/m=
ath/float/iperb/Makefile
>> index e7a6774..6b538d1 100644
>> --- a/testcases/misc/math/float/iperb/Makefile
>> +++ b/testcases/misc/math/float/iperb/Makefile
>> @@ -24,7 +24,8 @@ top_srcdir =A0 =A0 =A0 =A0 =A0?=3D ../../../../..
>>
>> =A0include $(top_srcdir)/include/mk/env_pre.mk
>>
>> -CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D [dr]* *.ref*
>> +CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D [rd]*sin [rd]sinh [rd=
]*cos [rd]cosh [rd]*tan [rd]*tan2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> +[rd]tanh *.ref*
>>
>> =A0LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -lm
>>
>> diff --git a/testcases/misc/math/float/trigo/Makefile b/testcases/misc/m=
ath/float/trigo/Makefile
>> index c7390ff..4abf9f9 100644
>> --- a/testcases/misc/math/float/trigo/Makefile
>> +++ b/testcases/misc/math/float/trigo/Makefile
>> @@ -24,7 +24,8 @@ top_srcdir =A0 =A0 =A0 =A0 =A0?=3D ../../../../..
>>
>> =A0include $(top_srcdir)/include/mk/env_pre.mk
>>
>> -CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D [dr]*
>> +CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D [rd]*sin [rd]sinh [rd=
]*cos [rd]cosh [rd]*tan [rd]*tan2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> +[rd]tanh
>>
>> =A0LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -lm

Mike actually fixed this issue by renaming readme to README.
-Garrett

---------------------------------------------------------------------------=
---
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. =

Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
