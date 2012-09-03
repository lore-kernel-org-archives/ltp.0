Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vikasbisla15@gmail.com>) id 1T8VZp-0000io-1E
	for ltp-list@lists.sourceforge.net; Mon, 03 Sep 2012 12:16:25 +0000
Received: from mail-wg0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T8VZj-0004lM-Gn
	for ltp-list@lists.sourceforge.net; Mon, 03 Sep 2012 12:16:25 +0000
Received: by wgbfm10 with SMTP id fm10so3230860wgb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Sep 2012 05:16:13 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 3 Sep 2012 21:16:13 +0900
Message-ID: <CALFGhcTOGwfj=WQJL8FJn8q8LsEPe3fD+KEJBTjidxM47=PL6A@mail.gmail.com>
From: vikas bisla <vikasbisla15@gmail.com>
Subject: [LTP] Compling LTP for android Using Ndk revision 8
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6729224790326661959=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6729224790326661959==
Content-Type: multipart/alternative; boundary=f46d043c7f38925ac704c8cb1b93

--f46d043c7f38925ac704c8cb1b93
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

We are trying to compile LTP for android using NDK tool chain.

Flags set while configuration-

./configure --host=arm-eabi
CC=/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc
CPPFLAGS="-I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/"
CFLAGS="-nostdlib"
LDFLAGS="-Wl,-rpath-link=/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/
-L/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/"
LIBS="-lc"

After Config we are doing

Make ARCH=arm

it is giving following error.

/Desktop/LTP/ltp-full-20120903$ make ARCH=arm
make -C "lib" \
-f "/home/vikas/Desktop/LTP/ltp-full-20120903/lib/Makefile" all
make[1]: Entering directory `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'
/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc -nostdlib -g -O2
-fno-strict-aliasing -pipe -Wall
-I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/
-I../include -I../include -I../include -I../include  -c -o
bytes_by_prefix.o bytes_by_prefix.c
bytes_by_prefix.c: In function 'bytes_by_prefix':
bytes_by_prefix.c:94: error: 'B_MULT' undeclared (first use in this
function)
bytes_by_prefix.c:94: error: (Each undeclared identifier is reported only
once
bytes_by_prefix.c:94: error: for each function it appears in.)
bytes_by_prefix.c: In function 'lbytes_by_prefix':
bytes_by_prefix.c:142: error: 'B_MULT' undeclared (first use in this
function)
bytes_by_prefix.c: In function 'llbytes_by_prefix':
bytes_by_prefix.c:193: error: 'B_MULT' undeclared (first use in this
function)
make[1]: *** [bytes_by_prefix.o] Error 1
make[1]: Leaving directory `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'
make: *** [lib-all] Error 2

Can anybody please suggest some pointer so that we can go forward.

Regards
vikas bisla

--f46d043c7f38925ac704c8cb1b93
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi <font color=3D"#000099">All,</font><div><font color=3D"#000099"><br></fo=
nt></div><div><font color=3D"#000099">We are trying to compile LTP for andr=
oid using NDK tool chain.=A0</font></div><div><font color=3D"#000099"><br><=
/font></div>
<div><font color=3D"#000099">Flags set while configuration-=A0</font></div>=
<div><font color=3D"#000099"><br></font></div><div><font color=3D"#000099">=
./configure --host=3Darm-eabi CC=3D/home/vikas/Desktop/LTP/arm-eabi-4.4.3/b=
in/arm-eabi-gcc CPPFLAGS=3D&quot;-I/home/vikas/Desktop/android-ndk-r8b/plat=
forms/android-14/arch-arm/usr/include/&quot; CFLAGS=3D&quot;-nostdlib&quot;=
 LDFLAGS=3D&quot;-Wl,-rpath-link=3D/home/vikas/Desktop/android-ndk-r8b/plat=
forms/android-14/arch-arm/usr/lib/ -L/home/vikas/Desktop/android-ndk-r8b/pl=
atforms/android-14/arch-arm/usr/lib/&quot; LIBS=3D&quot;-lc&quot;</font></d=
iv>
<div><font color=3D"#000099"><br></font></div><div><font color=3D"#000099">=
After Config we are doing=A0</font></div><div><font color=3D"#000099"><br><=
/font></div><div><font color=3D"#000099">Make ARCH=3Darm</font></div><div><=
font color=3D"#000099"><br>
</font></div><div><font color=3D"#000099">it is giving following error.</fo=
nt></div><div><font color=3D"#000099"><br></font></div><div><font color=3D"=
#000099"><div>/Desktop/LTP/ltp-full-20120903$ make ARCH=3Darm</div><div>mak=
e -C &quot;lib&quot; \</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>-f &=
quot;/home/vikas/Desktop/LTP/ltp-full-20120903/lib/Makefile&quot; all</div>=
<div>make[1]: Entering directory `/home/vikas/Desktop/LTP/ltp-full-20120903=
/lib&#39;</div>
<div>/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc -nostdlib -g -=
O2 -fno-strict-aliasing -pipe -Wall -I/home/vikas/Desktop/android-ndk-r8b/p=
latforms/android-14/arch-arm/usr/include/ -I../include -I../include -I../in=
clude -I../include =A0-c -o bytes_by_prefix.o bytes_by_prefix.c</div>
<div>bytes_by_prefix.c: In function &#39;bytes_by_prefix&#39;:</div><div>by=
tes_by_prefix.c:94: error: &#39;B_MULT&#39; undeclared (first use in this f=
unction)</div><div>bytes_by_prefix.c:94: error: (Each undeclared identifier=
 is reported only once</div>
<div>bytes_by_prefix.c:94: error: for each function it appears in.)</div><d=
iv>bytes_by_prefix.c: In function &#39;lbytes_by_prefix&#39;:</div><div>byt=
es_by_prefix.c:142: error: &#39;B_MULT&#39; undeclared (first use in this f=
unction)</div>
<div>bytes_by_prefix.c: In function &#39;llbytes_by_prefix&#39;:</div><div>=
bytes_by_prefix.c:193: error: &#39;B_MULT&#39; undeclared (first use in thi=
s function)</div><div>make[1]: *** [bytes_by_prefix.o] Error 1</div><div>
make[1]: Leaving directory `/home/vikas/Desktop/LTP/ltp-full-20120903/lib&#=
39;</div><div>make: *** [lib-all] Error 2</div><div><br></div><div>Can anyb=
ody please suggest some pointer so that we can go forward.=A0</div><div><br=
>
</div><div>Regards</div><div>vikas bisla</div></font></div>

--f46d043c7f38925ac704c8cb1b93--


--===============6729224790326661959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============6729224790326661959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6729224790326661959==--

