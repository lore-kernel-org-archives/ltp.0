From: Li Wang <liwang@redhat.com>
Date: Fri, 31 Mar 2017 14:36:51 +0800
Subject: [LTP] [RFC PATCH 01/13] mem/lib: convert to new API
In-Reply-To: <20170330155503.GD886@rei.lan>
References: <20170328032239.11917-1-liwang@redhat.com>
 <20170328032239.11917-2-liwang@redhat.com>
 <20170330155503.GD886@rei.lan>
Message-ID: <CAEemH2cE4ceo0++ayfzgaXS0LOPd17nfibrGWdo1GfTRnJUXmQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 30, 2017 at 11:55 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>>
>> -     tst_brkm(TBROK, cleanup, "cannot find \"%s\" in %s",
>> +     tst_brk(TBROK, "cannot find \"%s\" in %s",
>>                item, PATH_MEMINFO);
>>  }
>
>
> The read_meminfo() function body could be replaced with one call to
> SAFE_FILE_LINES_SCANF().
>

I saw this MACRO, but it doesn't work with too much pointers which
transfered by multi level function.

This test program is not work:
=======================

#include <stdio.h>
#include "tst_test.h"

long read_meminfo(char *item)
{
        long val;

        SAFE_FILE_LINES_SCANF("/proc/meminfo", "%s %ld", item, &val);

        return val;
}


static void do_test(void)
{
        long dummy;

        dummy = read_meminfo("MemFree:");

        tst_res(TPASS, "dummy = %ld", dummy);
}

static struct tst_test test = {
        .tid = "tst_safe_fileops",
        .test_all = do_test,
};

=================================

And, no objection to the rest of comments.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
