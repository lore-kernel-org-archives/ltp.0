From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 17 Jan 2019 01:39:45 +0800
Subject: [LTP] [PATCH v4 ltp] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20190116134523.GE24833@rei>
References: <20190110105856.32422-1-pengfei.xu@intel.com>
 <20190116134523.GE24833@rei>
Message-ID: <20190116173945.sr5lued43raaczu5@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
  Thanks for your advice.
  I make it complex and contain potential risk.

BR.

On 2019-01-16 at 14:45:24 +0100, Cyril Hrubis wrote:
> Hi!
> 
> I think I already tried to explain that signal handler runs
> asynchronously to the rest of the code and that calling anything else
> than a few signal-async-safe functions may cause undefined behavior,
> which mostly translates to deadlocks.
> 
> Why can't we write the test as:
> 
> 	SAFE_WAITPID(pid, &status, 0);
> 
> 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> 		tst_res(TPASS, "Got SIGSEGV");
> 		return;
> 	}
> 
> 	tst_res(TFAIL, "Child exitted with %s", tst_strstatus(status));
> }
> 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
