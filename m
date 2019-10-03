From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Oct 2019 15:49:59 +0200
Subject: [LTP] [PATCH] open_posix/conformance/clock/1.1: Deterministic
 timing
In-Reply-To: <ae7daebd-0a33-823c-1434-56a081480c0e@jv-coder.de>
References: <20190925092958.125325-1-lkml@jv-coder.de>
 <20190926122546.GA27993@rei>
 <ae7daebd-0a33-823c-1434-56a081480c0e@jv-coder.de>
Message-ID: <20191003134959.GE1858@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I was actually thinking the same, but decided to use time() because of 
> a) it doesn't matter much as long as some time passes by and b) 
> monotonic clocks are an optional feature in posix.

Fair enough, applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
