From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 10 Jan 2019 18:45:19 +0800
Subject: [LTP] [PATCH v3 ltp] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20181129161449.GA23432@rei.lan>
References: <20181115090008.11440-1-pengfei.xu@intel.com>
 <20181129161449.GA23432@rei.lan>
Message-ID: <20190110104518.wi5wb5elb7l5vvuu@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On 2018-11-29 at 17:14:50 +0100, Cyril Hrubis wrote:
> Hi!
> > +			asm_smsw();
> > +			break;
> > +		case 4:
> > +			asm_str();
> > +			break;
> > +		default:
> > +			tst_brk(TCONF, "Invalid tcase parameter:%d",
> > +				tc->option);
> > +		}
> > +	} else {
> > +		sleep(1);
> 
> NACK to sleep(1) in tests, you are supposed to use proper parent-child
> synchronization.
> 
> What is the exact problem here?
> 
  sleep(1) just let child process execute first, and due to assembly
  trigger the SIGSEGV and child will be stopped, could not set
  raise(SIGSTOP) to let parent keep executing, so wait 1 second, and then
  child process will be finished(or SIGSEGV) before than parent process.
  Just for this.

> > +		SAFE_KILL(pid, SIGINT);
> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +

BR.
Thanks!
