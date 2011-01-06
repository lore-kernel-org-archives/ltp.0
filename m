Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1PauRC-0002uf-VP
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:19:50 +0000
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PauRC-0006GQ-2b
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:19:50 +0000
Received: by ewy28 with SMTP id 28so4248350ewy.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 10:19:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D259F62.7040102@cn.fujitsu.com>
References: <4D259E4A.2050704@cn.fujitsu.com> <4D259F62.7040102@cn.fujitsu.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 6 Jan 2011 13:19:23 -0500
Message-ID: <AANLkTinKDgtXF=ttc=Q0ZAGScYnQe1p+_k+2WrGXL5wm@mail.gmail.com>
Subject: Re: [LTP] [PATCH 01/13]Add missing parameters for tst_brkm()
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

On Thu, Jan 6, 2011 at 5:54 AM, tangchen wrote:
> --- a/testcases/kernel/syscalls/fchmod/fchmod03.c
> +++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
> @@ -178,7 +178,7 @@ void cleanup()
> =A0 =A0 =A0TEST_CLEANUP;
>
> =A0 =A0 =A0if (close(fd) =3D=3D -1)
> - =A0 =A0 =A0 =A0tst_brkm(TWARN|TERRNO, "close failed");
> + =A0 =A0 =A0 =A0tst_brkm(TWARN|TERRNO, NULL, "close failed");

i guess we should add a non-null gcc attribute to the tst_brkm
function ... and perhaps a printf attribute if it doesnt have one
already
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
