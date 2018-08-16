From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Aug 2018 14:08:25 +0200
Subject: [LTP] [PATCH v3 2/4] tst_timer: Convert to new library
In-Reply-To: <20180816120020.11042-2-rpalethorpe@suse.com>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
 <20180816120020.11042-2-rpalethorpe@suse.com>
Message-ID: <20180816120825.GC6547@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> So we can use functions from new lib.

We still do have oldlib tests that link against this code.

Just grep for tst_timer_start, there are at least:

testcases/kernel/syscalls/nanosleep/nanosleep02.c
testcases/kernel/syscalls/fcntl/fcntl33.c

That has to be converted before we can apply this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
