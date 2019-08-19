From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Aug 2019 15:49:04 +0200
Subject: [LTP] [PATCH v5] syscalls/ioprio: Add test cases for I/O
 priority
In-Reply-To: <20190819074601.12094-1-linus.walleij@linaro.org>
References: <20190819074601.12094-1-linus.walleij@linaro.org>
Message-ID: <20190819134904.GB11715@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set02.c b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
> new file mode 100644
> index 000000000000..6a655394845c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
> + *
> + * Description:
> + * Extended ioprio_set() test.
> + * Tests to set all 8 priority levels for best effort priority, then
> + * switches to test all 8 priority levels for idle priority. Also test
> + * some non-working priorities to make sure they don't work.
> + */

I've removed the "Also test some non-working..." sentence here since we
moved these tests into ioprio_set03.c.

-- 
Cyril Hrubis
chrubis@suse.cz
