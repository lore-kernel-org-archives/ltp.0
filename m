From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Mar 2017 08:46:46 +0200
Subject: [LTP] [RFC PATCH 01/13] mem/lib: convert to new API
In-Reply-To: <CAEemH2cE4ceo0++ayfzgaXS0LOPd17nfibrGWdo1GfTRnJUXmQ@mail.gmail.com>
References: <20170328032239.11917-1-liwang@redhat.com>
 <20170328032239.11917-2-liwang@redhat.com>
 <20170330155503.GD886@rei.lan>
 <CAEemH2cE4ceo0++ayfzgaXS0LOPd17nfibrGWdo1GfTRnJUXmQ@mail.gmail.com>
Message-ID: <20170331064645.GA7552@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I saw this MACRO, but it doesn't work with too much pointers which
> transfered by multi level function.
> 
> This test program is not work:
> =======================
> 
> #include <stdio.h>
> #include "tst_test.h"
> 
> long read_meminfo(char *item)
> {
>         long val;
> 
>         SAFE_FILE_LINES_SCANF("/proc/meminfo", "%s %ld", item, &val);

This is because the item has to be part of the matching string and not a
item to be matched the "%s %ld" string would match first line in the
/proc/meminfo. The easiest solution would be turning this into a macro:

#define SAFE_READ_MEMINFO(item) \
	({long tst_rval; \
	  SAFE_FILE_LINES_SCANF("/proc/meminfo", item " %ld",
	  &tst_rval); \

This of course works only when item is compile time string constant, but
I doubt that we use it with anything else.

-- 
Cyril Hrubis
chrubis@suse.cz
