Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OaOMx-0000rf-Kl
	for ltp-list@lists.sourceforge.net; Sun, 18 Jul 2010 07:33:03 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OaOMw-0003Ao-2a
	for ltp-list@lists.sourceforge.net; Sun, 18 Jul 2010 07:33:03 +0000
Received: by iwn34 with SMTP id 34so4922932iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Jul 2010 00:32:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1058459861.509021279437936423.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <1752311632.509001279437850417.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1058459861.509021279437936423.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Sun, 18 Jul 2010 00:32:56 -0700
Message-ID: <AANLkTinEoRE879UDOU3dJicm7Yl-fHP1ZIi7WuIcX8zl@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix false alarm in pselect01
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Sun, Jul 18, 2010 at 12:25 AM, Caspar Zhang <czhang@redhat.com> wrote:
>
> ----- "Caspar Zhang" <czhang@redhat.com> wrote:
>
>> Hi all,
>>
>> =A0 =A0In my recent tests, not all desired time is equal to exact
>> execution time,
>> =A0 =A0sometimes it is +/-1s, and in a few times it becomes +/-2s. In mo=
st
>> cases,
>> =A0 =A0+/-2s is still a valid value between exact execute time and desir=
ed
>> time.
>>
>> =A0 =A0Signed-off-by: Caspar Zhang <czhang@redhat.com>
>>
>> --- a/testcases/kernel/syscalls/pselect/pselect01.c =A0 =A0 2010-04-01
>> 14:23:10.000000000 +0800
>> +++ b/testcases/kernel/syscalls/pselect/pselect01.c =A0 =A0 2010-07-15
>> 16:03:40.969426078 +0800
>> @@ -109,7 +109,8 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D time(&t);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((end - start) =3D=3D total_sec) || ((=
end - start) =3D=3D
>> total_sec + 1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Is it still valid in range -2~2s? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((end - start - total_sec <=3D 2) && (e=
nd - start -
>> total_sec >=3D -2))
>
> Sorry for mistake, since end, start are unsigned int, use
> end-start-total_sec >=3D -2 will cause error, add (int)before
> (end-start) instead. New patch attached.

    The fact that the test is using time(3) to calculate the elapsed
period instead of clock_gettime is dubious at best, because the
precision of time is in seconds. Maybe it should be converted to
clock_gettime calls for improved precision?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
