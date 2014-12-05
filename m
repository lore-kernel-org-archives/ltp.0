Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XwqQc-0005ND-LG
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 10:48:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XwqQb-0008WG-84
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 10:48:02 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sB5Alsku015221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 05:47:54 -0500
From: Zorro Lang <zlang@redhat.com>
Date: Fri,  5 Dec 2014 18:47:50 +0800
Message-Id: <1417776470-12961-1-git-send-email-zlang@redhat.com>
Subject: [LTP] [PATCH] diotest: set errno with zero before test with zero
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

some code logic in diotest4.c likes below:
----
    ret = lseek(fd, offset, SEEK_SET);
    if ((ret >= 0) || (errno != EINVAL)) {
        tst_resm(TFAIL, "lseek allows negative offset. returns %d:%s", ret, strerror(errno));
        failed = TRUE;
        fail_count++;
    } else
        tst_resm(TPASS, "Negative Offset");

    ....
    ....

    ret = read(fd, buf, count);
    if (ret >= 0 || errno != errnum) {
        tst_resm(TFAIL, "read allows %s. returns %d: %s", msg, ret, strerror(errno));
        l_fail = TRUE;
    }
----

If lseek() EINVAL and read() return >= 0, the errno will not be setted to 0. The
errno will still be EINVAL.

I hit this problem when test on nfs. In NFS, lseek() return EINVAL as excepted,
but the read() will return 1, when count = 1. But the errno is still EINVAL.
That's incorrect.

So I set errno = 0, before read() and all other functions which like this.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

The problem likes above commit messge. Please review.

Thank you,
Zorro Lang

 testcases/kernel/io/direct_io/diotest4.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index fa90a1e..82c5b33 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -107,6 +107,7 @@ runtest_f(int fd, char *buf, int offset, int count, int errnum, int testnum,
 			l_fail = TRUE;
 		}
 	} else {
+		errno = 0;
 		ret = read(fd, buf, count);
 		if (ret >= 0 || errno != errnum) {
 			tst_resm(TFAIL, "read allows %s. returns %d: %s",
@@ -121,6 +122,7 @@ runtest_f(int fd, char *buf, int offset, int count, int errnum, int testnum,
 			l_fail = TRUE;
 		}
 	} else {
+		errno = 0;
 		ret = write(fd, buf, count);
 		if (ret >= 0 || errno != errnum) {
 			tst_resm(TFAIL, "write allows %s.returns %d: %s",
@@ -247,6 +249,7 @@ int main(int argc, char *argv[])
 	/* Test-1: Negative Offset */
 	offset = -1;
 	count = bufsize;
+	errno = 0;
 	ret = lseek(fd, offset, SEEK_SET);
 	if ((ret >= 0) || (errno != EINVAL)) {
 		tst_resm(TFAIL, "lseek allows negative offset. returns %d:%s",
@@ -284,6 +287,7 @@ int main(int argc, char *argv[])
 		fail_count++;
 		tst_resm(TFAIL, "Read beyond the file size");
 	} else {
+		errno = 0;
 		ret = read(fd, buf2, count);
 		if (ret > 0 || (ret < 0 && errno != EINVAL)) {
 			tst_resm(TFAIL,
@@ -392,6 +396,7 @@ int main(int argc, char *argv[])
 		failed = TRUE;
 		fail_count++;
 	} else {
+		errno = 0;
 		ret = read(fd, buf2, count);
 		if (ret >= 0 || errno != EBADF) {
 			tst_resm(TFAIL,
@@ -417,6 +422,7 @@ int main(int argc, char *argv[])
 		failed = TRUE;
 		fail_count++;
 	} else {
+		errno = 0;
 		ret = write(fd, buf2, count);
 		if (ret >= 0 || errno != EBADF) {
 			tst_resm(TFAIL,
@@ -460,6 +466,7 @@ int main(int argc, char *argv[])
 			 strerror(errno));
 		l_fail = TRUE;
 	} else {
+		errno = 0;
 		ret = read(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
 			 count);
 		if (ret >= 0 || errno != EFAULT) {
-- 
1.9.3


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
