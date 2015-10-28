Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yesu4tech@gmail.com>) id 1ZrOfb-0006aO-8E
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2015 11:13:31 +0000
Received: from mail-wi0-f174.google.com ([209.85.212.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZrOfZ-0002gE-FB
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2015 11:13:31 +0000
Received: by wikq8 with SMTP id q8so248304975wik.1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Oct 2015 04:13:23 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 28 Oct 2015 16:43:23 +0530
Message-ID: <CAKq_7Fryb_CkGCiGghQ9gJtLBuh3Fv6T7tU1+WcH4zWub=9CkA@mail.gmail.com>
From: Yesuraj Abraham <yesu4tech@gmail.com>
Subject: [LTP] error while compiling ltp statically
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8861442834297498810=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8861442834297498810==
Content-Type: multipart/alternative; boundary=047d7b66f93b5f70cc05232848ce

--047d7b66f93b5f70cc05232848ce
Content-Type: text/plain; charset=UTF-8

Hi
I tried compiling ltp statically using arm toolchain, as follows
export
CC=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-gcc
export
LD=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-ld
export
AR=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-ar
export
AS=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-as
export
RANLIB=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-ranlib
export
STRIP=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-strip

./configure --host=arm-linux
--prefix=/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static_compilation/ltp-full-20150420/install
--exec-prefix=/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static_compilation/ltp-full-20150420/install
LDFLAGS="-static -pthread"
 make

It throws the following error(s),

/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/../arm-none-linux-gnueabi/libc/usr/lib/libc.a(syslog.o):
In function `openlog': syslog.c:(.text+0x814): multiple definition of
`openlog'
/tmp/ccusZ6dp.o:/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static_compilation/ltp-full-20150420/testcases/kernel/fs/fs-bench/random-access.c:66:
first defined here

The same error is thrown for the file, random-access-del-create.c too.

When i modified openlog to other name (openlog1) in both the files, then it
compiles successfully.

However when i build using x86 tool chain in the same manner (static flag
enabled), it builds successfully without the above error(s).

Regards,
yesuraj

--047d7b66f93b5f70cc05232848ce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div>I tried compiling ltp statically using arm toolchai=
n, as follows</div><div><div>export CC=3D/home/ltblr/CodeSourcery/Sourcery_=
CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-gcc</div><div>e=
xport LD=3D/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Lin=
ux/bin/arm-none-linux-gnueabi-ld</div><div>export AR=3D/home/ltblr/CodeSour=
cery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-a=
r</div><div>export AS=3D/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_fo=
r_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-as</div><div>export RANLIB=3D/ho=
me/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-non=
e-linux-gnueabi-ranlib</div><div>export STRIP=3D/home/ltblr/CodeSourcery/So=
urcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-strip</d=
iv></div><div><br></div><div><div>./configure --host=3Darm-linux --prefix=
=3D/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static_compilation=
/ltp-full-20150420/install --exec-prefix=3D/home/ltblr/yesuraj/test_apps/lt=
p/arm-none-tool-chain/static_compilation/ltp-full-20150420/install LDFLAGS=
=3D&quot;-static -pthread&quot;</div></div><div>=C2=A0make</div><div><br></=
div><div>It throws the following error(s),</div><div><div><br></div><div>/h=
ome/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/../arm=
-none-linux-gnueabi/libc/usr/lib/libc.a(syslog.o): In function `openlog&#39=
;: syslog.c:(.text+0x814): multiple definition of `openlog&#39;</div><div>/=
tmp/ccusZ6dp.o:/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static=
_compilation/ltp-full-20150420/testcases/kernel/fs/fs-bench/random-access.c=
:66: first defined here<br></div></div><div><br></div><div>The same error i=
s thrown for the file,=C2=A0random-access-del-create.c too.<br></div><div><=
br></div><div>When i modified openlog to other name (openlog1) in both the =
files, then it compiles successfully.</div><div><br></div><div>However when=
 i build using x86 tool chain in the same manner (static flag enabled), it =
builds successfully without the above error(s).</div><div><br></div><div>Re=
gards,</div><div>yesuraj=C2=A0</div></div>

--047d7b66f93b5f70cc05232848ce--


--===============8861442834297498810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8861442834297498810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8861442834297498810==--

