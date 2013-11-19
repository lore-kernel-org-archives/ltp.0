Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yesu4tech@gmail.com>) id 1ViiJa-0003RN-65
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 10:13:50 +0000
Received: from mail-vc0-f194.google.com ([209.85.220.194])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ViiJZ-0007NZ-4x
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 10:13:50 +0000
Received: by mail-vc0-f194.google.com with SMTP id hz11so401951vcb.5
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Nov 2013 02:13:43 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 19 Nov 2013 15:43:43 +0530
Message-ID: <CAKq_7Fq4obzNXmzzS8mE6o=6KyQcV_fc2XEDtQ1=BGgz7vtSRw@mail.gmail.com>
From: yesuraj abraham <yesu4tech@gmail.com>
Subject: [LTP] how to cross compile ltp for arm with statically linking?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2980695223660191208=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2980695223660191208==
Content-Type: multipart/alternative; boundary=047d7b3442905a2a1604eb84ebb8

--047d7b3442905a2a1604eb84ebb8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi

I want to cross compile ltp for arm platform also my entire executable
should be statically linked:

My ARM tool chain is installed in "/usr/local/arm/arm-2009q3/"

My LTP source is in "/home/user/test_apps/ltp/arm/ltp-full-20130904/".



I followed the below steps,

---------------------------------------------------------------------------=
---------------------------------------------------

export ARCH=3Darm

export CROSS_COMPILER=3D/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueab=
i

export CC=3D$CROSS_COMPILER-gcc

export LD=3D$CROSS_COMPILER-ld

export AR=3D$CROSS_COMPILER-ar

export STRIP=3D$CROSS_COMPILER-strip

export RANLIB=3D$CROSS_COMPILER-ranlib

./configure --host=3Darm-linux
--prefix=3D/home/user/test_apps/ltp/arm/ltp-full-20130904/install
--exec-prefix=3D/home/user/test_apps/ltp/arm/ltp-full-20130904/install
LDFLAGS=3D"-static"

make

---------------------------------------------------------------------------=
----------------------------------------------------



My Make fails as follows,

(I get "undefined reference to" all pthread calls in
"/testcases/kernel/syscalls/mq_notify".)

/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi-gcc -g -O2 -g -O2
-fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=3D2
-I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
-I../../../../include -I../../../../include -static  -L../../../../lib
mq_notify01.c   -lltp -lpthread -lrt -o mq_notify01

/usr/local/arm/arm-2009q3/bin/../arm-none-linux-gnueabi/libc/usr/lib/librt.=
a(mq_notify.o):
In function `mq_notify':

mq_notify.c:(.text+0x68): undefined reference to `pthread_once'


I don=92t get this error if I don't put LDFLAGS=3D"-static" in configure
command,



if I go to "testcases/kernel/syscalls/mq_notify" and try to build using the
command whatever the make is trying to do as follows,

---------------------------------------------------------------------------=
---------------------------------------

/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi-gcc -g -O2 -g -O2
-fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=3D2
-I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
-I../../../../include -I../../../../include -static  -L../../../../lib
mq_notify01.c   -lltp -lpthread -lrt -o mq_notify01

---------------------------------------------------------------------------=
-------------------------------------

obviously I get the same error, but if I rearrange the pthread linker flag
at the last as follows

---------------------------------------------------------------------------=
--------------------------------------

/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi-gcc -g -O2 -g -O2
-fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=3D2
-I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
-I../../../../include -I../../../../include -static  -L../../../../lib
mq_notify01.c   -lltp -lrt -o mq_notify01 -lpthread

---------------------------------------------------------------------------=
------------------------------------

The compilation succeeds now

Can someone help me how to cross compile ltp for arm with statically
linking?

--047d7b3442905a2a1604eb84ebb8
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal">Hi </p>

<p class=3D"MsoNormal">I want to cross compile ltp for arm platform also my=
 entire executable
should be statically linked:</p>

<p class=3D"MsoNormal">My ARM tool chain is installed in
&quot;/usr/local/arm/arm-2009q3/&quot;</p>

