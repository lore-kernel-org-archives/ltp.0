From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 22 Jul 2020 10:04:42 -0400
Subject: [LTP] [PATCH] IMA: Add test for kexec cmdline measurement
In-Reply-To: <20200721182440.4169-1-t-josne@linux.microsoft.com>
References: <20200721182440.4169-1-t-josne@linux.microsoft.com>
Message-ID: <1595426682.5311.83.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2020-07-21 at 14:24 -0400, Lachlan Sneff wrote:

<snip>

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> new file mode 100644
> index 000000000..7d71557ee
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> @@ -0,0 +1,93 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
> +#
> +# Verify that kexec cmdline is measured correctly.
> +
> +TST_NEEDS_CMDS="kexec sed xargs printf grep"
> +TST_CNT=1
> +TST_NEEDS_DEVICE=1
> +
> +. ima_setup.sh
> +
> +# Since the test is executed inside some sort of
> +# separate shell, *most* environment variables are
> +# not accessible, so there's no way to set it from
> +# the outside.
> +#
> +# `/boot/vmlinuz-$(uname-r)` is where the image is
> +# located on many systems, but not all. Therefore,
> +# if the image is not located there, require the
> +# user to copy it to `/tmp/Image`.
> +#
> +# Ideally, this test shouldn't even require an image,
> +# since it doesn't actually reboot, but the IMA cmdline
> +# measurement occurs after the image is parsed and verified,
> +# so we must pass a valid kernel image. There is a possiblity of
> +# putting together a "faux" kernel image that has the right headers
> +# and appears to be signed correctly, but doesn't actually contain any
> +# code, but, after investigating that possiblity, it appears to be
> +# quite difficult (and would require a new faux kernel for each arch).

The comment formatting is inconsistent. ?Please correct.

> +IMAGE="/boot/vmlinuz-$(uname -r)"
> +if [ ! -f $IMAGE ]; then
> +    IMAGE="/tmp/Image"
> +fi
> +
> +measure() {
> +    local found temp_file="file.txt" temp_file2="file2.txt" algorithm \
> +        digest expected_digest
> +
> +    echo -n "$1" > $temp_file
> +    grep "kexec-cmdline" $ASCII_MEASUREMENTS > $temp_file2
> +
> +    while read found
> +    do
> +        algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
> +        digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
> +
> +        expected_digest=$(compute_digest $algorithm $temp_file)
> +
> +        if [ "$digest" = "$expected_digest" ]; then
> +            return 0
> +        fi
> +    done < $temp_file2
> +
> +    return 1
> +}
> +
> +# Test that the kexec cmdline is measured correctly.
> +# NOTE: This does *not* actually reboot.
> +test1() {
> +    # Strip the `BOOT_IMAGE=...` part from the cmdline.
> +    local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
> +    if ! kexec -sl $IMAGE --reuse-cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi

Most likely one of the reasons for the kexec to fail is that the
kernel image isn't properly signed. ?How about checking the secure-
boot status to provide some contextual information.

> +
> +    if ! measure "$cmdline"; then
> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
> +    fi

This assumes that a kexec command line measurement was found. ?The
output needs to differentiate between no measurement and an invalid
measurement. ?In the case that the rule doesn't exist, at that point
you have a choice of skipping the test or extending the IMA policy.?

The kernel kexec selftests checks both the Kconfig and the IMA runtime
policy. ?Different testing infrastructures have different policies
about basing tests on them.

> +
> +    cmdline="foo"

Wondering if unknown command line options could cause the kexec to
fail.

> +    if ! kexec -sl $IMAGE --append=$cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi

Should the first kernel image be unloaded first?

Mimi

> +
> +    if ! measure "$cmdline"; then
> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
> +    fi
> +
> +    cmdline="bar"
> +    if ! kexec -sl $IMAGE --command-line=$cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi
> +
> +    if ! measure "$cmdline"; then
> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
> +    fi
> +
> +    tst_res TPASS "kexec cmldine was measured correctly"
> +}
> +
> +tst_run

