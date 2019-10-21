From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Oct 2019 17:28:31 +0800
Subject: [LTP] [PATCH v4 4/5] Add newlib shell test for
 tst_multiply_timeout()
In-Reply-To: <20191018124502.25599-5-cfamullaconrad@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-5-cfamullaconrad@suse.de>
Message-ID: <CAEemH2c_JVy0jPs96uMfZ0nJjnoGsyhDvLjHy9UJ0tXyc5KNzQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 18, 2019 at 8:45 PM Clemens Famulla-Conrad <
cfamullaconrad@suse.de> wrote:

> Simple test for different kinds of calls from tst_multiply_timeout()
>

Patch 4/5 and 5/5 needs "Signed-off-by: ..." tag, otherwise LGTM.
    Reviewed-by: Li Wang <liwang@redhat.com>

---
>  lib/newlib_tests/shell/test_timeout_mul.sh | 43
> ++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/test_timeout_mul.sh
>
> diff --git a/lib/newlib_tests/shell/test_timeout_mul.sh
> b/lib/newlib_tests/shell/test_timeout_mul.sh
> new file mode 100755
> index 000000000..6682e5d66
> --- /dev/null
> +++ b/lib/newlib_tests/shell/test_timeout_mul.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2019 Clemens Famulla-Conrad <cfamullaconrad@suse.de>
> +
> +TST_TESTFUNC=do_test
> +. tst_test.sh
> +
> +
> +call_it()
> +{
> +       local SAVE_MUL=${LTP_TIMEOUT_MUL}
> +       $1
> +       eval "exp_value=\$$2"
> +       if [ "$exp_value" -ne "$3" ]; then
> +               tst_brk TBROK "LTP_TIMEOUT_MUL=$SAVE_MUL $1 ($exp_value !=
> $3)"
> +       else
> +               tst_res TPASS "LTP_TIMEOUT_MUL=$SAVE_MUL $1 ($exp_value ==
> $3)"
> +       fi
> +}
> +
> +do_test()
> +{
> +       LTP_TIMEOUT_MUL=2
> +       local sec=1
> +
> +       call_it 'tst_multiply_timeout sec' 'sec' 2
> +
> +       sec=1
> +       LTP_TIMEOUT_MUL="1.5"
> +       call_it 'tst_multiply_timeout sec' 'sec' 2
> +
> +       sec=1
> +       LTP_TIMEOUT_MUL=0.5
> +       call_it 'tst_multiply_timeout sec' 'sec' 1
> +
> +       sec=1
> +       LTP_TIMEOUT_MUL=2
> +       call_it 'tst_multiply_timeout sec' 'sec' 2
> +       call_it 'tst_multiply_timeout sec' 'sec' 4
> +       call_it 'tst_multiply_timeout sec' 'sec' 8
> +}
> +
> +tst_run
> --
> 2.16.4
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191021/7de3ad38/attachment.htm>
