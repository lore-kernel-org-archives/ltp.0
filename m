Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kiran.Girmaji@emerson.com>) id 1NZNBo-0003sc-K0
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2010 11:33:04 +0000
Received: from usstlz-psecap05.emerson.com ([144.191.128.17]
	helo=USSTLZ-PSECAP06.EMERSON.COM)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NZNBn-0003ET-DM
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2010 11:33:04 +0000
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 25 Jan 2010 19:32:45 +0800
Message-ID: <89D32649C0790143AB985A5BF77A104F02C6ACB0@etsmsg-hkexm05.etsmsg.org>
From: <Kiran.Girmaji@Emerson.com>
Subject: [LTP] LTP configure error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9126879267721172284=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============9126879267721172284==
Content-Class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA9DB2.219B845C"

------_=_NextPart_001_01CA9DB2.219B845C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20
=20
I am getting this configure error while compiling LTP
(ltp-full-20091231) for PPC arch.
=20
configure: error: Couldn't find functional copy of quota v2 - are you
running 2.4.x?
=20
It works fine when I do CC for x86. I never before faced this with
ltp-full-20091031 release. I was able to CC for all archs. =20
=20
Below is my kernel and gcc versions -=20
=20
[root@g LTP]# uname -a
Linux kirang 2.6.18-8.el5 #1 SMP Fri Jan 26 14:15:21 EST 2007 i686 i686
i386 GNU/Linux
[root@g LTP]# gcc -v
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=3D/usr --mandir=3D/usr/share/man
--infodir=3D/usr/share/info --enable-shared --enable-threads=3Dposix
--enable-checking=3Drelease --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-libgcj-multifile
--enable-languages=3Dc,c++,objc,obj-c++,java,fortran,ada
--enable-java-awt=3Dgtk --disable-dssi --enable-plugin
--with-java-home=3D/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre
--with-cpu=3Dgeneric --host=3Di386-redhat-linux
Thread model: posix
gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)
[root@g LTP]#
=20

------_=_NextPart_001_01CA9DB2.219B845C
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16939" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D040262511-25012010>Hi,=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D040262511-25012010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D040262511-25012010>I am =
getting this=20
configure error while compiling LTP (ltp-full-20091231)&nbsp;for PPC=20
arch.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D040262511-25012010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D040262511-25012010><SPAN=20
class=3D040262511-25012010><EM>configure: error: Couldn't find =
functional copy of=20
quota v2 - are you running 2.4.x?</EM></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D040262511-25012010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D040262511-25012010>It =
works fine when I=20
do CC for x86. </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D040262511-25012010>I&nbsp;never before faced this with =
ltp-full-20091031=20
release.&nbsp;I&nbsp;was able to&nbsp;CC for all=20
archs.&nbsp;&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D040262511-25012010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D040262511-25012010>Below =
is my kernel=20
and gcc versions - </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D040262511-25012010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D040262511-25012010>[root@g LTP]# uname=20
-a<BR>Linux kirang 2.6.18-8.el5 #1 SMP Fri Jan 26 14:15:21 EST 2007 i686 =
i686=20
i386 GNU/Linux<BR>[root@g LTP]# gcc -v<BR>Using built-in =
specs.<BR>Target:=20
i386-redhat-linux<BR>Configured with: ../configure --prefix=3D/usr=20
--mandir=3D/usr/share/man --infodir=3D/usr/share/info --enable-shared=20
--enable-threads=3Dposix --enable-checking=3Drelease --with-system-zlib=20
--enable-__cxa_atexit --disable-libunwind-exceptions =
--enable-libgcj-multifile=20
--enable-languages=3Dc,c++,objc,obj-c++,java,fortran,ada =
--enable-java-awt=3Dgtk=20
--disable-dssi --enable-plugin=20
--with-java-home=3D/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre =
--with-cpu=3Dgeneric=20
--host=3Di386-redhat-linux<BR>Thread model: posix<BR>gcc version 4.1.1 =
20070105=20
(Red Hat 4.1.1-52)<BR>[root@g LTP]#</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D040262511-25012010><EM></EM></SPAN></FONT>&nbsp;</DIV></BODY></HT=
ML>

------_=_NextPart_001_01CA9DB2.219B845C--


--===============9126879267721172284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============9126879267721172284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9126879267721172284==--

