Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1Oj5HI-00048g-IW
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 06:59:08 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oj5HG-00084R-Ao
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 06:59:08 +0000
Received: by wyb38 with SMTP id 38so15848444wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 10 Aug 2010 23:59:00 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Aug 2010 12:29:00 +0530
Message-ID: <AANLkTimUmvdHqx4YEYE29BcfJjoEMpW2QeHYa-KwCdSF@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] dio testcase failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2925154542111691594=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2925154542111691594==
Content-Type: multipart/alternative; boundary=00504502d533c6bf58048d86c80f

--00504502d533c6bf58048d86c80f
Content-Type: text/plain; charset=ISO-8859-1

dio" testcase results in failure of many tests ie. 25 out of 28.
The cause of error is "tst_rmdir()" like....
Tst_rmdir():failed:errno=16: device or resource busy.
How can I overcome this error.?

-- 
Arjit........

--00504502d533c6bf58048d86c80f
Content-Type: text/html; charset=ISO-8859-1

dio&quot; testcase results in failure of many tests ie. 25 out of 28.<br>The cause of error is &quot;tst_rmdir()&quot; like....<br>Tst_rmdir():failed:errno=16: device or resource busy.<br>How can I overcome this error.?<br clear="all">
<br>-- <br>Arjit........<br>

--00504502d533c6bf58048d86c80f--


--===============2925154542111691594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--===============2925154542111691594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2925154542111691594==--

