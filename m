From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Mar 2019 14:29:32 +0100
Subject: [LTP] [PATCH] syscalls: add rt_tgsigqueueinfo() test-case
In-Reply-To: <1fc28a33-6ed8-9be1-caf5-dde3606f1b6f@google.com>
References: <1551097931-18320-1-git-send-email-sumit.garg@linaro.org>
 <1fc28a33-6ed8-9be1-caf5-dde3606f1b6f@google.com>
Message-ID: <20190305132932.GB13703@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It looks like the pthread here is sending the signal to itself which 
> seems like a special case. Not that it isn't worth testing but I'd think 
> there should be a test which sends the signal to a different thread. 
> This (the self-send case) could be an additional test.
> 
> > +	if (TST_RET)
> > +		tst_res(TFAIL, "Test Failed");
> > +	else
> > +		tst_res(TPASS, "Test Succeeded");
> 
> I recommend verifying the signal and its data (si_value) are delivered 
> successfully prior to test completion.

Agreed.

Also we do have rt_sigqueueinfo01.c tests that lacks these checks as
well, it may be a good idea to rewrite that test as well, quite possibly
some code could be shared between these two as well.

-- 
Cyril Hrubis
chrubis@suse.cz
