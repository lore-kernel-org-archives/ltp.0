Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NV7Of-0007TB-By
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 17:52:45 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NV7Od-00021S-NM
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 17:52:45 +0000
Received: by pxi1 with SMTP id 1so7064938pxi.25
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 09:52:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263392362.5591.27.camel@subratamodak.linux.ibm.com>
References: <4B46D5F0.3090801@teldevice.co.jp>
	<20100108112534.GA333981@medusa.sis.pasteur.fr>
	<4B471F8D.7010907@teldevice.co.jp>
	<1263392362.5591.27.camel@subratamodak.linux.ibm.com>
Date: Wed, 13 Jan 2010 09:52:37 -0800
Message-ID: <364299f41001130952o6a57acd1m1544399fab0cb7f1@mail.gmail.com>
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>

On Wed, Jan 13, 2010 at 6:19 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Garrett,
>
> On Fri, 2010-01-08 at 21:05 +0900, TED ITC Agarwal Ashish wrote:
>> Hello Nicholas,
>>
>> Cc: All
>>
>> Thanks a lot Dear,
>>
>> Yes it seems to me too pretty good to tackle this as Warning not the Err=
or condition.
>> but after that too it didn't work the system Fedora Core 3(i checked qui=
ckly, not debug at my level).
>> but i didn't go well, it is as as before.
>> Also tried after "$make clean" & "$./configure".
>>
>> Because in the mean while i updated my Fedora3 to Fedora5 (kernel 2.6.15=
-1.2054-FC5).
>>
>> For this new configuration i were able to complete the "$./configure" & =
"$make all" part.
>> but when i tried to "make install" i had an another compiler error as be=
low:
>>
>> """""
>> internal compiler error: in merge_alias_info, at tree-ssa-copy.c:235
>> Please submit a full bug report,
>> """""
>>
>> So i hang around gOOgliNg and found that it is a GCC compiler problem.
>> The compiler over FC5 were 4.1.0.
>> I thought it were again challenging to update the compiler so for the ve=
ry first time i just updated this to Fc7 system, where i had GCC 4.1.2.
>> The flow went great and i were able to do the test primarily.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> FYI: the LTP-Full-20091231 installs the LTP over /opt/LTP location.
>> Don't try to run it over the directory we make install this.
>> * (i had 15 minutes fight for this conclusion,
>> =A0 =A0 because there were no msg of it over installations time)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>
>>
>> ????????????????????????????????????????
>>
>> Now 2 more question added to this queue is: The requirement specificatio=
n of LTP.
>>
>> Q2. Gcc -> ? (which version)
>> Kernel -> ?
>>
>> Q3. I will search further now on, but i want to ask is the same LTP is v=
alid for the other CPU's as well.
>> My AIM to check for the i.MX17 device (ARM Core) Embedded Linux. (kernel=
 2.6.19.2-xx)
>>
>> ????????????????????????????????????????
>>
>> --
>> Ashish Agarwal
>> '? =3D?'
>> When others working for an Impossible task, It is better to be quite tho=
ugh.
>> Let the others proceed =A0...... !!
>>
>> Nicolas Joly ????????:
>> > On Fri, Jan 08, 2010 at 03:51:28PM +0900, TED ITC Agarwal Ashish wrote:
>> >> Hello All
>> >>
>> >> I am novice for the LTP, just last week i heard something LTP
>> >> and feel curious about it so started searching and installations.
>> >>
>> >> "./configure " generates Error to me as written below.
>> >>
>> >> configure: error: Couldn't find functional copy of quota v2 - are you=
 running 2.4.x?
>> >
>> > Hi,
>> >
>> > I do see the same with an old 2006.0 Gentoo base (actually in a
>> > chroot) ... I worked around it by making it a warning instead of an
>> > error.
>> >
>> > IMHO, lacking some features should not prevent building/running LTP.
>> >
>> >
>> > Index: m4/ltp-quota.m4
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > RCS file: /cvsroot/ltp/ltp/m4/ltp-quota.m4,v
>> > retrieving revision 1.4
>> > diff -u -p -r1.4 ltp-quota.m4
>> > --- m4/ltp-quota.m4 20 Dec 2009 00:36:35 -0000 =A0 =A0 =A01.4
>> > +++ m4/ltp-quota.m4 8 Jan 2010 11:24:14 -0000
>> > @@ -37,7 +37,7 @@ dnl}],[has_24_quotactl=3D"yes"],
>> > =A0#include <unistd.h>],[
>> > =A0int main(void) {
>> > =A0 =A0 return quotactl(Q_GETINFO, (const char *)NULL, geteuid(), (cad=
dr_t)NULL);
>> > -}],[has_quotav2=3D"yes"],[AC_MSG_ERROR([Couldn't find functional copy=
 of quota v2 - are you running 2.4.x?])])
>> > +}],[has_quotav2=3D"yes"],[AC_MSG_WARN([Couldn't find functional copy =
of quota v2 - are you running 2.4.x?])])
>> > =A0dnl if test "x$has_24_quotactl" =3D "xyes"; then
>> > =A0dnl =A0 =A0 =A0 =A0AC_DEFINE(HAS_24_QUOTACTL,1,[Define to 1 if you =
have the 2.4.x version of quotactl, e.g. require linux/quota.h instead of s=
ys/quota.h])
>> > =A0dnl elif test "x$has_new_26_quotactl" =3D "xyes"; then
>
> Please see this patch and kindly make changes accordingly.

I don't know what you want to do about the compiler optimization bug,
but I made the AC_MSG_WARN AC_MSG_ERROR on purpose because I _wanted_
to catch cases that the autoconf test didn't cover so the test itself
could be improved. Would you please:

1. Provide your config.log.
2. Do `man 2 quotactl' and provide a description of what the function
#include requirements are?

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