<p class=3D"MsoNormal">My LTP source is in
&quot;/home/user/test_apps/ltp/arm/ltp-full-20130904/&quot;.</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">I followed the below steps,</p>

<p class=3D"MsoNormal">----------------------------------------------------=
--------------------------------------------------------------------------<=
/p>

<p class=3D"MsoNormal">export ARCH=3Darm</p>

<p class=3D"MsoNormal">export
CROSS_COMPILER=3D/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi</p>

<p class=3D"MsoNormal">export CC=3D$CROSS_COMPILER-gcc</p>

<p class=3D"MsoNormal">export LD=3D$CROSS_COMPILER-ld</p>

<p class=3D"MsoNormal">export AR=3D$CROSS_COMPILER-ar</p>

<p class=3D"MsoNormal">export STRIP=3D$CROSS_COMPILER-strip</p>

<p class=3D"MsoNormal">export RANLIB=3D$CROSS_COMPILER-ranlib</p>

<p class=3D"MsoNormal">./configure --host=3Darm-linux
--prefix=3D/home/user/test_apps/ltp/arm/ltp-full-20130904/install
--exec-prefix=3D/home/user/test_apps/ltp/arm/ltp-full-20130904/install
LDFLAGS=3D&quot;-static&quot;</p>

<p class=3D"MsoNormal">make</p>

<p class=3D"MsoNormal">----------------------------------------------------=
---------------------------------------------------------------------------=
</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">My Make fails as follows,</p>

<p class=3D"MsoNormal">(I get &quot;undefined reference to&quot; all pthrea=
d calls
in &quot;/testcases/kernel/syscalls/mq_notify&quot;.)</p>

<p class=3D"MsoNormal">/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi=
-gcc -g
-O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=3D2
-I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
-I../../../../include -I../../../../include -static=A0 -L../../../../lib=A0=
 mq_notify01.c=A0=A0 -lltp -lpthread -lrt -o mq_notify01</p>

<p class=3D"MsoNormal">/usr/local/arm/arm-2009q3/bin/../arm-none-linux-gnue=
abi/libc/usr/lib/librt.a(mq_notify.o):
In function `mq_notify&#39;:</p>

<p class=3D"MsoNormal">mq_notify.c:(.text+0x68): undefined reference to
`pthread_once&#39;</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal"></p>



<p class=3D"MsoNormal">I don=92t get this error if I don&#39;t put
LDFLAGS=3D&quot;-static&quot; in configure command,</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">if I go to &quot;testcases/kernel/syscalls/mq_notify=
&quot;
and try to build using the command whatever the make is trying to do as
follows,</p><p class=3D"MsoNormal">----------------------------------------=
--------------------------------------------------------------------------<=
/p>

<p class=3D"MsoNormal">/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi=
-gcc -g
-O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=3D2
-I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
-I../../../../include -I../../../../include -static=A0 -L../../../../lib=A0=
 mq_notify01.c=A0=A0 -lltp -lpthread -lrt -o mq_notify01</p><p class=3D"Mso=
Normal">-------------------------------------------------------------------=
---------------------------------------------</p>


<p class=3D"MsoNormal">obviously I get the same error, but if I rearrange t=
he
pthread linker flag at the last as follows</p>

<p class=3D"MsoNormal">----------------------------------------------------=
-------------------------------------------------------------</p><p class=
=3D"MsoNormal">/usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi-gcc -g
-O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=3D2
-I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
-I../../../../include -I../../../../include -static=A0 -L../../../../lib=A0=
 mq_notify01.c=A0=A0 -lltp -lrt -o mq_notify01 -lpthread</p><p class=3D"Mso=
Normal">-------------------------------------------------------------------=
--------------------------------------------</p>


<p class=3D"MsoNormal">The compilation succeeds now</p>

<p class=3D"MsoNormal">Can someone help me how to cross compile ltp for arm=
 with
statically linking?</p></div>

--047d7b3442905a2a1604eb84ebb8--


--===============2980695223660191208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
--===============2980695223660191208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2980695223660191208==--

