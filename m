From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Mar 2020 21:41:07 +0100
Subject: [LTP] [PATCH v3] Fix use after stack unwind in fzsync lib
In-Reply-To: <20200326152828.14934-1-mdoucha@suse.cz>
References: <20200326152828.14934-1-mdoucha@suse.cz>
Message-ID: <20200326204107.GA26499@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> tst_fzsync_pair_reset() passes a local variable to thread B which may be
> already unwinded by the time the thread wrapper function executes. If new
> variables get allocated and initialized on stack between pthread_create()
> and thread wrapper execution, thread B will segfault.

I naively assumed this would fix SIGKILL signal for CVE 2018-1000199 test,
but it didn't.

Kind regards,
Petr
