From: Gao Feng <fgao@ikuai8.com>
Date: Wed, 15 Feb 2017 10:02:40 +0800
Subject: [LTP] [lkp-robot] [net] 0148239373: ltp.test_1_to_1_sockopt.fail
In-Reply-To: <20170215014612.GQ18272@yexl-desktop>
References: <1486559235-13633-1-git-send-email-fgao@ikuai8.com>
 <20170215014612.GQ18272@yexl-desktop>
Message-ID: <CA+6hz4qnvo7+Qd=2Uqf+t2+SqQ2ggoM_ggCvcxaeih1Tx=ySEg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiaolong,

On Wed, Feb 15, 2017 at 9:46 AM, kernel test robot
<xiaolong.ye@intel.com> wrote:
>
> FYI, we noticed the following commit:
>
> commit: 0148239373801a9c0c63eefc481b710ae7ce2941 ("net: sock: Use double send/recv buff value to compare with max value")
> url: https://github.com/0day-ci/linux/commits/fgao-ikuai8-com/net-sock-Use-double-send-recv-buff-value-to-compare-with-max-value/20170208-213745
>
>
> in testcase: ltp
> with following parameters:
>
>         test: net.sctp
>
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
>
>
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> user  :notice: [   54.674772] tag=test_1_to_1_sockopt stime=1487093637
>
> user  :notice: [   54.675078] cmdline="test_1_to_1_sockopt"
>
> user  :notice: [   54.675194] contacts=""
>
> user  :notice: [   54.675333] analysis=exit
>
> user  :notice: [   54.675513] <<<test_output>>>
>
> user  :notice: [   54.676497] test_1_to_1_sockopt.c    1  TPASS  :  setsockopt() with a bad socket descriptor - EBADF
>
> user  :notice: [   54.677439] test_1_to_1_sockopt.c    2  TPASS  :  setsockopt() with an invalid socket - ENOTSOCK
>
> user  :notice: [   54.678409] test_1_to_1_sockopt.c    3  TPASS  :  setsockopt() with an invalid level - ENOPROTOOPT
>
> user  :notice: [   54.679378] test_1_to_1_sockopt.c    4  TPASS  :  setsockopt() with invalid option buffer - EFAULT
>
> user  :notice: [   54.680375] test_1_to_1_sockopt.c    5  TPASS  :  setsockopt() with invalid option name - EOPNOTSUPP
>
> user  :notice: [   54.681354] test_1_to_1_sockopt.c    6  TPASS  :  getsockopt() with a bad socket descriptor - EBADF
>
> user  :notice: [   54.682297] test_1_to_1_sockopt.c    7  TPASS  :  getsockopt() with an invalid socket - ENOTSOCK
>
> user  :notice: [   54.683265] test_1_to_1_sockopt.c    8  TPASS  :  getsockopt() with invalid option buffer - EFAULT
>
> user  :notice: [   54.684267] test_1_to_1_sockopt.c    9  TPASS  :  getsockopt() with invalid option name - EOPNOTSUPP
>
> user  :notice: [   54.685079] test_1_to_1_sockopt.c   10  TPASS  :  getsockopt() SCTP_INITMSG - SUCCESS
>
> user  :notice: [   54.685885] test_1_to_1_sockopt.c   11  TPASS  :  setsockopt() SCTP_INITMSG - SUCCESS
>
> user  :notice: [   54.686653] test_1_to_1_sockopt.c   12  TPASS  :  setsockopt() SO_LINGER - SUCCESS
>
> user  :notice: [   54.687418] test_1_to_1_sockopt.c   13  TPASS  :  getsockopt() SO_LINGER - SUCCESS
>
> user  :notice: [   54.688187] test_1_to_1_sockopt.c   14  TPASS  :  getsockopt() SO_RCVBUF - SUCCESS
>
> user  :notice: [   54.688979] test_1_to_1_sockopt.c   15  TPASS  :  getsockopt() SCTP_STATUS - SUCCESS
>
> user  :notice: [   54.689752] test_1_to_1_sockopt.c   16  TPASS  :  setsockopt() SO_RCVBUF - SUCCESS
>
> user  :notice: [   54.691539] test_1_to_1_sockopt.c   17  TBROK  :  test_1_to_1_sockopt.c:341: Comparison failed:Set value and got value differs Set Value=4096 Get Value=8192
>
> user  :notice: [   54.692520] test_1_to_1_sockopt.c   18  TBROK  :  test_1_to_1_sockopt.c:341: Remaining cases broken
>
>
>
> To reproduce:
>
>         git clone git://git.kernel.org/pub/scm/linux/kernel/git/wfg/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
>
>
> Thanks,
> Xiaolong

This commit is not accepted, thanks.
After discuss with Eric, I know it is too late to correct it.

Regards
Feng


