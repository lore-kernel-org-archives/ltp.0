Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <crosslonelyover@gmail.com>) id 1OtqvI-0006dm-Kk
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 23:52:56 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OtqvH-0005cq-Om
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 23:52:56 +0000
Received: by wye20 with SMTP id 20so2583050wye.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Sep 2010 16:52:50 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 10 Sep 2010 07:52:47 +0800
Message-ID: <AANLkTi=ufkOGaSbHpXfwC3sxCw8VwV+5-=ucGcDV8330@mail.gmail.com>
From: shenghui <crosslonelyover@gmail.com>
Subject: [LTP] wrong description in LTP HowTo section: 3.3 Compiling the
	test suite
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

I followed the description in LTP HowTo 3.3 section
               http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.3
to install LTP, and found that some description is wrong:

"This will create symbolic links of the executable to corresponding
files in ltp-yyyymmdd/ test-cases/bin directory."

I checked the executables under [install_dir]/testcases/bin, and
noticed that they are all executables, not symbolic links. I think
we'd better correct the description.


-- 


Thanks and Best Regards,
shenghui

------------------------------------------------------------------------------
Automate Storage Tiering Simply
Optimize IT performance and efficiency through flexible, powerful, 
automated storage tiering capabilities. View this brief to learn how
you can reduce costs and improve performance. 
http://p.sf.net/sfu/dell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
