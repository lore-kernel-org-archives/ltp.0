Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jubitaneja@gmail.com>) id 1S9XgY-0004aE-Eq
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 08:11:22 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S9XgT-0002RL-30
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 08:11:22 +0000
Received: by vcbfl13 with SMTP id fl13so9421534vcb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Mar 2012 01:11:11 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 19 Mar 2012 13:41:11 +0530
Message-ID: <CABxY-SKB1ebi1xEfp_-MysXWQ_d_fh3knfPphoW1c9r5ucWU5w@mail.gmail.com>
From: Jubi Taneja <jubitaneja@gmail.com>
Subject: [LTP] Query regarding Open Posix Test Case failure
	(pthread_rwlock_rdlock)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3986587934481061205=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3986587934481061205==
Content-Type: multipart/alternative; boundary=20cf307f33d8f1fcd604bb941975

--20cf307f33d8f1fcd604bb941975
Content-Type: text/plain; charset=ISO-8859-1

Hi

In LTP(Jan 2012 release) Open Posix Test Suite, the test case
"pthread_rwlock_rdlock/2-1.c"
fails for Linux Kernel 3.0.18 for target ARM.


The exact output of the program is:
main: has priority: 3
main: attempt read lock
main: acquired read lock
main: create wr_thread, with priority: 2
wr_thread: attempt write lock
main: create rd_thread, with priority: 1
rd_thread: attempt read lock
rd_thread: acquired read lock
rd_thread: unlock read lock
Test FAILED: rd_thread did not block on read lock, when a reader owns the
lock, and a higher
priority writer is waiting for the lock



The path of the program si :
VDLTP_20120104/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock

Ca anyone please explain why it fails at this point? I am unable to catch
the exact reason.

Looking forward to your reply.

Thanks,
Jubi

--20cf307f33d8f1fcd604bb941975
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>In LTP(Jan 2012 release) Open Posix Test Suite, the test case &qu=
ot;pthread_rwlock_rdlock/2-1.c&quot; <br>fails for Linux Kernel 3.0.18 for =
target ARM. <br><br><br>The exact output of the program is:<br>main: has pr=
iority: 3<br>

main: attempt read lock<br>main: acquired read lock<br>main: create wr_thre=
ad, with priority: 2<br>wr_thread: attempt write lock<br>main: create rd_th=
read, with priority: 1<br>rd_thread: attempt read lock<br>rd_thread: acquir=
ed read lock<br>

rd_thread: unlock read lock<br>Test FAILED: rd_thread did not block on read=
 lock, when a reader owns the lock, and a higher <br>priority writer is wai=
ting for the lock<br><br>=A0<br><br>The path of the program si : <br>VDLTP_=
20120104/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlo=
ck_rdlock<br>

<br>Ca anyone please explain why it fails at this point? I am unable to cat=
ch the exact reason. <br><br>Looking forward to your reply.<br><br>Thanks,<=
br>Jubi <br>

--20cf307f33d8f1fcd604bb941975--


--===============3986587934481061205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============3986587934481061205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3986587934481061205==--

