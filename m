From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 16 Jun 2020 10:44:00 +0200
Subject: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <20200616075533.GL5653@shao2-debian>
References: <20200616075533.GL5653@shao2-debian>
Message-ID: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

kernel test robot <rong.a.chen@intel.com> writes:
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Is the head of linux.git exposing the same problem or is this an
intermittent failure, which only affects bisectability?

Thanks,

        tglx
