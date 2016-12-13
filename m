From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 13 Dec 2016 17:09:59 +0800
Subject: [LTP]  rt_sigtimedwait01 failed in armv7l
Message-ID: <584FBAE7.2010100@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, These is a fail about rt_sigtimedwait01(armv7l GNU/Linux and linux 3.10):
root@arma9el:/tmp# ./rt_sigtimedwait01
rt_sigtimedwait01    0  TINFO  :  0x9fd0, 10
rt_sigtimedwait01    1  TPASS  :  Test passed
rt_sigtimedwait01    0  TINFO  :  0x9fd0, 10
rt_sigtimedwait01    2  TPASS  :  Test passed
...
rt_sigtimedwait01    0  TINFO  :  0x9fd0, 12
rt_sigtimedwait01   11  TPASS  :  Test passed
rt_sigtimedwait01    0  TINFO  :  0x9fd0, 15
rt_sigtimedwait01   12  TPASS  :  Test passed
rt_sigtimedwait01   12  TPASS  :  sigwaitinfo restored the original mask
rt_sigtimedwait01    0  TINFO  :  0x9fd0, -1

rt_sigtimedwait01   13  TFAIL  :  /home/cuibixuan/ltp/testcases/kernel/syscalls/rt_sigtimedwait/../sigwaitinfo/sigwaitinfo01.c:56:
test_masked_matching_rt (/home/cuibixuan/ltp/testcases/kernel/syscalls/rt_sigtimedwait/../sigwaitinfo/sigwaitinfo01.c: 274): Unexpected return value; expected 35, got 36
rt_sigtimedwait01   13  TFAIL  :  /home/cuibixuan/ltp/testcases/kernel/syscalls/rt_sigtimedwait/../sigwaitinfo/sigwaitinfo01.c:56:
test_masked_matching_rt (/home/cuibixuan/ltp/testcases/kernel/syscalls/rt_sigtimedwait/../sigwaitinfo/sigwaitinfo01.c: 282): Unexpected return value; expected 36, got 35
rt_sigtimedwait01   13  TPASS  :  sigwaitinfo restored the original mask


I add 'sleep(1)' into test_masked_matching_rt() of ltp/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c:268

void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
...
/* Run a child that will wake us up */
        child[0] = create_sig_proc(0, signo, 1);
+       sleep(1);
        child[1] = create_sig_proc(0, signo + 1, 1);

Then the case pass:
rt_sigtimedwait01   13  TPASS  :  Test passed
rt_sigtimedwait01   13  TPASS  :  Test passed
rt_sigtimedwait01   13  TPASS  :  sigwaitinfo restored the original mask

Or run it by 'chrt 10 ./rt_sigtimedwait01' then pass.

Why? Can someone give me a hand.

Thanks,
Cui Bixuan




