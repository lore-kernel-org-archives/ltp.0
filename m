From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Apr 2021 11:36:22 +0200
Subject: [LTP] [PATCH v2] syscalls/unshare: Convert unshare02 to the new
 API
In-Reply-To: <20210420072939.202584-1-xieziyao@huawei.com>
References: <20210419122246.7706-3-xieziyao@huawei.com>
 <20210420072939.202584-1-xieziyao@huawei.com>
Message-ID: <YH6glgTigiFAw6LB@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Crackerjack Project., 2007
> + * Ported from Crackerjack to LTP by Manas Kumar Nayak maknayak@in.ibm.com>
> + */
> +
> +/*
> + * [Description]
> + *
> + * Basic tests for the unshare error() syscall.
> + */

Pushed with slight modification to the description, thanks.

Also please note that the special description comment has to start with
/*\ instead of just /* in order to be picked up by docparser.

-- 
Cyril Hrubis
chrubis@suse.cz
