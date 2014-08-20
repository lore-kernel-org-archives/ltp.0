Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XK1XV-0005E1-To
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 08:46:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XK1XU-0004wX-OB
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 08:46:41 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7K8kXve015833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Aug 2014 04:46:33 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7K8kWuB021232
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Aug 2014 04:46:33 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Aug 2014 10:46:30 +0200
Message-Id: <98fd8c728c27239472b635ea5e61ee69c3685a16.1408524328.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] timerfd_settime01: initialise itimerspec new_value
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

Before kernel validates that fd is valid, it checks itimerspec struct
with timespec_valid(). This struct is currently not initialised in test,
which can cause failures, for example:

timerfd_settime01    1  TFAIL  :  timerfd_settime01.c:121: timerfd_settime()
                        failed unexpectedly; expected: 9 - Bad file
                        descriptor: TEST_ERRNO=EINVAL(22): Invalid argument
timerfd_settime01    2  TFAIL  :  timerfd_settime01.c:121: timerfd_settime()
                        failed unexpectedly; expected: 14 - Bad address:
                        TEST_ERRNO=EINVAL(22): Invalid argument

Fix this by giving fields in this struct some deterministic values
(zero in this patch).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/timerfd/timerfd_settime01.c    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
index d12e40a..a1b04a5 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
@@ -58,6 +58,7 @@ static void setup(void);
 static void timerfd_settime_verify(const struct test_case_t *);
 static void cleanup(void);
 static int exp_enos[] = { EBADF, EFAULT, EINVAL, 0 };
+static struct itimerspec new_value;
 
 int main(int argc, char *argv[])
 {
@@ -103,7 +104,6 @@ static void setup(void)
 
 static void timerfd_settime_verify(const struct test_case_t *test)
 {
-	struct itimerspec new_value;
 	TEST(timerfd_settime(*test->fd, test->flags, &new_value,
 			     test->old_value));
 
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
