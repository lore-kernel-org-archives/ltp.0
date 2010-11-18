Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PIwFX-0004pH-OX
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 04:37:31 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PIwFW-0001sU-Cp
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 04:37:31 +0000
Received: by wyb34 with SMTP id 34so2740362wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Nov 2010 20:37:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CE4AD0D.1050501@cn.fujitsu.com>
References: <000001cb798d$1aaa0210$4ffe0630$@co.jp>
	<AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>
	<4CCE73A6.9020901@cn.fujitsu.com>
	<AANLkTi=TyhLVZ5OOcRduBwvkxS3-u4f7A1W+bv+WO6Y1@mail.gmail.com>
	<4CE4AD0D.1050501@cn.fujitsu.com>
Date: Wed, 17 Nov 2010 20:37:24 -0800
Message-ID: <AANLkTim5JubFxad76akVJ7YOVs1V84gY=2TUVQ1KMkJz@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "sigaction" tests
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: Mitani <mitani@ryobi.co.jp>, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>, ltp-list@lists.sourceforge.net

2010/11/17 Bian Naimeng <biannm@cn.fujitsu.com>:
>
>
> Garrett Cooper wrote:
>> On Mon, Nov 1, 2010 at 1:00 AM, Gui Jianfeng <guijianfeng@cn.fujitsu.com=
> wrote:
>>> Garrett Cooper wrote:
>>>> 2010/10/31 Mitani <mitani@ryobi.co.jp>:
>>> ...
>>>>> =A0int main()
>>>>> =A0{
>>>>> @@ -133,6 +152,12 @@
>>>>>
>>>>> =A0 =A0 =A0 =A0struct sigaction sa;
>>>>>
>>>>> + =A0 =A0 =A0 /* Checking for Kernel Version */
>>>>> + =A0 =A0 =A0 if ( kernel_ver_cmp(2, 6, 21) !=3D 0 )
>>>>> + =A0 =A0 =A0 {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTESTED( "sem_wait() returned EINTR on=
 kernel versions
>>>>> lower than 2.6.22" );
>>>>> + =A0 =A0 =A0 }
>>>>> +
>>>>> =A0 =A0 =A0 =A0/* Initialize output */
>>>>> =A0 =A0 =A0 =A0output_init();
>>>>>
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>> Above patch is revision only for templates.
>>>>> The following procedure is necessary after applying patch:
>>>>> ------------
>>>>> #cd testcases/open_posix_testsuite/conformance/interfaces/sigaction/
>>>>> #./gentests.pl
>>>>> ------------
>>>>>
>>>>> Similar revisions are necessary for other 25 "sigaction" tests.
>>>> =A0 =A0 Sorry, but Linux-isms can't leak into the open_posix_testsuite.
>>>> Same with BSDisms (at least they shouldn't... if they do, then slap me
>>>> or whoever did the commit).
>>> Do you mean the culprit is Linux-isms?
>>
>> Mitani-san is proposing that I `fix' the testcases to work on RHEL
>> 4.8. These testcases should function with minimal change for all
>> versions of Unix.
>>
>
> =A0This open_posix_suite is the part of LTP(linux test project), must we
> make sure it can work at all versions of unix?

I use it in FreeBSD and others have used it in other versions of Unix
(in the past), based on the README. There's no reason why we need to
maintain something that philosophically diverges from the upstream
project's goal because it will make merging more painful and
unnecessary.

> What about this patch? =A0If you think so, other similar patchs will be p=
ost.
>
> -------------------------------------------------------------------------=
------
>
> At older linux kernel(2.6.22 before), a signal handler always interrupts a
> blocked call to one of these functions, regardless of the use of the siga=
ction
> SA_RESTART flag, so we should not test these cases at this situation.
>
> Althought uname is not exsit at 4.3 BSD, but this open_posix_suite just
> the part of LTP(linux test project), so i think it's not a problem.
>
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>
> ---
> =A0.../conformance/interfaces/sigaction/16-1.c =A0 =A0 =A0 =A0| =A0 27 ++=
++++++++++++++++++
> =A01 files changed, 27 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigact=
ion/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigactio=
n/16-1.c
> index 706dbfc..3d6e1a1 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-=
1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-=
1.c
> @@ -50,6 +50,7 @@ Anyway, a false negative status cannot be returned.
> =A0#include <stdlib.h>
> =A0#include <string.h>
> =A0#include <unistd.h>
> +#include <sys/utsname.h>
>
> =A0#include <semaphore.h>
> =A0#include <signal.h>
> @@ -95,6 +96,27 @@ Anyway, a false negative status cannot be returned.
> =A0volatile sig_atomic_t caught =3D 0;
> =A0sem_t sem;
>
> +#define KERNEL_VERSION(a, b, c) =A0 =A0 =A0 =A0(((a) << 16) + ((b) << 8)=
 + (c))
> +
> +int check_linux()
> +{
> + =A0 =A0 =A0 struct utsname tn;
> + =A0 =A0 =A0 int r1, r2, r3;
> +
> + =A0 =A0 =A0 if (0 > uname(&tn)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNRESOLVED( errno, "uname failed" );
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (strcmp(tn.sysname, "Linux") !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 sscanf(tn.release, "%d.%d.%d", &r1, &r2, &r3);
> + =A0 =A0 =A0 if (KERNEL_VERSION(r1, r2, r3) >=3D KERNEL_VERSION(2, 6, 22=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0/* Handler function */
> =A0void handler( int signo )
> =A0{
> @@ -133,6 +155,11 @@ int main()
>
> =A0 =A0 =A0 =A0struct sigaction sa;
>
> + =A0 =A0 =A0 if (!check_linux())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTESTED( "A signal handler always interrup=
ts sem_wait "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "at linux release, rega=
rdless of the use of "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "the sigaction SA_RESTA=
RT flag" );
> +
> =A0 =A0 =A0 =A0/* Initialize output */
> =A0 =A0 =A0 =A0output_init();

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
