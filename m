From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Mar 2018 12:55:18 +0100
Subject: [LTP] SIGSEGV in faccessat01 and fchmodat01
In-Reply-To: <BY2PR13MB070967D607D2E7F4F797189A90D10@BY2PR13MB0709.namprd13.prod.outlook.com>
References: <BY2PR13MB070967D607D2E7F4F797189A90D10@BY2PR13MB0709.namprd13.prod.outlook.com>
Message-ID: <20180315115518.GB17877@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Have anyone had these problem?
> Is there any requirement for these test? or is anyone can give me a direction, I'll be appreciated
> 
> <<<test_output>>>
> faccessat01    1  TBROK  :  tst_sig.c:233: unexpected signal SIGSEGV(11) received (pid = 2134).
> faccessat01    2  TBROK  :  tst_sig.c:233: Remaining cases broken
> 
> <<<test_output>>>
> fchmodat01    1  TBROK  :  tst_sig.c:233: unexpected signal SIGSEGV(11) received (pid = 2289).
> fchmodat01    2  TBROK  :  tst_sig.c:233: Remaining cases broken

Can you run the test under gdb and send the backtrace?

-- 
Cyril Hrubis
chrubis@suse.cz
