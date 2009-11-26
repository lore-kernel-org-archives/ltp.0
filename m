Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Poornima.Nayak@in.ibm.com>) id 1NDiMp-0004rt-GV
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 17:42:55 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NDiMi-0006hI-Px
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 17:42:55 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id nAQHgajA005664
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Nov 2009 23:12:36 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAQHgaNh2846878
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Nov 2009 23:12:36 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAQHgZLG006354
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Nov 2009 23:12:35 +0530
MIME-Version: 1.0
Message-ID: <OFD2A634F2.AA55F33B-ON6525767A.0060D7CD-6525767A.00614813@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Thu, 26 Nov 2009 23:14:01 +0530
Subject: [LTP] utils directory is not getting copied in /opt/ltp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2948725431922567256=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============2948725431922567256==
Content-Type: multipart/alternative;
	boundary="=_alternative 006148106525767A_="

This is a multipart message in MIME format.
--=_alternative 006148106525767A_=
Content-Type: text/plain; charset="US-ASCII"

Hi Garret

Power Management functionality testcases are dependent on scirpts in utils 
directoy. The October released LTP does not copy 'utils's directory to 
/opt/ltp.
I tried setting 'utils' in COMMON_TARGETS still utils directory does not 
get copied to /opt/ltp. 
If you could you give me a patch which I can apply to my test setup and 
continue my testing would be great help.

Regards
Poornima 
--=_alternative 006148106525767A_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi Garret</font>
<br>
<br><font size=2 face="sans-serif">Power Management functionality testcases
are dependent on scirpts in utils directoy. The October released LTP does
not copy 'utils's directory to /opt/ltp.</font>
<br><font size=2 face="sans-serif">I tried setting 'utils' in COMMON_TARGETS
still utils directory does not get copied to /opt/ltp. </font>
<br><font size=2 face="sans-serif">If you could you give me a patch which
I can apply to my test setup and continue my testing would be great help.</font>
<br>
<br><font size=2 face="sans-serif">Regards</font>
<br><font size=2 face="sans-serif">Poornima </font>
--=_alternative 006148106525767A_=--


--===============2948725431922567256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2948725431922567256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2948725431922567256==--

