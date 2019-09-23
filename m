From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 23 Sep 2019 10:11:40 +0200
Subject: [LTP] 12abeb544d: ltp.read_all_dev.fail
In-Reply-To: <20190923003846.GB15734@shao2-debian>
References: <20190923003846.GB15734@shao2-debian>
Message-ID: <871rw7l9dv.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

kernel test robot <rong.a.chen@intel.com> writes:

> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 12abeb544d548f55f56323fc6e5e6c0fb74f58e1 ("horrible test hack")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/luto/linux.git random/kill-it
>
> in testcase: ltp
> with following parameters:
>
> 	disk: 1HDD
> 	fs: ext4
> 	test: fs-02
>
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
> <<<test_start>>>
> tag=read_all_dev stime=1569106866
> cmdline="read_all -d /dev -p -q -r 10"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1108: INFO: Timeout per run is 0h 05m 00s
> Test timeouted, sending SIGKILL!
> tst_test.c:1148: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1149: BROK: Test killed! (timeout?)

So perhaps this is caused by reads of /dev/random hanging? At any rate,
I suppose this is intended to deliberately break something, so we can
ignore it.

--
Thank you,
Richard.
