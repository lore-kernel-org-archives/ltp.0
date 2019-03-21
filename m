From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 12:07:23 +0100
Subject: [LTP] [PATCH] lib: Add include guard to tst_safe_clocks.h
In-Reply-To: <20190320193718.2320-1-rafael.tinoco@linaro.org>
References: <20190320193718.2320-1-rafael.tinoco@linaro.org>
Message-ID: <20190321110723.GB1252@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When adding a common header to my tests I missed this include guard when
> accidentally including tst_safe_clocks.h from .c and .h files. Since
> other tst_safe_*.h files have guards I thought it would be good to add
> to this one as well.

This is obviously OK, but needs to be applied over the CLOCK_ADJTIME
patch (it would have been slightly better if it was part of that
patchset), I will apply it once the adjtime tests are merged...

-- 
Cyril Hrubis
chrubis@suse.cz
