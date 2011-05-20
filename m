Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QNPNS-0008DT-61
	for ltp-list@lists.sourceforge.net; Fri, 20 May 2011 13:04:26 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QNPNR-00023J-Iy
	for ltp-list@lists.sourceforge.net; Fri, 20 May 2011 13:04:26 +0000
Received: by vws2 with SMTP id 2so4112696vws.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 20 May 2011 06:04:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1aca96688a199f0cc6559a3f64be2ca1d73e6842.1305106654.git.czhang@redhat.com>
References: <1aca96688a199f0cc6559a3f64be2ca1d73e6842.1305106654.git.czhang@redhat.com>
Date: Fri, 20 May 2011 06:04:20 -0700
Message-ID: <BANLkTik82GxsSMDV0ifMxy4DvEBRRGJPww@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] [syscalls] chown03: fix EPERM issue
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

On Wed, May 11, 2011 at 2:39 AM, Caspar Zhang <czhang@redhat.com> wrote:
>
> in setup phase of chown03 testcase, it set effective gid/uid before
> create tmpdir, this might cause EPERM error under some circumstance:
>
> chown03 =A0 =A0 1 =A0TBROK =A0: =A0chown(/tmp/ltp-1FYYTiULQl/chos2UBh3, -=
1, 0) failed: errno=3DEPERM(1): Operation not permitted
> chown03 =A0 =A0 2 =A0TBROK =A0: =A0Remaining cases broken
> chown03 =A0 =A0 0 =A0TWARN =A0: =A0tst_brk: Invalid Type: 4. Using TBROK

That message is bizarre and looks like another bug in lib/... .

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its =

next-generation tools to help Windows* and Linux* C/C++ and Fortran =

developers boost performance applications - including clusters. =

http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
