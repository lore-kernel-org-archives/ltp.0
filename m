From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Dec 2018 16:47:00 +0800
Subject: [LTP] [PATCH] [RFC] Proof-of-concept for test documentation
	format
In-Reply-To: <20181128104420.30110-1-chrubis@suse.cz>
References: <20181128104420.30110-1-chrubis@suse.cz>
Message-ID: <CAEemH2c96pwc4pDva55jhkMAKRfQ_POB+iWdZzgf_UJr3N95Tw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 28, 2018 at 6:46 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> This is just hacked up proof of concept in order to continue our
> discussion on test documentation. The code itself is just meant to prove
> that something is possible and it's not mean for inclusion.
>
> With that in mind, let me describe what I attempted to prove to be
> possible here:
>
> The test metadata are written in special comment in the test source, see
> test_docs.c and top level comment starting with /*RST tag.
>
> There is a hacked up tool that parses the comment prior to the test
> compilation and picks up relevant parts and formats them into C data
> structures, the results can be seen in test_docs.gen.c once you run make
> in the newlib_tests directory. This data structures are then linked with
> the actual test e.g. test_docs and used by the test library.
>
> The upside of this approach is that all the metadata can now reside in
> the special comment used to describe the test and at the same time the
> test can access this information at runtime, there is no need to repeat
> any piece of information in this setup. Even the needs_root fileds can
> be moved to the comment after this and indeed that works nicely here. At
> the same time the test can print the test description when passed -h
> flag, etc.
>
> The only downside is that this is automagical process that adds
> complexity to the compliation process.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: automated-testing@yoctoproject.org
> ---
>  include/tst_metadata.h       |  28 +++++
>  include/tst_test.h           |   1 +
>  lib/newlib_tests/.gitignore  |   3 +
>  lib/newlib_tests/Makefile    |   7 ++
>  lib/newlib_tests/docparse.c  | 220 +++++++++++++++++++++++++++++++++++
>  lib/newlib_tests/test_docs.c |  40 +++++++
>  lib/tst_test.c               |  21 +++-
>  7 files changed, 318 insertions(+), 2 deletions(-)
>  create mode 100644 include/tst_metadata.h
>  create mode 100644 lib/newlib_tests/docparse.c
>  create mode 100644 lib/newlib_tests/test_docs.c
>
> diff --git a/include/tst_metadata.h b/include/tst_metadata.h
> new file mode 100644
> index 000000000..8a7363320
> --- /dev/null
> +++ b/include/tst_metadata.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2018 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#ifndef TST_METADATA_H__
> +#define TST_METADATA_H__
> +
> +struct tst_tag {
> +       const char *name;
> +       const char *value;
> +};
> +
> +struct tst_metadata {
> +       /* help string printed with -h */
> +       const char *help;
> +
> +       /* general test tags */
> +       const struct tst_tag *tags;

Maybe we can add a new field .fix_kver to make this hints more valuable/precise?

/* bug fix on kernel version */
const char *fix_kver;

I'm thinking that if the regression test fails on a kernel less than
.fix_kver that probably meas hit the same bug; and if the regression
test fails on a kernel newer than .fix_kver that probably a new
bug/issue in kernel/testcase, then we'd better skip to print the hints
in case to misleading LTP user.

-- 
Regards,
Li Wang
