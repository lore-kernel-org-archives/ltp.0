From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Apr 2021 14:55:26 +0200
Subject: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API
In-Reply-To: <ae16017b01474cbb9d4d0e74e473a7c4@huawei.com>
References: <20210422065732.61222-1-xieziyao@huawei.com>
 <20210422065732.61222-2-xieziyao@huawei.com>
 <YIaWnt5ksxVyBvxk@pevik>
 <ae16017b01474cbb9d4d0e74e473a7c4@huawei.com>
Message-ID: <YIa4PuDonH1Jwnlc@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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
