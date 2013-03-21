Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sgr.m.pdy@gmail.com>) id 1UIZe5-0000Om-7g
	for ltp-list@lists.sourceforge.net; Thu, 21 Mar 2013 07:10:41 +0000
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UIZe3-0001AD-Vi
	for ltp-list@lists.sourceforge.net; Thu, 21 Mar 2013 07:10:40 +0000
Received: by mail-oa0-f47.google.com with SMTP id o17so2800632oag.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Mar 2013 00:10:34 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 21 Mar 2013 12:40:34 +0530
Message-ID: <CAFzFL17=aoZ-dWXSv7kY8RUfC8r-b_VU=g5L3w0yfPtwbRZMaQ@mail.gmail.com>
From: Sagar Padhye <sgr.m.pdy@gmail.com>
Subject: [LTP] LTP for Android
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4977714431683286273=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4977714431683286273==
Content-Type: multipart/alternative; boundary=e89a8fb20546eb7d5204d86a0810

--e89a8fb20546eb7d5204d86a0810
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I am trying to test android kernel with LTP without any success.
What I have tried:
environment setup:
ARCH=arm-eabi
CROSS_COMPILER=/home/sagar/mytoolchain/bin/arm-linux-androideabi
NDK_ROOT=/home/sagar/android-ndk-r8d
CC=$CROSS_COMPILER-gcc
LD=$CROSS_COMPILER-ld
AR=$CROSS_COMPILER-ar
STRIP=$CROSS_COMPILER-strip
RANLIB=$CROSS_COMPILER-ranlib
CFLAGS="-I/home/sagar/android-ndk-r8d/platforms/android-14/arch-arm/usr/include
-D_ANDROID -nostdlib -DDEV_BSIZE=512"
LDFLAGS="-Wl,-rpath-link=/home/sagar/android-ndk-r8d/platforms/android-14/arch-arm/usr/lib
-L/home/sagar/android-ndk-r8d/platforms/android-14/arch-arm/usr/lib"
LIBS="-lc"

when I do "./configure --host=arm-eabi" & "make", I get
parse_opts.c:76:24: fatal error: sys/signal.h: No such file or directory

From mailing lists, it looks like somebody has already submitted a patch to
support Android 2.2, I don't know if it was accepted. Does anybody know if
LTP supports Android (hopefully 4.x, Which I am trying to test)? If yes,
what are steps to compile & run LTP?


-- 
Thanks and Regards,
Sagar

--e89a8fb20546eb7d5204d86a0810
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I am trying to test android kernel with LTP withou=
t any success.</div><div>What I have tried:</div><div>environment setup:</d=
iv><div><div>ARCH=3Darm-eabi</div><div>CROSS_COMPILER=3D/home/sagar/mytoolc=
hain/bin/arm-linux-androideabi</div>
<div>NDK_ROOT=3D/home/sagar/android-ndk-r8d</div><div>CC=3D$CROSS_COMPILER-=
gcc</div><div>LD=3D$CROSS_COMPILER-ld</div><div>AR=3D$CROSS_COMPILER-ar</di=
v><div>STRIP=3D$CROSS_COMPILER-strip</div><div>RANLIB=3D$CROSS_COMPILER-ran=
lib</div>
<div>CFLAGS=3D&quot;-I/home/sagar/android-ndk-r8d/platforms/android-14/arch=
-arm/usr/include -D_ANDROID -nostdlib -DDEV_BSIZE=3D512&quot;</div><div>LDF=
LAGS=3D&quot;-Wl,-rpath-link=3D/home/sagar/android-ndk-r8d/platforms/androi=
d-14/arch-arm/usr/lib -L/home/sagar/android-ndk-r8d/platforms/android-14/ar=
ch-arm/usr/lib&quot;</div>
<div>LIBS=3D&quot;-lc&quot;</div></div><div><br></div><div style>when I do =
&quot;./configure --host=3Darm-eabi&quot; &amp; &quot;make&quot;, I get</di=
v><div style>parse_opts.c:76:24: fatal error: sys/signal.h: No such file or=
 directory<br>
</div><div><br></div><div style>From mailing lists, it looks like somebody =
has already submitted a patch to support Android 2.2, I don&#39;t know if i=
t was accepted. Does anybody know if LTP supports Android (hopefully 4.x, W=
hich I am trying to test)? If yes, what are steps to compile &amp; run LTP?=
</div>
<div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr">Thanks and Re=
gards,<div>Sagar</div></div>
</div></div>

--e89a8fb20546eb7d5204d86a0810--


--===============4977714431683286273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
--===============4977714431683286273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4977714431683286273==--

