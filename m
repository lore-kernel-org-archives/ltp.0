From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 Jun 2021 16:32:50 +0200
Subject: [LTP] [PATCH 4/4 v2] syscalls/fcntl: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <YL4fUslxI4IIG5Am@yuki>
References: <20210506050047.935-1-zhaogongyi@huawei.com>
 <YJV4MtK/5NvpIXbU@pevik> <YL4fUslxI4IIG5Am@yuki>
Message-ID: <YL4uEokhUu0gv/2h@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao, Cyril,

> Hi!
> > not sure if change to use goto satisfied Cyril's requirement:

> > we should rather skip the test in the main instead
> > as it was done in the original code as:

> > 	if (NO_NFS)
> > 		run_test(...);
> > 	else
> > 		tst_resm(TCONF, "Skipping mandatory locking on NFS");

> Yes I still think that the code looks better if we skip the test in the
> main here.

+1. Replacing int return with goto err for no reason is ugly.
Zhao, would you please send v3 with this fixed?

Kind regards,
Petr
