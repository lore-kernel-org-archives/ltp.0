From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Feb 2020 14:49:02 +0100
Subject: [LTP] [PATCH v7 3/4] lapi/fsmount: Add definitions for fsmount
 related syscalls
In-Reply-To: <20200217084622.11199-4-pvorel@suse.cz>
References: <20200217084622.11199-1-pvorel@suse.cz>
 <20200217084622.11199-4-pvorel@suse.cz>
Message-ID: <20200217134902.GC14410@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This adds definitions for all fsmount related syscalls which will be
> used by multiple syscall tests.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Li Wang <liwang@redhat.com>
> [ pvorel: add autotools checks + sort kcmp ]

If we were pedantic the sort is unrelated change that should be commited
in a separate patch...

-- 
Cyril Hrubis
chrubis@suse.cz
