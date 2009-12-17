Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NL6YU-0002cj-Lx
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 02:57:30 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NL6YO-0002Z1-DS
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 02:57:30 +0000
Received: by pxi38 with SMTP id 38so1109559pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Dec 2009 18:57:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1173683636.495591261014366483.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <4B28C68C.1080304@cn.fujitsu.com>
	<1173683636.495591261014366483.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Wed, 16 Dec 2009 18:57:18 -0800
Message-ID: <364299f40912161857k15592002ibfefe99111d51d71@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/3] ade: fix the bug of ar01
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Dec 16, 2009 at 5:46 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> ----- "liubo" <liubo2009@cn.fujitsu.com> wrote:
>
>> Command "ar -tv" 's output doesn't match with "ls -ln" 's output on
>> item
>> "permission".
>>
>> s/-$permissions/-$permissions./
>
> This strange dot only appears in RHEL6, I don't see this dot in other
> distros or releases.

Is this perhaps because of a version upgrade?
Thanks,
-Garrett

>>
>> This patch fixed the bug.
>>
>> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>>
>> ---
>> =A0testcases/commands/ade/ar/ar01 | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/testcases/commands/ade/ar/ar01
>> b/testcases/commands/ade/ar/ar01
>> index c8f85eb..c393959 100755
>> --- a/testcases/commands/ade/ar/ar01
>> +++ b/testcases/commands/ade/ar/ar01
>> @@ -584,7 +584,7 @@ ar -tv $TCtmp/lib.a |
>> =A0while
>> =A0read permissions uid size month day time year file_name
>> =A0do
>> -echo "-$permissions;$uid;$size;$month;$day;$time;$file_name"
>> +echo "-$permissions.;$uid;$size;$month;$day;$time;$file_name"
>> =A0done >> $TCtmp/lib.a.stdout
>> =A0ttest
>>
>> --
>> 1.6.2.2
>>
>>
>>
>>
>>
>>
>> ------------------------------------------------------------------------=
------
>> This SF.Net email is sponsored by the Verizon Developer Community
>> Take advantage of Verizon's best-in-class app development support
>> A streamlined, 14 day to market process makes app distribution fast
>> and easy
>> Join now and get one step closer to millions of Verizon customers
>> http://p.sf.net/sfu/verizon-dev2dev
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
> --
> /-------------------------------------------\
> | Name: Caspar Zhang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> | Position: Kernel Qualification Engineer =A0 |
> | IRC: czhang on #kernel-qe, #eng-china =A0 =A0 |
> | Phone: +86-10-6260-8150 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> | Cellphone: +86-1381-073-0090 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> \-------------------------------------------/
>
>
> -------------------------------------------------------------------------=
-----
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and e=
asy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

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
