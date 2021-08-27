From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Aug 2021 14:15:27 +0200
Subject: [LTP] [PATCH 2/2] Add CHECK_NOFLAGS and checkpatch.pl to 'make
 check'
In-Reply-To: <20210827095210.23602-2-rpalethorpe@suse.com>
References: <20210827095210.23602-1-rpalethorpe@suse.com>
 <20210827095210.23602-2-rpalethorpe@suse.com>
Message-ID: <YSjXX6NWbDzu5X9m@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Add another check command type. CHECK_NOFLAGS just takes the source
> file name as an argument. By default it is set to
> scripts/checkpatch.pl which is probably the only thing we want to use
> it for. OTOH you can set it to clang-tidy instead.
The same we could do with checkbashisms for tests using new shell API.

> It is run with '-' because of the large number of errors it presently
> produces. Also of course, check errors are not actually fatal. If we
> wish to stop on errors in the future (e.g. for CI) then a "strict"
> option can be introduced.

Thanks for doing this!

Could it be possible to run it only for tests which use new API? Otherwise it
takes long time before we can use it in CI due lots of output from tests using
legacy API:

tst_record_childstatus.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
=> tst_record_childstatus.c uses test.h.

Kind regards,
Petr
