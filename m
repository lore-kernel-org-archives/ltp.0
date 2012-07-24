Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Nitin.Yadav@mphasis.com>) id 1StZPZ-00064f-LP
	for ltp-list@lists.sourceforge.net; Tue, 24 Jul 2012 07:20:05 +0000
Received: from mpmulip3.mphasis.com ([203.12.222.67])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1StZPS-0000rx-KI
	for ltp-list@lists.sourceforge.net; Tue, 24 Jul 2012 07:20:05 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 24 Jul 2012 12:46:34 +0530
Message-ID: <E351E450E8B9F54684A699D42DC5ADF2230115EB@MPBAGVEX02.corp.mphasis.com>
In-Reply-To: <1343109556-12022-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <241B7B02-77E9-4181-B4BA-F2276F1DCBE2@gmail.com>
	<1343109556-12022-1-git-send-email-gaowanlong@cn.fujitsu.com>
From: "Nitin Yadav" <Nitin.Yadav@mphasis.com>
Subject: Re: [LTP] [PATCH V2] open_posix:aio_fsync:14-1: wait for
	aio_writecompletion
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>, LTP <ltp-list@lists.sourceforge.net>

Hi Wanlong,
 Even I am getting error io_fsync write: Invalid argument, while running
io test cases on linux 3.2 kernel.Below are the outputs for error.

aio02/aio_tio    0  TINFO  :  Running test 1

aio02/aio_tio    0  TINFO  :  Running test 2

aio02/aio_tio    0  TINFO  :  Running test 3

aio02/aio_tio    0  TINFO  :  Running test 4

aio02/aio_tio    0  TINFO  :  Running test 5

aio02/aio_tio    0  TINFO  :  Running test 6

aio02/aio_tio    0  TINFO  :  Running test 7

io_fsync write: Invalid argument 


Could you please suggest me some pointer.

Thanks!
Nitin yadav

-----Original Message-----
From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com] 
Sent: Tuesday, July 24, 2012 11:29 AM
To: LTP
Subject: [LTP] [PATCH V2] open_posix:aio_fsync:14-1: wait for
aio_writecompletion

Wait for aio_write() completion.
If aio_fsync() sync the fd without the previous aio_write()
completion, it will cause Segment Fault.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 .../conformance/interfaces/aio_fsync/14-1.c                    | 10
++++++++++
 1 file changed, 10 insertions(+)

diff --git
a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
index a9cd3bf..02ba8a5 100644
---
a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
+++
b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
@@ -27,6 +27,7 @@ int main()
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
+	int ret;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
@@ -57,6 +58,15 @@ int main()
 		exit(PTS_FAIL);
 	}
 
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_write);
+	} while (ret == EINPROGRESS);
+	if (ret < 0) {
+		printf(TNAME " Error at aio_error() : %s\n",
strerror(ret));
+		exit(PTS_FAIL);
+	}
+
 	memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
 	aiocb_fsync.aio_fildes = fd;
 
-- 
1.7.11.3.287.ge771946


------------------------------------------------------------------------
------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond.
Discussions 
will include endpoint security, mobile security and the latest in
malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Information transmitted by this e-mail is proprietary to MphasiS, its associated companies and/ or its customers and is intended 
for use only by the individual or entity to which it is addressed, and may contain information that is privileged, confidential or 
exempt from disclosure under applicable law. If you are not the intended recipient or it appears that this mail has been forwarded 
to you without proper authority, you are notified that any use or dissemination of this information in any manner is strictly 
prohibited. In such cases, please notify us immediately at mailmaster@mphasis.com and delete this mail from your records.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
