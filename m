From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Jul 2020 13:46:00 +0200
Subject: [LTP] [PATCH v3] IMA: Add test for kexec cmdline measurement
In-Reply-To: <20200722184739.19460-1-t-josne@linux.microsoft.com>
References: <20200722184739.19460-1-t-josne@linux.microsoft.com>
Message-ID: <20200723114600.GB31591@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> @@ -0,0 +1,121 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
> +#
> +# Verify that kexec cmdline is measured correctly.
> +
> +TST_NEEDS_CMDS="kexec sed xargs printf grep tr"
> +TST_CNT=1
> +TST_NEEDS_DEVICE=1
> +
> +. ima_setup.sh
> +
> +# Since the test is executed inside some sort of
> +# separate shell, *most* environment variables are
> +# not accessible, so there's no way to set it from
> +# the outside.
Do you mean that using this will not work?
IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
I don't understand that as I'm able to set variables even I run some tests in
dracut.

Also writing same docs doc on 2 places is not good. High level info should go to
README.md, implementation details to shell script.

Please hold on with posting new version. I have several fixes, thus I'd like to
send it after we sort this (trying to save you time).

Kind regards,
Petr
