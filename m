From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Nov 2018 16:19:31 +0100
Subject: [LTP] [PATCH v4 4/4] fzsync: Add delay bias for difficult races
In-Reply-To: <20181105154217.18879-5-rpalethorpe@suse.com>
References: <20181105154217.18879-1-rpalethorpe@suse.com>
 <20181105154217.18879-5-rpalethorpe@suse.com>
Message-ID: <20181129151931.GB22216@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * A positive change delays thread B and a negative one delays thread
> + * A. Calling this will invalidate the statistics gathered so far and extend
> + * the minimum sampling period. Calling it once the sampling period has
> + * finished will have no effect.

I guess that this comment ended up out of sync with the code, since we
no longer seem to do reset the statistic nor increase the number of
iterations. Which also means that the patch could be more minimal, there
is no need to move the statistic initialization into a separate function
since it's does not seem to be called from more than one place, etc.

-- 
Cyril Hrubis
chrubis@suse.cz
