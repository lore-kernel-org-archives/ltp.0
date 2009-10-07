Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1Mvdqt-0005Mz-Nn
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 21:15:15 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mvdqs-00060w-Tg
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 21:15:15 +0000
Received: by pzk26 with SMTP id 26so4806204pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 07 Oct 2009 14:15:09 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 7 Oct 2009 14:15:08 -0700
Message-ID: <b9d696240910071415y74717dcelfb3aa368e2fe8f4c@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: [LTP] cgroupstats.h present but cannot be compiled
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5761124131395067260=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5761124131395067260==
Content-Type: multipart/alternative; boundary=000e0cd296dc753d1904755ed7c6

--000e0cd296dc753d1904755ed7c6
Content-Type: text/plain; charset=ISO-8859-1

When running configure for the latest LTP (Sept 2009) I see the following
warnings:

configure: WARNING: linux/cgroupstats.h: present but cannot be compiled
configure: WARNING: linux/cgroupstats.h:     check for missing prerequisite
headers?
configure: WARNING: linux/cgroupstats.h: see the Autoconf documentation
configure: WARNING: linux/cgroupstats.h:     section "Present But Cannot Be
Compiled"
configure: WARNING: linux/cgroupstats.h: proceeding with the preprocessor's
result
configure: WARNING: linux/cgroupstats.h: in the future, the compiler will
take precedence
configure: WARNING:     ## ------------------------------------------------
##
configure: WARNING:     ## Report this to ltp-results@lists.sourceforge.net##
configure: WARNING:     ## ------------------------------------------------
##
checking for linux/cgroupstats.h... yes


kdl


-- 
K.D. Lucas
kdlucas@gmail.com

--000e0cd296dc753d1904755ed7c6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

When running configure for the latest LTP (Sept 2009) I see the following w=
arnings:<br><br>configure: WARNING: linux/cgroupstats.h: present but cannot=
 be compiled<br>configure: WARNING: linux/cgroupstats.h:=A0=A0=A0=A0 check =
for missing prerequisite headers?<br>
configure: WARNING: linux/cgroupstats.h: see the Autoconf documentation<br>=
configure: WARNING: linux/cgroupstats.h:=A0=A0=A0=A0 section &quot;Present =
But Cannot Be Compiled&quot;<br>configure: WARNING: linux/cgroupstats.h: pr=
oceeding with the preprocessor&#39;s result<br>
configure: WARNING: linux/cgroupstats.h: in the future, the compiler will t=
ake precedence<br>configure: WARNING:=A0=A0=A0=A0 ## ----------------------=
-------------------------- ##<br>configure: WARNING:=A0=A0=A0=A0 ## Report =
this to <a href=3D"mailto:ltp-results@lists.sourceforge.net">ltp-results@li=
sts.sourceforge.net</a> ##<br>
configure: WARNING:=A0=A0=A0=A0 ## ----------------------------------------=
-------- ##<br>checking for linux/cgroupstats.h... yes<br><br><br>kdl<br><b=
r clear=3D"all"><br>-- <br>K.D. Lucas<br><a href=3D"mailto:kdlucas@gmail.co=
m">kdlucas@gmail.com</a><br>


--000e0cd296dc753d1904755ed7c6--


--===============5761124131395067260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============5761124131395067260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5761124131395067260==--

