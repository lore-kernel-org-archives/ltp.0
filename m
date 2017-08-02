From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Aug 2017 10:17:22 +0200
Subject: [LTP] [RFC] [PATCH 2/2] tst_timer.h: Make time conversions
 saturated
In-Reply-To: <20170801154231.32367-1-chrubis@suse.cz>
References: <20170801154231.32367-1-chrubis@suse.cz>
Message-ID: <20170802081722.GA27984@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The conversions of struct timeval and struct timespec to us and ms are
> now saturated so instead of overflowing/underflowing long long these
> return LLONG_MAX/LLONG_MIN.
> 
> This commit also adds tst_us_to_timespec(), tst_ms_to_timespec() and
> newlib_tests/tst_timer test to assert that the saturated conversion
> actually works.

Argh, I've send a wrong patch, sorry.

But I wanted to ping this one anyway.

-- 
Cyril Hrubis
chrubis@suse.cz
