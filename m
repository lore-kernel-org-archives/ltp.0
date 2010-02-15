Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vishwa.hochihally@gmail.com>) id 1NguoJ-00065v-9e
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 06:51:59 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NguoI-0005Yl-Du
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 06:51:59 +0000
Received: by pzk9 with SMTP id 9so2902826pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Feb 2010 22:51:52 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 15 Feb 2010 12:21:52 +0530
Message-ID: <4b9fdcd01002142251l2cb9036fvde4fbc60bbae85a4@mail.gmail.com>
From: vishwanath govind <vishwa.hochihally@gmail.com>
Subject: [LTP] facing issue "TBROK : nobody not in /etc/passwd"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6578803639265254542=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6578803639265254542==
Content-Type: multipart/alternative; boundary=000e0cd139bc5bad1a047f9e0d78

--000e0cd139bc5bad1a047f9e0d78
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I am facing common issue which causing many of the LTP syscalls test cases
to fail. I have taken mknod02 test to show this issue here. Definitely I am
missing something out here, could you guys please point me to right
direction?  Please let me know if you need some more info/log

======================log================================
# ls /etc
group   passwd

# ./IDcheck.sh
Checking for required user/group ids
'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.

# cat /etc/passwd
root:x:0:0:root::
nobody:x:99:99:nobody::
bin:x:1:1:bin::
daemon:x:2:2:daemon::

#uname -a
Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010 armv6l GNU/Linux

# ./mknod02
mknod02     1  TBROK  :  nobody not in /etc/passwd

======================end========================================

Regards
Vishwa

--000e0cd139bc5bad1a047f9e0d78
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>Hi,<br>I am facing common issue which causing many of the LTP syscal=
ls test cases to fail. I have taken mknod02 test to show this issue here. D=
efinitely I am missing something out here, could you guys please point me t=
o right direction?=A0 Please let me know if you need some more info/log<br>
=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlo=
g=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br># ls /etc<br>group=A0=A0 passwd</p>
<p># ./IDcheck.sh<br>Checking for required user/group ids<br>&#39;nobody&#3=
9; user id and group found.<br>&#39;bin&#39; user id and group found.<br>&#=
39;daemon&#39; user id and group found.<br>Users group found.<br>Sys group =
found.<br>
Required users/groups exist.<br>=A0<br># cat /etc/passwd<br>root:x:0:0:root=
::<br>nobody:x:99:99:nobody::<br>bin:x:1:1:bin::<br>daemon:x:2:2:daemon::</=
p>
<p>#uname -a<br>Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010=
 armv6l GNU/Linux</p>
<p># ./mknod02<br>mknod02=A0=A0=A0=A0 1=A0 TBROK=A0 :=A0 nobody not in /etc=
/passwd</p>
<p>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dend=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=A0<br>Regards<br>Vishwa</p>

--000e0cd139bc5bad1a047f9e0d78--


--===============6578803639265254542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============6578803639265254542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6578803639265254542==--

