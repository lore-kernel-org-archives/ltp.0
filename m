From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jan 2021 18:34:17 +0800
Subject: [LTP] [PATCH 1/1] autoconf: Use pkg-config for keyutils
 detection
In-Reply-To: <20210111123626.28932-1-pvorel@suse.cz>
References: <20210111123626.28932-1-pvorel@suse.cz>
Message-ID: <CAEemH2eTEEZVZc71=HF+251t_d7Rnu7XdFY2t54u=ORwY3M-7A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jan 11, 2021 at 8:36 PM Petr Vorel <pvorel@suse.cz> wrote:

> Using pkg-config is less error prone during cross compilation.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> if you agree with this, I'll replace (probably after release) ACL_LIBS,
> CAP_LIBS, CRYPTO_LIBS, SELINUX_LIBS (to follow libmnl and libtirpc).
>
+1


>
> libaio and libnuma does not support pkg-config.
>
> Tested: https://travis-ci.org/github/pevik/ltp/builds/753925166
>
> [...]


> diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
> deleted file mode 100644
> index 451c549f3..000000000
> --- a/m4/ltp-keyutils.m4
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2016 Fujitsu Ltd.
> -dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> -dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -
> -AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
> -       AC_CHECK_LIB([keyutils], [add_key],
> -       [AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have
> libkeyutils installed.])
> -             AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
> -])
> diff --git a/m4/ltp-libkeyutils.m4 b/m4/ltp-libkeyutils.m4
> new file mode 100644
> index 000000000..f5d128969
> --- /dev/null
> +++ b/m4/ltp-libkeyutils.m4
> @@ -0,0 +1,8 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +AC_DEFUN([LTP_CHECK_LIBKEYUTILS], [
> +    PKG_CHECK_MODULES([LIBKEYUTILS], [libkeyutils], [
>

I guess the list-of-modules should be [keyutils-libs] but not [libkeyutils]?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210112/acb79e9a/attachment.htm>
