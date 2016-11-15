From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 18:07:03 +0100
Subject: [LTP] Porting create_sig_proc() to new API
In-Reply-To: <20161115161729.kncclfxux2pos3he@dell5510>
References: <20161115161729.kncclfxux2pos3he@dell5510>
Message-ID: <20161115170702.GA26642@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> few syscall related tests depends on create_sig_proc(unsigned long usec, int sig,
> unsigned count) defined in testcases/kernel/syscalls/utils/common_j_h.c
> and other things from the old API.
> I suppose it's still waiting for porting, isn't it?

Well, if it's used from several testcases it should be prefixed with
tst_ and moved into a header in include/ and source file in lib/
diretory. In this case I would have used the implementation from
ppoll01.c.

-- 
Cyril Hrubis
chrubis@suse.cz
