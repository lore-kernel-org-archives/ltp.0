From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Nov 2019 14:14:12 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <20191121183401.GA20889@dell5510>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
 <20191121183401.GA20889@dell5510>
Message-ID: <20191125131411.GB8703@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> No, there is no support for TST_CHECKPOINT in shell.

Well there is actually. There is a tst_checkpoint helper that calls
tst_reinit() to map the shared page to be used with futexes and then
just calls the corresponding wake or wait function.

And yes it has been used in the cgroup testcases to synchronize C
helper that allocates memory and shell test that executes it.

-- 
Cyril Hrubis
chrubis@suse.cz
