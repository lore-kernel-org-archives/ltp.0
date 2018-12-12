From: vaishnavi.d <vaishnavi.d@zilogic.com>
Date: Wed, 12 Dec 2018 12:33:04 -0000
Subject: [LTP] [PATCH v4] syscalls/statx: Add test for sync flags
References: <1544172141-1676-1-git-send-email-vaishnavi.d@zilogic.com>
 <20181207155220.GA14562@dell5510>
Message-ID: <3bc62fa106ebc6031105d2cfca26b7cd.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

>> + * Minimum kernel version required is 4.16.
> statx() was merged into 4.11 in commit a528d35e8bfc ("statx: Add a system
> call
> to make enhanced file info available" as you had in v1. Why now requiring
> 4.16?
> It looks like second test fails now on 4.11, because calling get_mode()
> for it
> as well (see bellow).

Actually, support for sync flags was added only from kernel version 4.16.
Since, I was using 4.16, I didn't face that issue. Thats why minimum kernel
version has been updated to 4.16 in the patch v5.
(https://github.com/torvalds/linux/commit/9ccee940bd5b766b6dab6c1a80908b9490a4850d)



>> +#include "old_tmpdir.h"
> I think, we don't want to use old_*.h headers (although library itself
> lib/tst_test.c uses it). IMHO previous version with getcwd() was better.
>

The function get tempdir will be ported to the new library soon. So, I
have not modified that part. Other changes have been made in patch v5.

Regards,
Vaishnavi D

