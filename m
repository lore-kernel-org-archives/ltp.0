Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdeWU-0002oa-K5
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 07:56:38 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdeWT-00032c-QI
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 07:56:38 +0000
Received: by wyb40 with SMTP id 40so2471825wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Jan 2011 23:56:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimUOfMRp5eTABnr5i04FssPQoFHY7MheNe_SBLm@mail.gmail.com>
References: <AANLkTimUOfMRp5eTABnr5i04FssPQoFHY7MheNe_SBLm@mail.gmail.com>
Date: Thu, 13 Jan 2011 23:56:32 -0800
Message-ID: <AANLkTi=FRko33asxEvbcBRmE_2UV0kKbBopTKgwgHFj8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Bug Fix] LTP test cases kill05 is broken on uclinux
	platform
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
To: Vivi <violetleigh@gmail.com>
Cc: LTP mailing list <ltp-list@lists.sourceforge.net>

On Wed, Dec 29, 2010 at 1:35 AM, Vivi <violetleigh@gmail.com> wrote:
> LTP test cases kill05 is broken on uclinux platform.
>
> --
> root:/bin> kill05
> kill05=A0=A0=A0=A0=A0 1=A0 BROK=A0 :=A0 self_exec of child failed
> kill05=A0=A0=A0=A0=A0 0=A0 INFO=A0 :=A0 WARNING: shared memory deletion f=
ailed.
> kill05=A0=A0=A0=A0=A0 0=A0 INFO=A0 :=A0 This could lead to IPC resource p=
roblems.
> kill05=A0=A0=A0=A0=A0 0=A0 INFO=A0 :=A0 id =3D 0
> kill05=A0=A0=A0=A0=A0 2=A0 PASS=A0 :=A0 errno set to 1 : Operation not pe=
rmitted, as
> expected
> kill05=A0=A0=A0=A0=A0 0=A0 WARN=A0 :=A0 tst_rmdir(): rmobj(/tmp/kilhsxPSp=
) failed:
> lstat(/tmp/kilhsxPSp) failed; errno=3D2: No such file or directory
> root:/bin>

Why not just revise do_test to do the right thing?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
