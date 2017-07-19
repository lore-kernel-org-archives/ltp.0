From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 12:44:01 +0200
Subject: [LTP] [PATCH v3 4/9] Test for uname26 exploit CVE-2012-0957
In-Reply-To: <20170623122211.29575-5-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-5-rpalethorpe@suse.com>
Message-ID: <20170719104401.GD1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Attempt to exploit the uname kernel memory leak which occurred when the
> UNAME26 personality was set.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  configure.ac                  |  1 +
>  m4/ltp-uname.m4               | 20 ++++++++++
>  testcases/cve/cve-2012-0957.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 m4/ltp-uname.m4
>  create mode 100644 testcases/cve/cve-2012-0957.c
> 
> diff --git a/configure.ac b/configure.ac
> index 326da8ece..658003972 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -193,5 +193,6 @@ LTP_CHECK_KEYUTILS_SUPPORT
>  LTP_CHECK_SYNC_ADD_AND_FETCH
>  LTP_CHECK_BUILTIN_CLEAR_CACHE
>  LTP_CHECK_MMSGHDR
> +LTP_CHECK_UNAME_DOMAINNAME
>  
>  AC_OUTPUT
> diff --git a/m4/ltp-uname.m4 b/m4/ltp-uname.m4
> new file mode 100644
> index 000000000..5a3002200
> --- /dev/null
> +++ b/m4/ltp-uname.m4
> @@ -0,0 +1,20 @@
> +dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
> +
> +AC_DEFUN([LTP_CHECK_UNAME_DOMAINNAME],[
> +AC_CHECK_MEMBERS([struct utsname.domainname],,,[
> +#define _GNU_SOURCE
> +#include <sys/utsname.h>
Hi!
Applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
