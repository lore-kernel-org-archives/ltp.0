Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naveenspen@gmail.com>) id 1MHEYK-0008IJ-W4
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 10:09:04 +0000
Received: from mail-yx0-f185.google.com ([209.85.210.185])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHEYJ-0001rq-6u
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 10:09:04 +0000
Received: by yxe15 with SMTP id 15so33188yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Jun 2009 03:09:02 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 15:39:02 +0530
Message-ID: <ab64ec20906180309x1388d972k6f7d6cf730af9578@mail.gmail.com>
From: naveen penumala <naveenspen@gmail.com>
Subject: [LTP] installation error ltp-full-20090531
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5427989409456789078=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

--===============5427989409456789078==
Content-Type: multipart/alternative; boundary=001e680f0dd4df2508046c9c9828

--001e680f0dd4df2508046c9c9828
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

Please look at the below error. Looks like the LTP is not creating /bin
directory in testcases directory.

Here i'm using suse and kernel version is  2.6.16.21

i'm getting similar kind of errors for all the test cases. Help me regarding
this.

ln: creating hard link `../../../bin/mem01' to `mem01': No such file or
directory
make: *** [install] Error 1

ln: creating hard link `../../../bin/mtest01' to `mtest01': No such file or
directory
make: *** [install] Error 1


Thanks,
Naveen P

--001e680f0dd4df2508046c9c9828
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi <br><br>Please look at the below error. Looks like the LTP is not creati=
ng /bin directory in testcases directory.<br><br>Here i&#39;m using suse an=
d kernel version is=A0 2.6.16.21<br><br>i&#39;m getting similar kind of err=
ors for all the test cases. Help me regarding this.<br>
<br><span style=3D"color: rgb(255, 0, 0);">ln: creating hard link `../../..=
/bin/mem01&#39; to `mem01&#39;: No such file or directory</span><br style=
=3D"color: rgb(255, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">make: **=
* [install] Error 1</span><br style=3D"color: rgb(255, 0, 0);">
<br><span style=3D"color: rgb(255, 0, 0);">ln: creating hard link `../../..=
/bin/mtest01&#39; to `mtest01&#39;: No such file or directory</span><br sty=
le=3D"color: rgb(255, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">make: =
*** [install] Error 1</span><br>
<br><br>Thanks,<br>Naveen P<br>

--001e680f0dd4df2508046c9c9828--


--===============5427989409456789078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============5427989409456789078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5427989409456789078==--

