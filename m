From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Jun 2017 16:53:45 +0200
Subject: [LTP] [RFC] [PATCH 2/2] tst_timer.h: Make time conversions
 saturated
In-Reply-To: <712530002.34907423.1497451649732.JavaMail.zimbra@redhat.com>
References: <20170613160034.10042-1-chrubis@suse.cz>
 <20170613160034.10042-2-chrubis@suse.cz>
 <712530002.34907423.1497451649732.JavaMail.zimbra@redhat.com>
Message-ID: <20170614145344.GE7604@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The conversions of struct timeval and struct timespec to us and ms are
> > now saturated so instead of overflowing/underflowing long long these
> > return LLONG_MAX/LLONG_MIN.
> > 
> > This commit also adds tst_us_to_timespec(), tst_ms_to_timespec() and
> > newlib_tests/tst_timer test to assert that the saturated conversion
> > actually works.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> 
> There's one issue I'm running into, default language std is older
> than c99. So with plain configure && make, I fail on:
>  ../include/tst_timer.h:86: error: ???LLONG_MAX??? undeclared (first use in this function)
>  ../include/tst_timer.h:89: error: ???LLONG_MIN??? undeclared (first use in this function)

Supposedly we should set _GNU_SOURCE in all testcases that include that
header after the change. Or set up fallback LLONG_MAX and LLONG_MIN
definitions.

> What is reasoning behind these ifdefs?
>  #if LONG_MAX > 0xffffffff

To shut up warnings. If we compile on 32bit platform these conditions
are always false and we got warnings, a lot of them for each source that
includes the header. And since time_t size is as far as I can tell the
same as long we check if LONG_MAX is 64bit or not that way. Checking for
time_t size with autoconf would be a bit cleaner solution though.

-- 
Cyril Hrubis
chrubis@suse.cz
