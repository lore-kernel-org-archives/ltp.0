From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jun 2021 15:29:54 +0200
Subject: [LTP] [PATCH 4/4 v2] syscalls/fcntl: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <YJV4MtK/5NvpIXbU@pevik>
References: <20210506050047.935-1-zhaogongyi@huawei.com>
 <YJV4MtK/5NvpIXbU@pevik>
Message-ID: <YL4fUslxI4IIG5Am@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> not sure if change to use goto satisfied Cyril's requirement:
> 
> we should rather skip the test in the main instead
> as it was done in the original code as:
> 
> 	if (NO_NFS)
> 		run_test(...);
> 	else
> 		tst_resm(TCONF, "Skipping mandatory locking on NFS");

Yes I still think that the code looks better if we skip the test in the
main here.

-- 
Cyril Hrubis
chrubis@suse.cz
