From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 14 Jun 2017 10:47:29 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH 2/2] tst_timer.h: Make time conversions
 saturated
In-Reply-To: <20170613160034.10042-2-chrubis@suse.cz>
References: <20170613160034.10042-1-chrubis@suse.cz>
 <20170613160034.10042-2-chrubis@suse.cz>
Message-ID: <712530002.34907423.1497451649732.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


----- Original Message -----
> The conversions of struct timeval and struct timespec to us and ms are
> now saturated so instead of overflowing/underflowing long long these
> return LLONG_MAX/LLONG_MIN.
> 
> This commit also adds tst_us_to_timespec(), tst_ms_to_timespec() and
> newlib_tests/tst_timer test to assert that the saturated conversion
> actually works.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---

There's one issue I'm running into, default language std is older
than c99. So with plain configure && make, I fail on:
 ../include/tst_timer.h:86: error: ‘LLONG_MAX’ undeclared (first use in this function)
 ../include/tst_timer.h:89: error: ‘LLONG_MIN’ undeclared (first use in this function)

With CFLAGS="-std=gnu99" I run into one minor issue:
  clock_nanosleep01.c:64:17: error: initializer element is not constant
but after resolving that, all compiles.

---

What is reasoning behind these ifdefs?
 #if LONG_MAX > 0xffffffff

Regards,
Jan



