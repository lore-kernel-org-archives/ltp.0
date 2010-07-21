Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1ObW0n-0004gj-H0
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 09:54:49 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ObW0m-0005bR-LJ
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 09:54:49 +0000
Received: by iwn34 with SMTP id 34so9210477iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Jul 2010 02:54:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <925081811.719281279705249668.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <234306554.719221279705061623.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<925081811.719281279705249668.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Wed, 21 Jul 2010 02:54:43 -0700
Message-ID: <AANLkTikQtSJ3O2zHkcwWD5alvtyMaz16yK0jqSa2lk3l@mail.gmail.com>
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

On Wed, Jul 21, 2010 at 2:40 AM, Caspar Zhang <czhang@redhat.com> wrote:
>
> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>
>> ACK (and thanks for the hard work)!
>> -Garrett
>
> Hi Garrett, I tested my patch yesterday but the result
> is not so good. After 1000 times running, the fix:
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* do a rounding */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 real_sec =3D (int)(0.5 + (tv_end.tv_sec - t=
v_start.tv_sec +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1e-9 * (tv_=
end.tv_nsec - tv_start.tv_nsec)));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (real_sec =3D=3D total_sec)
>
> got failed for once. so I set the allowed error to 20%(see the
> attached patch). Then re-ran it for over 5000 times, without
> a failure.
>
> Then the nsec part, 10% allowed error seems not enough,
> the test failed for twice among 1000 times. So I set the
> range to 20%, too.

Fair enough... change committed.
Thanks!
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
