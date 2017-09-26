From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Sep 2017 12:05:27 +0200
Subject: [LTP] [PATCH v4 6/7] Convert cve-2014-0196 to use long running
 threads
In-Reply-To: <20170925095137.31491-6-rpalethorpe@suse.com>
References: <20170925095137.31491-1-rpalethorpe@suse.com>
 <20170925095137.31491-6-rpalethorpe@suse.com>
Message-ID: <20170926100527.GB4884@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I'm getting warnings for this testcase on SLES12 SP2:

tst_test.c:934: INFO: Timeout per run is 0h 05m 00s
cve-2014-0196.c:103: INFO: Attempting to overflow into a tty_struct...
safe_macros.c:452: BROK: cve-2014-0196.c:90: write(-1,0x6156a0,18446744073709551615) failed: EBADF
cve-2014-0196.c:154: WARN: pthread_join(..., (nil)) failed: EDEADLK

Looks like the SAFE_WRITE() in the overwrite_thread_fn() races with the
SAFE_CLOSE() in the run() function.

-- 
Cyril Hrubis
chrubis@suse.cz
