From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Nov 2019 15:24:34 +0100
Subject: [LTP] [PATCH v3] syscalls/prctl02: add more error tests
In-Reply-To: <807018cc-88cb-eefd-594d-3940bab22765@cn.fujitsu.com>
References: <20191101084933.GA14639@dell5510>
 <1572613170-20757-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191107145416.GA25608@rei.lan>
 <3d882118-533e-f3a3-810b-b494f3f734d4@cn.fujitsu.com>
 <807018cc-88cb-eefd-594d-3940bab22765@cn.fujitsu.com>
Message-ID: <20191108142434.GA5913@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Ok. I will do it as we usually do.
> 
>  ??I think about it again. The argument of prctl is all unsigned long type. Do we need to use
> pointers to pointers??? Or, move this code to setup function like above?

Just pointer to unsigned long and do the cast in the test setup as:

static unsigned long bad_addr;

static struct tcase = {
	...
	unsigned long *arg3;
	...
} tcases[] = {
	...
	{..., &bad_addr, ...},
	...
}

static void setup(void)
{
	invalid_addr = (unigned long)tst_get_bad_addr();
}

Then call it as prctl(..., *tc->arg3).

-- 
Cyril Hrubis
chrubis@suse.cz
