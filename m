Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1N5Pv7-0002ko-Gj
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:24:01 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5Puz-0007NH-O0
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:24:01 +0000
Received: by pxi9 with SMTP id 9so4131266pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 12:23:47 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 3 Nov 2009 12:23:47 -0800
Message-ID: <b9d696240911031223h6734d911s57830e7d859813f9@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: [LTP] 20091031 won't run
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7532344295084947735=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7532344295084947735==
Content-Type: multipart/alternative; boundary=000e0cd14a9a8642a804777d45b8

--000e0cd14a9a8642a804777d45b8
Content-Type: text/plain; charset=ISO-8859-1

I downloaded the latest LTP, which is version 20091031. I ran ./configure,
make, and make install. I notice that now make tries to write file to
/opt/ltp/, so I needed to run make as root.

When I go to run ltp, I get:

FATAL: Test suite not installed correctly
INFO: as root user type 'make ; make install'

Is this a known issue?

kdl

-- 
K.D. Lucas
kdlucas@gmail.com

--000e0cd14a9a8642a804777d45b8
Content-Type: text/html; charset=ISO-8859-1

I downloaded the latest LTP, which is version 20091031. I ran ./configure, make, and make install. I notice that now make tries to write file to /opt/ltp/, so I needed to run make as root.<div><br></div><div>When I go to run ltp, I get:</div>
<div><br></div><div><div>FATAL: Test suite not installed correctly</div><div>INFO: as root user type &#39;make ; make install&#39;</div><div><br></div><div>Is this a known issue?</div><div><br></div><div>kdl</div><br>-- <br>
K.D. Lucas<br><a href="mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>
</div>

--000e0cd14a9a8642a804777d45b8--


--===============7532344295084947735==
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
--===============7532344295084947735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7532344295084947735==--

