From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Nov 2018 17:00:41 +0100
Subject: [LTP] [PATCH RFC v2] lib: new tst_test field to save and
 restore proc|sys
In-Reply-To: <3a4b56e5194eb853e882357826c335d416614c86.1539966340.git.jstancek@redhat.com>
References: <3a4b56e5194eb853e882357826c335d416614c86.1539966340.git.jstancek@redhat.com>
Message-ID: <20181101160041.GA14734@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
> new file mode 100644
> index 000000000000..ed558f3cc8fd
> --- /dev/null
> +++ b/include/tst_sys_conf.h
> @@ -0,0 +1,27 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2018 Jan Stancek <jstancek@redhat.com>
> + */
> +
> +#ifndef TST_SYS_CONF_H__
> +#define TST_SYS_CONF_H__
> +
> +struct tst_sys_conf {
> +	char path[PATH_MAX];
> +	char value[PATH_MAX];
> +	struct tst_sys_conf *prev;
> +	struct tst_sys_conf *next;
> +};
> +
> +#define SYS_CONF_HEAD_INIT(name) { .prev = &(name), .next = &(name) }
> +#define TST_SYS_CONF_INIT(name) \
> +	struct tst_sys_conf name = SYS_CONF_HEAD_INIT(name)

Well we can use ordinary (single link) linked list unless we want to
delete from it I guess. Or is there a reason to have double linked one?

Also I suppose that we do not need explicit declaration for the root
pointer, there would be only one list in existence. I would just put one
static pointer into the tst_sys_conf.c.

Other than these minor things it looks very good.

-- 
Cyril Hrubis
chrubis@suse.cz
