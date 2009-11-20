Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <markver@us.ibm.com>) id 1NBLEw-0008Sr-2O
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 04:36:58 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NBLEp-0002f5-Sm
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 04:36:58 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAK4SYQn009022
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 23:28:34 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAK4aZYb1499386
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 23:36:35 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAK4aZjw024556
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 23:36:35 -0500
Received: from d01ml096.pok.ibm.com (d01ml096.pok.ibm.com [9.63.10.19])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	nAK4aZhx024552
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 23:36:35 -0500
In-Reply-To: <mailman.154899.1258686361.5856.ltp-list@lists.sourceforge.net>
References: <mailman.154899.1258686361.5856.ltp-list@lists.sourceforge.net>
Message-ID: <OFE61AA50B.0F49D448-ON85257674.001663A2-85257674.0019522C@us.ibm.com>
From: Mark Ver <markver@us.ibm.com>
Date: Thu, 19 Nov 2009 23:36:34 -0500
MIME-Version: 1.0
Subject: Re: [LTP] execution on latest builds
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1388699083509206514=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1388699083509206514==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFCE7DF85E5328f9e8a93df938690918c0ABBFCE7DF85E532"
Content-Disposition: inline

--0__=0ABBFCE7DF85E5328f9e8a93df938690918c0ABBFCE7DF85E532
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Hi,

Finally got the latest build to compile all the way through on s390x.

Just to make sure I'm doing this right ... If I keep all the default
parameters,  then an example of how to deal with the new build would be=
 the
following?

# tar xvzf ltp-full-20091031.tgz
# cd ltp-full-20091031
# ./configure
# make
# make install
# cd /opt/ltp
# ./runalltests.sh

Also, I guess there's no way to make it work exactly like before anymor=
e?
Cause if I try to set prefix=3D$TOP_SRCDIR then it gets conflicts (I gu=
ess
cause it's trying to move stuff from the source directory to the execut=
ion
directory and I have them set to the same directory).  Not to mention, =
it
causes "make clean" to remove my source directory (while I'm still in i=
t).
I guess it's time to change my automation ...


- Mark Ver

office:  Building 710 / Room 2-RF-10
phone: (845) 435-7794  [tie 8 295-7794]=

--0__=0ABBFCE7DF85E5328f9e8a93df938690918c0ABBFCE7DF85E532
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>Hi,<br>
<br>
Finally got the latest build to compile all the way through on s390x.<b=
r>
<br>
Just to make sure I'm doing this right ... If I keep all the default pa=
rameters,  then an example of how to deal with the new build would be t=
he following?<br>
<br>
# tar xvzf ltp-full-20091031.tgz<br>
# cd ltp-full-20091031<br>
# ./configure<br>
# make<br>
# make install<br>
# cd /opt/ltp<br>
# ./runalltests.sh<br>
<br>
Also, I guess there's no way to make it work exactly like before anymor=
e?   Cause if I try to set prefix=3D$TOP_SRCDIR then it gets conflicts =
(I guess cause it's trying to move stuff from the source directory to t=
he execution directory and I have them set to the same directory).  Not=
 to mention, it causes &quot;make clean&quot; to remove my source direc=
tory (while I'm still in it).  I guess it's time to change my automatio=
n ... <br>
<br>
<br>
- Mark Ver<br>
<br>
office:  Building 710 / Room 2-RF-10<br>
phone: (845) 435-7794  [tie 8 295-7794]<br>
</body></html>=

--0__=0ABBFCE7DF85E5328f9e8a93df938690918c0ABBFCE7DF85E532--



--===============1388699083509206514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1388699083509206514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1388699083509206514==--


