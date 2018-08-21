From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Aug 2018 14:08:09 +0200
Subject: [LTP] [PATCH 2/5] lib: Add LTP_ATTRIBUTE_FALLTHROUGH for case
 statements
In-Reply-To: <20180820064257.17974-3-rpalethorpe@suse.com>
References: <20180820064257.17974-1-rpalethorpe@suse.com>
 <20180820064257.17974-3-rpalethorpe@suse.com>
Message-ID: <20180821120809.GC20217@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Richard,

> Can be used in place of break if you deliberately want to fallthrough to the
> next case statement.
...

> +++ b/include/tst_common.h
> @@ -24,6 +24,7 @@
>  #define LTP_ATTRIBUTE_NORETURN		__attribute__((noreturn))
>  #define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
>  #define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
> +#define LTP_ATTRIBUTE_FALLTHROUGH	__attribute__((fallthrough))
This does not work on old GCC versions, it was added in GCC 7

* GCC < 7
fcntl33.c: In function ‘do_test’:
fcntl33.c:160:3: warning: empty declaration
   LTP_ATTRIBUTE_FALLTHROUGH;

IMHO the most portable way is to use comment /* Fall through */, but maybe we
don't care much about.


Kind regards,
Petr
