From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 17 Jan 2019 22:49:07 +0800
Subject: [LTP] [PATCH v5 ltp] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20190117105703.GB23942@rei.lan>
References: <20190116171645.13055-1-pengfei.xu@intel.com>
 <20190117105703.GB23942@rei.lan>
Message-ID: <20190117144907.p65z4fzl4njvhkhn@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
  Thanks a lot for your advice.
  Already correct them and resend again.
  Thanks again.

  BR.

On 2019-01-17 at 11:57:03 +0100, Cyril Hrubis wrote:
> Hi!
> > +		case 4:
> > +			asm_str();
> > +			break;
> > +		default:
> > +			tst_brk(TCONF, "Invalid tcase parameter:%d",
> > +				tc->option);
> > +		}
> > +	} else {
> > +		// let child process execute first
> > +		sleep(1);
> > +		SAFE_KILL(pid, SIGINT);
> 
> Is this still needed? As far as I can tell the child either gets killed
> by kernel or calls exit(0) right after it has been started.
> 
> I do frown upon every use of sleep() in tests and let me just explain
> the reason why.
> 
> We do have about 3000 of tests in LTP, if each of the tests was calling
> sleep() carelessly that would add up to an hour of useless waiting and
> we do care about the testsuite to finish as fast as possible for several
> reasons. Mainly because no sane developer would use tests that take so
> long to run. Minimizing the time needed to test a code change is hence
> the only way how the ensure that the tests are actually used in
> production and tests that are not used are completely pointless to begin
> with.
> 
> The second reason why sleep(1) is wrong is that, while it works fine in
> 99% of the cases, there is no guarantee that the child would actually
> finish under 1 second. In this case this would probably never be a
> problem, but if you did anything more compled in the child than
> executing a single instruction it will became a real problem as well.

Yes no need sleep and SAFE_KILL in parent process, already remove them.
Thanks.

> > +	}
> > +
> > +	// cpuinfo should contain umip
> > +	fp = SAFE_FOPEN(CPUINFO_FILE, "r");
> > +	while (!feof(fp)) {
> > +		if (fgets(buf, sizeof(buf), fp) == NULL) {
> 
> You should close the file here.
> 
> > +			tst_brk(TCONF, "cpuinfo show: cpu does not support umip");
> > +		}
> > +
> > +		if (!strstr(buf, "flags"))
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
