Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MCwc0-0006BY-Ca
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2009 14:11:08 +0000
Received: from web1104.biz.mail.sk1.yahoo.com ([74.6.114.36])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MCwbz-0002fv-16
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2009 14:11:08 +0000
Message-ID: <396868.38061.qm@web1104.biz.mail.sk1.yahoo.com>
Date: Sat, 6 Jun 2009 06:44:25 -0700 (PDT)
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
To: ltp-list@lists.sf.net




--- On Mon, 5/18/09, rohit verma <rohit.170309@gmail.com> wrote:

> From: rohit verma <rohit.170309@gmail.com>
> Subject: Re: Reg: Script to extract description of test case from  LTPROO=
T/doc/testcases/*.txt files
> To: subrata@linux.vnet.ibm.com
> Cc: "CAI Qian" <caiqian@cclom.cn>
> Date: Monday, May 18, 2009, 7:55 PM
> Dear Subrata/Qian,
> =

> I am trying to develop script which would extracts
> description information about user required test case from
> LTPROOT/doc/testcases/ folder. =

> =

> So to make the description text file=A0 as standard file,
> can we represent the description as mentioned below.
> =A0
> For example=A0in syscalls category:
> =A0
> Currently available format of description in LTP as
> follows.
> =A0
> =A0 abort01
> =A0=A0 Basic test for abort(3).
> =

> =A0 accept01=A0=A0
> =A0=A0 Verify that accept() returns the proper errno for
> various failure cases
> =A0
> =

> To make it in consistent way, description should be
> enclosed by executables as follows.
> =

> =A0<abort01>
> =A0=A0 Basic test for abort(3).
> =A0<\abort01>
> =A0
> =A0<accept01>=A0=A0
> =A0=A0 Verify that accept() returns the proper errno for
> various failure cases
> =A0<\accept01>
> =A0
> Please confirm if this format is O.K or suggest any
> other format by which we can easily parse the test cases and
> extracts the description.
> =

> If this format is O.K=A0, I would send the patch for those
> text files
> =A0

Another thing it that, your approach is not really document the =

description of test cases but test code (the build blocks). For example, =

in runtest/fs has the following test cases,

gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20=
 glseek20.2
gf02 growfiles -W gf02 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
gf03 growfiles -W gf03 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
gf04 growfiles -W gf04 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
gf05 growfiles -W gf05 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f =
gf07_
gf06 growfiles -W gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand1=
0 g_rand10.2
gf07 growfiles -W gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_=
rand13 g_rand13.2
gf08 growfiles -W gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand1=
1 g_rand11.2
gf09 growfiles -W gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_=
rand12 g_rand12.2
gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_=
lio14.2
gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_=
lio15.2
gf12 mkfifo gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 gffifo17

They all utilizes growfiles.c to perform different test scenarios. How can
we make sure we do document what those tests are actually trying to test?
If you really want to document what the test cases claiming to test, the =

more proper places to look at would be based on LTPROOT/runtest/* files.
For example, we will have something in LTPROOT/doc/testcases/fs like,

<gf11>...</gf11>

The description of a test case might not reside in test code itself,
because the test code has no view of how users are going to test different
scenarios. For example, mount.c might be used to test ext3, ext4 or
loopback filesystems. Therefore, The existing test cases descriptions might
be found from the mailing list when they were introduced.

If we have such documents about real test cases in place, it would be much
easier to maintain the tests, since we have the requirements. In addition,
We can fight back the complains about LTP that users have no visible view
what each test cases is claiming to test, and its coverage.

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
