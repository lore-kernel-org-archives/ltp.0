Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1PauT4-0000ws-J0
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:21:46 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PauT3-0006T5-Lw
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:21:46 +0000
Received: by eya28 with SMTP id 28so6852197eya.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 10:21:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D25A333.40501@cn.fujitsu.com>
References: <4D259E4A.2050704@cn.fujitsu.com> <4D25A333.40501@cn.fujitsu.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 6 Jan 2011 13:21:19 -0500
Message-ID: <AANLkTi=bDvZF6O5=m1gpX08YgN05=Ey7rL8OXP7sQ1ta@mail.gmail.com>
Subject: Re: [LTP] [PATCH 11/13]Fix the wrong using of perror()
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 6, 2011 at 6:10 AM, tangchen wrote:
> --- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
> +++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
> @@ -121,7 +121,8 @@ int main(int ac, char **av)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(sched_setparam(getppid(), &param));
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("sched_setparam returned %ld", TE=
ST_RETURN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "sched_setparam returned=
 %ld: "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s\n", TEST_RETURN, strerror(er=
rno));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);

odd, this should have caused a compile error ...

also, i wonder why this test isnt using tst_* helpers for its output ...
-mike

---------------------------------------------------------------------------=
---
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, an=
d, =

should the need arise, upgrade to a full multi-node Oracle RAC database =

without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
