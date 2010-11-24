Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PLB0i-0001BZ-SV
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 08:47:28 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLB0h-00022s-DT
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 08:47:28 +0000
Received: by wyb40 with SMTP id 40so2325350wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Nov 2010 00:47:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CECC662.2080103@cn.fujitsu.com>
References: <000001cb8a0d$cd4fad30$67ef0790$@co.jp>
	<4CECC662.2080103@cn.fujitsu.com>
Date: Wed, 24 Nov 2010 00:47:20 -0800
Message-ID: <AANLkTikwNTQQ58W7MX_qfPkqdWyEM8_7as9hb-Z=McLB@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About "configure" failure
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
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Wed, Nov 24, 2010 at 12:01 AM, Bian Naimeng <biannm@cn.fujitsu.com> wrot=
e:
>
>
> Mitani wrote:
>> Hi,
>>
>> I reported failure of "configure" on the other day.
>> =A0 =A0 http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg11=
137.html
>>
>> But I think that it's hard to notice because my report is contributed to
>> the report of "realtime" failure. It's my clumsiness.
>> Therefore, I report about "configure" again with =A0the recent git.
>>
>>
>
> Hi mitani-san,
>
> =A0Please try the following patch.
>
> -----------------------
> fix configure error.
>
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>
> ---
> =A0m4/ltp-quota.m4 | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/m4/ltp-quota.m4 b/m4/ltp-quota.m4
> index af1212a..5a367e9 100644
> --- a/m4/ltp-quota.m4
> +++ b/m4/ltp-quota.m4
> @@ -29,7 +29,7 @@ int main(void) {
> =A0 =A0 =A0 =A0struct dqblk dq;
> =A0 =A0 =A0 =A0return quotactl(QCMD(Q_GETINFO, USRQUOTA), (const char *) =
"/dev/null",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0geteuid(), (caddr_t) &dq);
> -}],[has_quotav2=3D"yes"],[dnl END quota v2 check
> +}])],[has_quotav2=3D"yes"],[dnl END quota v2 check
> =A0AC_LINK_IFELSE([AC_LANG_SOURCE([
> =A0#define _LINUX_QUOTA_VERSION 1
> =A0#include <sys/types.h>
> @@ -46,4 +46,4 @@ if test "x$has_quotav1" =3D "xyes"; then
> =A0elif test "x$has_quotav2" =3D "xyes"; then
> =A0 =A0 =A0 =A0AC_DEFINE(HAVE_QUOTAV2,1,[Define to 1 if you have quota v2=
])
> =A0fi
> -])])
> +])
> --
> 1.7.0.4
>
>
>
>> ---
>>
>> "configure" failed with git "ltp-7d2055e.tar.gz":
>> ------------<RHEL4.8 - x86>
>> ./configure: line 8228: syntax error near unexpected token `elif'
>> ./configure: line 8228: `elif test "x$has_quotav2" =3D "xyes"; then'
>> ------------
>>
>> Environmants are RHEL5.5/4.8 -- x86/x86_64/ia64.
>>
>>
>> "${LTPROOT}/configure" file of "ltp-7d2055e.tar.gz" is following:
>>
>> ------------< RHEL4.8 - x86>
>> [...]
>>
>> cat >conftest.$ac_ext <<_ACEOF
>> /* confdefs.h. =A0*/
>> _ACEOF
>> cat confdefs.h >>conftest.$ac_ext
>> cat >>conftest.$ac_ext <<_ACEOF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ---
>> LINE 8210
>> /* end confdefs.h. =A0*/
>>
>> #define _LINUX_QUOTA_VERSION 2
>> #include <sys/types.h>
>> #include <sys/quota.h>
>> #include <unistd.h>
>> int main(void) {
>> =A0 =A0 =A0 =A0 struct dqblk dq;
>> =A0 =A0 =A0 =A0 return quotactl(QCMD(Q_GETINFO, USRQUOTA), (const char *)
>> "/dev/null",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 geteuid(), (caddr_t) &dq=
);
>> }
>> --- LINE 8221
>> if test "x$has_quotav1" =3D "xyes"; then
>>
>> cat >>confdefs.h <<\_ACEOF
>> --- LINE 8224
>> #define HAVE_QUOTAV1 1
>> _ACEOF
>>
>> elif test "x$has_quotav2" =3D "xyes"; then
>>
>> cat >>confdefs.h <<\_ACEOF
>> #define HAVE_QUOTAV2 1
>> _ACEOF
>>
>> fi
>>
>> _ACEOF
>> --- LINE 8236
>> rm -f conftest.$ac_objext conftest$ac_exeext
>> if { (ac_try=3D"$ac_link"
>> [...]
>> ------------
>>
>>
>> The line 8210 (" =A08210 =A0cat >>conftest.$ac_ext <<_ACEOF") is the "he=
re
>> document".
>> First "_ACEOF" which appears after this line is the line 8224.
>> But the line 8224 is "here document", too.
>>
>> I think that it is syntax error.
>>
>> In the line 8236, there is "_ACEOF".
>> This "_ACEOF" may be just after line 8221, I think.
>>
>> I tried to execute "configure" after above revision, and it succeeded.
>> After this, "make" and "make install" succeeded, too.

    Thanks for better pointing out the problem. I spread the autoconf
tests out so that (hopefully) the same mistake won't happen again.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
