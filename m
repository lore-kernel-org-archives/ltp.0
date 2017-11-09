From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Nov 2017 16:18:37 +0100
Subject: [LTP] [RFC PATCH 3/4] lapi: Add lapi/in.h with definition moved
 from netstress.c
In-Reply-To: <20171109113947.24609-4-pvorel@suse.cz>
References: <20171109113947.24609-1-pvorel@suse.cz>
 <20171109113947.24609-4-pvorel@suse.cz>
Message-ID: <20171109151837.GC30136@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> --- /dev/null
> +++ b/include/lapi/in.h
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef IN_H__
> +#define IN_H__
> +
> +#ifndef IPPROTO_DCCP
> +#define IPPROTO_DCCP		33
> +#endif
> +
> +#endif	/* IN_H__ */

Maybe we should rename this file to netinet_in.h or create netinet
directory in lapi. Including just lapi/in.h is a bit confusing.

-- 
Cyril Hrubis
chrubis@suse.cz
