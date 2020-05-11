From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 11 May 2020 16:13:06 +0530
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <CAEemH2cX=zyULO6qZBV5fBQv74dm2yuiUeRJ8SMe7OXYWJJ_sQ@mail.gmail.com>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAEemH2cX=zyULO6qZBV5fBQv74dm2yuiUeRJ8SMe7OXYWJJ_sQ@mail.gmail.com>
Message-ID: <20200511104306.x4sit6vy2a4bmcgc@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09-05-20, 12:21, Li Wang wrote:
> RHEL8.2(x84_64) failed as:
> 
> # ./semop05
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> semop05.c:147: INFO: Testing variant: semop: vDSO or syscall
> semop05.c:132: PASS: expected failure: EIDRM (43)
> semop05.c:132: PASS: expected failure: EIDRM (43)
> semop05.c:132: PASS: expected failure: EINTR (4)
> semop05.c:132: PASS: expected failure: EINTR (4)
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> semop05.c:147: INFO: Testing variant: semtimedop: syscall with kernel spec64
> semop05.c:134: FAIL: unexpected failure: EAGAIN/EWOULDBLOCK (11)
> Test timeouted, sending SIGKILL!
> tst_test.c:1286: INFO: If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1
> tst_test.c:1287: BROK: Test killed! (timeout?)
> 
> 
> RHEL8.2(s390x) failed as:
> 
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> semop05.c:147: INFO: Testing variant: semop: vDSO or syscall
> semop05.c:132: PASS: expected failure: EIDRM (43)
> semop05.c:132: PASS: expected failure: EIDRM (43)
> semop05.c:132: PASS: expected failure: EINTR (4)
> semop05.c:132: PASS: expected failure: EINTR (4)
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> semop05.c:147: INFO: Testing variant: semtimedop: syscall with kernel spec64
> semop.h:13: CONF: syscall(392) __NR_semtimedop not supported
> Test timeouted, sending SIGKILL!
> tst_test.c:1286: INFO: If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1
> tst_test.c:1287: BROK: Test killed! (timeout?)

Some part of the timeout was left uninitialized and so was causing
some issues. Can you please try with this delta:

diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
index f892cd519ecf..0e18f77ba1f5 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop05.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
@@ -120,6 +120,7 @@ static void do_child(int i)
        struct tst_ts timeout;
 
        timeout.type = tv->type;
+       tst_ts_set_sec(&timeout, 1);
        tst_ts_set_nsec(&timeout, 10000);
 
        TEST(call_semop(tv, sem_id, &s_buf, 1, &timeout));

-- 
viresh
