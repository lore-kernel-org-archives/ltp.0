From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 06 Jul 2021 10:41:00 +0100
Subject: [LTP] [PATCH] fs_bind: Convert to ltp tests
In-Reply-To: <20210705135014.679200-2-lkml@jv-coder.de>
References: <20210705135014.679200-1-lkml@jv-coder.de>
 <20210705135014.679200-2-lkml@jv-coder.de>
Message-ID: <87zguz7par.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
> new file mode 100755
> index 000000000..9e0f5fe05
> --- /dev/null
> +++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) International Business Machines  Corp., 2005
> +# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
> +# Author: Avantika Mathur (mathurav@us.ibm.com)
> +
> +FS_BIND_TESTFUNC=test
> +
> +. fs_bind_lib.sh
> +
> +test()
> +{
> +    tst_res TINFO "cloneNS: namespaces with parent-slave"
> +
> +	fs_bind_makedir rshared dir1
> +	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
> +
> +	mkdir dir2
> +	EXPECT_PASS mount --bind dir1 dir2

There seems to be a section of tabs instead of spaces here. Also in
other places.

I wonder how you converted these?

Looks promising.

-- 
Thank you,
Richard.
