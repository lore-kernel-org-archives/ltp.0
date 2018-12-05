From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Dec 2018 17:47:22 +0100
Subject: [LTP] [PATCH 1/2] getrlimit/getrlimit03: add configure-time
 check for struct ulimit64
In-Reply-To: <4cf455cd-8734-f606-ef6e-11dcf7d42d19@google.com>
References: <20181203190148.93108-1-ghackmann@google.com>
 <20181203212505.GA2022@x230>
 <98a5058e-939b-3fb5-4f78-4e11f6901e0e@google.com>
 <20181204090130.GA24014@dell5510>
 <4cf455cd-8734-f606-ef6e-11dcf7d42d19@google.com>
Message-ID: <20181205164722.GA321@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Greg,

> bionic prefers to grab kernel-facing definitions directly from the UAPI
> headers, so sys/resource.h includes linux/resource.h.
Thanks for info.

> I could switch the test to explicitly use linux/resource.h, if you feel that
> makes more sense.  I originally used sys/resource.h to get all the other
> rlimit-related constants.  I actually didn't realize that the kernel already
> exported a struct rlimit64 definition that we could use in place of
> open-coding something.
You answer yourself - RLIM_NLIMITS and other rlimit-related constants are
needed.

+ using <linux/resource.h> conflicts with other <time.h> usage in LTP library headers.

In file included from /usr/include/time.h:48,
                 from ../../../../include/safe_file_ops_fn.h:22,
                 from ../../../../include/tst_safe_file_ops.h:27,
                 from ../../../../include/tst_test.h:87,
                 from getrlimit03.c:29:
/usr/include/bits/types/struct_itimerspec.h: At top level:
/usr/include/bits/types/struct_itimerspec.h:8:8: error: redefinition of ‘struct itimerspec’


Kind regards,
Petr
