Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <andreas@digitalplaywright.com>) id 1SMCG6-0008GM-Td
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 05:56:22 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SMCG5-000336-Su
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 05:56:22 +0000
Received: by bkcjk7 with SMTP id jk7so3397002bkc.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 22 Apr 2012 22:56:14 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 22 Apr 2012 22:29:49 -0700
Message-ID: <CAFkf=XoJnHYOZ3gVoyDjekjd3xp_YGQ==A7zvPqgMtgkdzzmnw@mail.gmail.com>
From: Andreas Saebjoernsen <andreas@digitalplaywright.com>
Subject: [LTP] Test for linux syscall 240 cc sys_futex
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0817392465137433064=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0817392465137433064==
Content-Type: multipart/alternative; boundary=000e0cdfd900476dcf04be51edc6

--000e0cdfd900476dcf04be51edc6
Content-Type: text/plain; charset=ISO-8859-1

We are implementing a binary analysis tool that need to marshal Linux
system calls, and we've been using LTP to guide our implementation. We need
tests for syscall 240 sys_futex, and we can not find a test for this in
LTP. Please let us know if you have any advice on where to find tests for
syscalls 240 sys_futex.

I was able to locate an old thread about futex tests:
  - http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg07268.html

There is some futex tests in the Linux Checkpoint Restart Testsuite, but I
am not sure if these are sufficient. Please let us know what the best
solution is for testing syscall 240 sys_futex.

Thank you.

Best,
Andeas

--000e0cdfd900476dcf04be51edc6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

We are implementing a binary analysis tool that need to marshal Linux syste=
m calls, and we&#39;ve been using LTP to guide our=A0implementation. We nee=
d tests for syscall 240=A0sys_futex, and we can not find a test for this in=
 LTP. Please let us know if you have any advice on where to find tests for =
syscalls 240 sys_futex.<div>


<br></div><div>I was able to locate an old thread about futex tests:</div><=
div>=A0 -=A0<a href=3D"http://www.mail-archive.com/ltp-list@lists.sourcefor=
ge.net/msg07268.html" target=3D"_blank">http://www.mail-archive.com/ltp-lis=
t@lists.sourceforge.net/msg07268.html</a></div>

<div><br></div><div>There is some futex tests in the Linux Checkpoint Resta=
rt Testsuite, but I am not sure if these are sufficient. Please let us know=
 what the best solution is for testing syscall 240 sys_futex.</div>
<div><br></div><div>Thank you.</div><div><br><div>Best,</div><div>Andeas</d=
iv></div>

--000e0cdfd900476dcf04be51edc6--


--===============0817392465137433064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============0817392465137433064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0817392465137433064==--

