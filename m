From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 3 Oct 2019 23:43:18 +0800
Subject: [LTP] [PATCH tbt_cases] umip_basic_test.c: update umip basic
 test for new kernel v5.4
In-Reply-To: <20191003121402.GD1858@rei>
References: <20190927031930.27425-1-pengfei.xu@intel.com>
 <20191003121402.GD1858@rei>
Message-ID: <20191003154318.cixq4onhnrzv3tpp@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Hrubis,

  Thanks a lot for your comments! :)
  BR.

On 2019-10-03 at 14:14:02 +0200, Cyril Hrubis wrote:
> Hi!
> > +		/* after linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW will return
> > +		   dummy value and not trigger SIGSEGV due to kernel code change */
> > +		#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0)
> 
> This is obviously wrong, the version you get here is the version from
> kernel headers that does not correspond to the kernel you are running
> on at all.
> 
> We do have tst_kvercmp() function in LTP that uses parses uname() output
> and returns if you are running on kernel newer/same/older as the version
> passed to that function. Use that one instead.
> 
  Will use tst_kvercmp function, thanks.

> > +			tst_res(TINFO, "Linux kernel version is after than v5.4");
> > +			if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > +				tst_res(TFAIL, "Got SIGSEGV\n\n");
> > +				return;
> > +			}
> > +			tst_res(TPASS, "Didn't receive SIGSEGV, child exited with %s\n\n",
> > +				tst_strstatus(status));
> > +				return;
> 				^
> 				Wrong indentation.
> 
  Yes, will correct it.


> > +		#else
> > +			tst_res(TINFO, "Linux kernel version is before than v5.4");
> > +		#endif
> > +	}
> > +
> >  	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > -		tst_res(TPASS, "Got SIGSEGV");
> > +		tst_res(TPASS, "Got SIGSEGV\n\n");
> >  		return;
> >  	}
> > -	tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s",
> > +	tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s\n\n",
> >  		tst_strstatus(status));
> 
> Can you please avoid polluting output with useless newlines as well?
> 
> >  }
  Ok, will avoid useless newlines.
  Thanks for all comments, will correct them.

> >  
> > -- 
> > 2.14.1
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
