From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 May 2017 21:33:37 +0200
Subject: [LTP] [PATCH v2 05/10] Add CVE .gitignore,
 Makefile and runtest files
In-Reply-To: <20170522121341.4663-6-rpalethorpe@suse.com>
References: <20170522121341.4663-1-rpalethorpe@suse.com>
 <20170522121341.4663-6-rpalethorpe@suse.com>
Message-ID: <20170526193301.GA18654@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +++ b/testcases/cve/Makefile
> @@ -0,0 +1,25 @@
> +# Copyright (c) 2017 Linux Test Project
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
> +
> +top_srcdir		?= ../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CFLAGS			+= -D_GNU_SOURCE

Ah, you define _GNU_SOURCE here for all the tests. That should be fine,
but we should still check if the domainname field is present if
_GNU_SOURCE is defined, otherwise it may fail with alternative glibc (we
have at least three these days).

> +cve-2014-0196:	LDFLAGS += -lpthread -lutil -lrt

Here you are adding LDFLAGS for test that does not exist yet, but at
least that should not break anything.

BTW what is the -lutil needed for?

> +cve-2016-7117:	LDFLAGS += -lpthread -lrt
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> -- 
> 2.12.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
