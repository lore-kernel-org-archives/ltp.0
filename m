Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jubitaneja@gmail.com>) id 1S9V6N-0006Nd-MY
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 05:25:51 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S9V6N-0006YS-4I
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 05:25:51 +0000
Received: by vcbfl13 with SMTP id fl13so9341020vcb.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Mar 2012 22:25:45 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 19 Mar 2012 10:55:45 +0530
Message-ID: <CABxY-SJqTBTDJQimvByQT3GEnk021YtHggPgw9F5NWk9ec8uXg@mail.gmail.com>
From: Jubi Taneja <jubitaneja@gmail.com>
Subject: [LTP] Query regarding Open Posix fail Test Case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7819978026899099683=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7819978026899099683==
Content-Type: multipart/alternative; boundary=20cf307ac769503dc704bb91caea

--20cf307ac769503dc704bb91caea
Content-Type: text/plain; charset=ISO-8859-1

Hi

In LTP(Jan 2012 release) Open Posix Test Suite, the test case
"aio-suspend/1-1.c" passes
successfully for Linux Kernel 2.6.35 for Target ARM but the same test case
fails for Kernel
version: 3.0.18.

It throws error as :
aio_suspend/1-1.c Error at write(): No such file or directory.

Can any one please point out the reason for the failure in kernel 3.0.18
for target ARM?

The exact path of the test case is :
LTP/testcases/open_posix_testsuite/conformance/
interfaces/aio_suspend/1-1.c

Looking forward to your reply.

Thanks,
Jubi

--20cf307ac769503dc704bb91caea
Content-Type: text/html; charset=ISO-8859-1

Hi<br><br>In LTP(Jan 2012 release) Open Posix Test Suite, the test case &quot;aio-suspend/1-1.c&quot; passes <br>
successfully for Linux Kernel 2.6.35 for Target ARM but the same test case fails for Kernel <br>version: 3.0.18.<br>
<br>It throws error as : <br>aio_suspend/1-1.c Error at write(): No such file or directory. <br><br>Can any one please point out the reason for the failure in kernel 3.0.18 for target ARM? <br><br>The exact path of the test case is : <br>

LTP/testcases/open_posix_testsuite/conformance/<div>interfaces/aio_suspend/1-1.c<br><br>Looking forward to your reply.<br><br>Thanks,<br>Jubi<br></div>

--20cf307ac769503dc704bb91caea--


--===============7819978026899099683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============7819978026899099683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7819978026899099683==--

