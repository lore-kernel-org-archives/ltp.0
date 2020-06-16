From: Rong Chen <rong.a.chen@intel.com>
Date: Tue, 16 Jun 2020 20:24:52 +0800
Subject: [LTP] [LKP] Re: [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
References: <20200616075533.GL5653@shao2-debian>
 <87y2onbdtb.fsf@nanos.tec.linutronix.de>
Message-ID: <20200616122451.GQ5653@shao2-debian>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 16, 2020 at 10:44:00AM +0200, Thomas Gleixner wrote:
> kernel test robot <rong.a.chen@intel.com> writes:
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Is the head of linux.git exposing the same problem or is this an
> intermittent failure, which only affects bisectability?
> 

Hi Thomas,

The problem still exists in v5.8-rc1:

9f58fdde95c9509a  2bbc68f8373c0631ebf137f376                    v5.8-rc1  testcase/testparams/testbox
----------------  --------------------------  --------------------------  ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |    
           :12          92%          11:12         100%          13:13    ltp/1HDD-xfs-syscalls_part4/vm-snb
           :12          92%          11:12         100%          13:13    TOTAL ltp.ptrace08.fail

Best Regards,
Rong Chen
