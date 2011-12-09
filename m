Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RYxH6-0001E7-2P
	for ltp-list@lists.sourceforge.net; Fri, 09 Dec 2011 10:01:52 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RYxH5-0001Ug-69
	for ltp-list@lists.sourceforge.net; Fri, 09 Dec 2011 10:01:52 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pB9A1iL2003321
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Fri, 9 Dec 2011 02:01:45 -0800 (PST)
Message-ID: <4EE1DC85.3060301@windriver.com>
Date: Fri, 9 Dec 2011 18:01:41 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] Question about priority of pthread rwlock on linux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4575064121722602883=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4575064121722602883==
Content-Type: multipart/alternative;
	boundary="------------080303050405090909050906"

--------------080303050405090909050906
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I am working on Yocto( a kind of  embedded linux) to make POSIX test 
cases pass. It uses kernel 3.0 and eglibc 2.3.

There are 3 failed test cases about pthread rwlock:
pthread_rwlock_rdlock/2-1 pthread_rwlock_rdlock/2-2  
pthread_rwlock_unlock/3-1

In pthread_rwlock_rdlock/2-1,  main thread*read lock* a rwlock,  child 
thread1 *write lock* the rwlock with a medium priority, so it should be 
blocked. child thread2 try to *read lock *the rwlock with low priority, 
the case says child thread2 should block too. But in Yocto linux child 
thread2 doesn't block and then read lock the rwlock, that make test case 
fail.

In eglibc nptl implementation, rwlock has a element "__flags" to 
identify prefer write lock or read lock, default is to prefer read lock. 
If change __flags to prefer write lock, the test case will pass.

My questions are:
1 What is the test case base on? I checked the  POSIX.1-2008 but didn't 
find description priority about the pthread rwlock? Could anyone give me 
a source that make me to understand it better?
2 Which C library or platform can make this case pass? So that I can 
compare it with eglibc.

Thanks a lot!
Kai




--------------080303050405090909050906
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hello everyone,<br>
    <br>
    I am working on Yocto( a kind of&nbsp; embedded linux) to make POSIX test
    cases pass. It uses kernel 3.0 and eglibc 2.3.<br>
    <br>
    There are 3 failed test cases about pthread rwlock: <br>
    pthread_rwlock_rdlock/2-1 pthread_rwlock_rdlock/2-2&nbsp;
    pthread_rwlock_unlock/3-1<br>
    <br>
    In pthread_rwlock_rdlock/2-1,&nbsp; main thread<b> read lock</b> a
    rwlock,&nbsp; child thread1 <b>write lock</b> the rwlock with a medium
    priority, so it should be blocked. child thread2 try to&nbsp;<b> read
      lock </b>the rwlock with low priority, the case says child
    thread2 should block too. But in Yocto linux child thread2 doesn't
    block and then read lock the rwlock, that make test case fail.<br>
    <br>
    In eglibc nptl implementation, rwlock has a element "__flags" to
    identify prefer write lock or read lock, default is to prefer read
    lock. If change __flags to prefer write lock, the test case will
    pass. <br>
    <br>
    My questions are:<br>
    1 What is the test case base on? I checked the&nbsp; POSIX.1-2008 but
    didn't find description priority about the pthread rwlock? Could
    anyone give me a source that make me to understand it better?<br>
    2 Which C library or platform can make this case pass? So that I can
    compare it with eglibc.<br>
    <br>
    Thanks a lot!<br>
    Kai<br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------080303050405090909050906--


--===============4575064121722602883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point of 
discussion for anyone considering optimizing the pricing and packaging model 
of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
--===============4575064121722602883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4575064121722602883==--

