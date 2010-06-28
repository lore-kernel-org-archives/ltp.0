Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vishwa.hochihally@gmail.com>) id 1OT8ls-0002Wr-8Y
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 07:28:48 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OT8lq-0002RS-2A
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 07:28:48 +0000
Received: by pxi20 with SMTP id 20so640836pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Jun 2010 00:28:36 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 28 Jun 2010 12:58:35 +0530
Message-ID: <AANLkTilncmIFzbwnHMEJKXsJagIMP9mSicqIZ5dQelLJ@mail.gmail.com>
From: vishwanath govind <vishwa.hochihally@gmail.com>
Subject: [LTP] Not cloning all the files from ltp-dev
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4404662530421416604=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4404662530421416604==
Content-Type: multipart/alternative; boundary=0016e64cc488902155048a1211ba

--0016e64cc488902155048a1211ba
Content-Type: text/plain; charset=ISO-8859-1

Hi,
 I have tried to clone the latest LTP source through GIT but missing
"configure" file in it.

Here are my steps:

  # git://*ltp*.git.sourceforge.net/gitroot/*ltp*/*ltp*-dev.git *ltp*

* # ls ltp*
COPYING  ChangeLog   INSTALL   Makefile.release  README.ltp-devel.in
TODO          doc         include  ltp-devel.spec.in  m4   result
runltp         runtest  testcases    tools  ver_linux
CREDITS  IDcheck.sh  Makefile  README            README.mk-devel
configure.ac  execltp.in  lib      ltpmenu            pan  runalltests.sh
runltplite.sh  scripts  testscripts  utils
*Why is "configure" file is missing here?*

Please let me know your thoughts?

Regards
Vishwa

--0016e64cc488902155048a1211ba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0I have tried=A0to clone the latest LTP source through GIT but missi=
ng &quot;configure&quot; file in it.=A0</div>
<div>=A0</div>
<div>Here are my steps:</div>
<div>=A0</div>
<div>=A0 # git://<b class=3D"highlight">ltp</b>.<a href=3D"http://git.sourc=
eforge.net/gitroot/">git.sourceforge.net/gitroot/</a><b class=3D"highlight"=
>ltp</b>/<b class=3D"highlight">ltp</b>-dev.git <b class=3D"highlight">ltp<=
/b></div>

<div>=A0</div>
<div><strong>=A0# ls ltp</strong></div>
<div>COPYING=A0 ChangeLog=A0=A0 INSTALL=A0=A0 Makefile.release=A0 <a href=
=3D"http://README.ltp-devel.in">README.ltp-devel.in</a>=A0 TODO=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 doc=A0=A0=A0=A0=A0=A0=A0=A0 include=A0 <a href=3D"http://lt=
p-devel.spec.in">ltp-devel.spec.in</a>=A0 m4=A0=A0 result=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 runltp=A0=A0=A0=A0=A0=A0=A0=A0 runtest=A0 testcases=A0=A0=A0 tool=
s=A0 ver_linux<br>
CREDITS=A0 IDcheck.sh=A0 Makefile=A0 README=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 README.mk-devel=A0=A0=A0=A0=A0 <a href=3D"http://configure.ac">configur=
e.ac</a>=A0 <a href=3D"http://execltp.in">execltp.in</a>=A0 lib=A0=A0=A0=A0=
=A0 ltpmenu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pan=A0 runalltests.sh=A0 runlt=
plite.sh=A0 scripts=A0 testscripts=A0 utils<br>
</div>
<div><strong>Why is &quot;configure&quot; file is missing here?</strong></d=
iv>
<div>=A0</div>
<div>Please let me know your thoughts?</div>
<div>=A0</div>
<div>Regards</div>
<div>Vishwa</div>

--0016e64cc488902155048a1211ba--


--===============4404662530421416604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============4404662530421416604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4404662530421416604==--

