Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1PauRe-0004Dl-Fb
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:20:18 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PauRd-0007qu-Lw
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:20:18 +0000
Received: by eya28 with SMTP id 28so6851331eya.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 10:20:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D25A37D.9080303@cn.fujitsu.com>
References: <4D259E4A.2050704@cn.fujitsu.com> <4D25A37D.9080303@cn.fujitsu.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 6 Jan 2011 13:19:49 -0500
Message-ID: <AANLkTi=10ceGjafEMSrzrajGPGvFLTdhKuyDyF17Wga2@mail.gmail.com>
Subject: Re: [LTP] [PATCH 12/13]Add a missing variable TST_TOTAL
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

On Thu, Jan 6, 2011 at 6:11 AM, tangchen wrote:
> --- a/testcases/kernel/syscalls/socketpair/socketpair02.c
> +++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
> @@ -162,4 +163,5 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0tst_resm(TPASS, "socketpair(SOCK_NONBLOCK) PASSED");
> =A0 =A0 =A0cleanup();
> =A0 =A0 =A0tst_exit();
> -}
> \ No newline at end of file
> +}
> +

please, no trailing new lines
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
