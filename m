From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jan 2016 16:54:27 +0100
Subject: [LTP] Some LTP testcases are getting failed
In-Reply-To: <MA1PR01MB0056C6904C4A16BDB6646D2182C70@MA1PR01MB0056.INDPRD01.PROD.OUTLOOK.COM>
References: <MA1PR01MB00562DFACF1908498176882C82C70@MA1PR01MB0056.INDPRD01.PROD.OUTLOOK.COM>
 <56A5E4EB.4050802@oracle.com>
 <MA1PR01MB0056C6904C4A16BDB6646D2182C70@MA1PR01MB0056.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20160126155427.GA21514@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi Stanislav,
> Thnak you for your response.
> 
> Following is the complete output of the rt_sigaction01 test case.
> rt_sigaction01    0  TINFO  :  signal: 34 
> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result = 0 
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO 
> Bus error

Looks like Stanislav was right. Have a look at
sysdeps/unix/sysv/linux/mips/sigaction.c in glibc to get an idea what
should be added to LTP to include/lapi/sigaction.h.

-- 
Cyril Hrubis
chrubis@suse.cz
