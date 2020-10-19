From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Oct 2020 13:55:00 +0200
Subject: [LTP] Power Management Test
In-Reply-To: <BMXPR01MB234447E6D624AF3311D14760EE1E0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB234447E6D624AF3311D14760EE1E0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20201019115500.GA21912@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am running LTP on my RISCV arch with custom kernel 5.5.6 and i am  trying to run power management tests from LTP. i want to test following states
> 1) Suspend to idle 2) Suspend to RAM 3) OFF state
> 
> Are the test covered in power management suite  are only x86 specific ?? Does the test included in power management suite of LTP  covers above ?

As far as I can tell there are no tests for suspend states in LTP. The
power_managenent tests are testing mostly cpufreq related.

-- 
Cyril Hrubis
chrubis@suse.cz
