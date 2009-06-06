Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MCve6-00080J-Gb
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2009 13:09:14 +0000
Received: from web1109.biz.mail.sk1.yahoo.com ([74.6.114.41])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MCve2-0008Dw-7Y
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2009 13:09:14 +0000
Message-ID: <675495.66551.qm@web1109.biz.mail.sk1.yahoo.com>
Date: Sat, 6 Jun 2009 06:09:08 -0700 (PDT)
From: CAI Qian <caiqian@cclom.cn>
MIME-Version: 1.0
Subject: Re: [LTP] Reg: Script to extract description of test case from
	LTPROOT/doc/testcases/*.txt files
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
To: ltp-list <ltp-list@lists.sf.net>




--- On Tue, 5/26/09, Subrata Modak <subrata@linux.vnet.ibm.com> wrote:

> From: Subrata Modak <subrata@linux.vnet.ibm.com>
> Subject: Re: Reg: Script to extract description of test case from LTPROOT=
/doc/testcases/*.txt files
> To: "rohit verma" <rohit.170309@gmail.com>
> Cc: "CAI Qian" <caiqian@cclom.cn>, "ltp-list" <ltp-list@lists.sf.net>, "M=
ike Frysinger" <vapier@gentoo.org>, "Masatake YAMATO" <yamato@redhat.com>
> Date: Tuesday, May 26, 2009, 8:22 PM
> On Mon, 2009-05-25 at 21:40 -0700,
> rohit verma wrote: =

> > Hi Subrata,
> > =

> > I request you to finalize the format of the
> documentation ASAP.
> =

> I would like to see something like:
> =

> <testname=3Dabort(3)>
> =A0 <test_description=3D"Basic test for abort(3)">
> =A0 <\test_description>
> =A0
> <test_location=3D"ltp/testcases/kernel/syscalls/abort/abort01.c">
> =A0 <\test_location>
> =A0 <test_cmdfile_name=3D"ltp/runtest/syscalls">
> =A0 <\test_cmdfile_name>
> =A0 <test_cmdfile_entry=3D"abort01 ulimit -c
> 1024;abort01">
> =A0 <\test_cmdfile_entry>
> =A0 <Execute_through_commandline=3D"ulimit -c
> 1024; ./ltp/testcases/bin/abort01">
> =A0 <\Execute_through_commandline>
> =A0 <Execute_through_runltp=3D"./runltp -s
> abort01">
> =A0 <\Execute_through_runltp>
> <\testname>
> =


I feel this is a little bit hard to maintain unless we can generate this
automatically from the code and relevent runtest files.

CAI Qian


---------------------------------------------------------------------------=
---
OpenSolaris 2009.06 is a cutting edge operating system for enterprises =

looking to deploy the next generation of Solaris that includes the latest =

innovations from Sun and the OpenSource community. Download a copy and =

enjoy capabilities such as Networking, Storage and Virtualization. =

Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
