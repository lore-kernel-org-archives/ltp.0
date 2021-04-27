From: xieziyao <xieziyao@huawei.com>
Date: Tue, 27 Apr 2021 01:49:08 +0000
Subject: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API
In-Reply-To: <YIa4PuDonH1Jwnlc@pevik>
References: <20210422065732.61222-1-xieziyao@huawei.com>
 <20210422065732.61222-2-xieziyao@huawei.com> <YIaWnt5ksxVyBvxk@pevik>
 <ae16017b01474cbb9d4d0e74e473a7c4@huawei.com> <YIa4PuDonH1Jwnlc@pevik>
Message-ID: <a4618c19e3934127ad6ea9fd6afd233c@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Petr, Cyril,

I think adding usleep(1000) in while loop is a good idea, thanks.

Best Regards,
Ziyao

-----Original Message-----
From: Petr Vorel [mailto:pvorel@suse.cz] 
Sent: Monday, April 26, 2021 8:55 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it; Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API

> Hi,

> Thanks for your review, Petr.

> > +	TEST(tst_syscall(__NR_tkill, tid, SIGUSR1));
> > +	if (TST_RET == 0) {
> > +		while (!sig_flag);

> This while loop is written to check whether the sighandler function captures the SIGUSR1 signal and set sig_flag to 1.

Oh, correct. But not sure if it's good to use plain while.
Maybe using usleep(1000) in while loop?

TST_EXP_PASS(tst_syscall(__NR_tkill, tid, SIGUSR1));

while (!sig_flag)
	usleep(1000);

Kind regards,
Petr

> > +		tst_res(TPASS, "tst_syscall(__NR_tkill, %d, SIGUSR1)", tid);
> > +	} else {
> > +		tst_res(TFAIL | TTERRNO,
> > +			"tst_syscall(__NR_tkill, %d, SIGUSR1)", tid);
> >  	}
> > -	cleanup();
> > -	tst_exit();
> >  }
