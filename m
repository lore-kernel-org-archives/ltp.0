From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Mar 2019 14:39:38 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/2] lib/tst_numa: Add library for
 NUMA related syscalls
In-Reply-To: <20190307124620.2465-1-chrubis@suse.cz>
References: <20190307124620.2465-1-chrubis@suse.cz>
Message-ID: <20190307133937.GA2891@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Sigh, looks like this is causing linker failures on some distributions
when linker tries to resolve the symbols from tst_numa.c when linking
unrelated code against the LTP library. I will look into this.

See:
https://api.travis-ci.org/v3/job/503077808/log.txt

-- 
Cyril Hrubis
chrubis@suse.cz
