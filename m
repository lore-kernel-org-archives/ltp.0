From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 16:41:50 +0100
Subject: [LTP] [PATCH 1/3] Added memfd_create lapi flags
In-Reply-To: <1488283196-11397-2-git-send-email-jracek@redhat.com>
References: <1488283196-11397-1-git-send-email-jracek@redhat.com>
 <1488283196-11397-2-git-send-email-jracek@redhat.com>
Message-ID: <20170228154150.GA13574@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Jakub Racek <jracek@redhat.com>
> ---
>  include/lapi/memfd_create.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 include/lapi/memfd_create.h
                                   ^
				   This should probably be named only
				   memfd.h

> diff --git a/include/lapi/memfd_create.h b/include/lapi/memfd_create.h
> new file mode 100644
> index 0000000..47c4cb8
> --- /dev/null
> +++ b/include/lapi/memfd_create.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright (C) 2017  Red Hat, Inc.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.

We preffere GPLv2+ (with any later clausule) for any new code.

> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + */
> +
> +#ifndef __LAPI_MEMFD_H__
> +#define __LAPI_MEMFD_H__

Identifiers starting with underscore are reserved for system libraries
(mostly libc). We should not introduce new ones. And the old ones should
be fixed.

> +/* flags for memfd_create(2) (unsigned int) */
> +#ifndef MFD_CLOEXEC
> +# define MFD_CLOEXEC             0x0001U
> +#endif
> +#ifndef MFD_ALLOW_SEALING
> +# define MFD_ALLOW_SEALING       0x0002U
> +#endif
> +
> +#endif
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
