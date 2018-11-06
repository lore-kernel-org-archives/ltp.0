From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Nov 2018 09:00:22 +0200
Subject: [LTP] [PATCH 5/5] syscalls/posix_fadvise0[13]: Start using new
	library.
In-Reply-To: <20181105235019.254846-6-sspatil@google.com>
References: <20181105235019.254846-1-sspatil@google.com>
 <20181105235019.254846-6-sspatil@google.com>
Message-ID: <CAOQ4uxho-DGW+efhpJZBxFnewANdbTk0uv4pGB3ct96ma3cSNg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 6, 2018 at 1:51 AM Sandeep Patil <sspatil@google.com> wrote:
>
> Use SPDX-Licence-Identifier and delete dead comments / code while at it.
> Make sure the tests can work on any system by creating its own file
> and using it for testing.
>
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---

Hi Sandeep,

Nice work.
Please compare with https://github.com/linux-test-project/ltp/pull/401
to see if you missed anything which I got.
I found some minor issue by diff (see below).

>  .../kernel/syscalls/fadvise/posix_fadvise01.c | 135 ++++-----------
>  .../kernel/syscalls/fadvise/posix_fadvise03.c | 163 ++++--------------
>  2 files changed, 68 insertions(+), 230 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> index c12f0563c..ad139a66b 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> @@ -1,20 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0

// SPDX-License-Identifier: GPL-2.0-or-later

Here and in other test as well.

...

> -void cleanup(void)
> -{
> -
> -       if (fd != -1) {
> -               close(fd);
> +       /* Check this system has fadvise64 system which is used
> +          in posix_fadvise. */
> +       if ((_FILE_OFFSET_BITS != 64) && (__NR_fadvise64 == 0)) {
> +               tst_brk(TCONF,
> +                       "This test can only run on kernels that implements "
> +                       "fadvise64 which is used from posix_fadvise");

That is a good change compared to original test, but when
Jan Stancek asked me about this check in my readahead test:
https://marc.info/?l=linux-unionfs&m=153857388324517&w=2
I looked into it and couldn''t find a reason for the test at all.

posix_fadvise() is a documented API and the tests posix_fadvise0[14]
utilize this API. What does it matter which syscall variant is used to
implement the API?

The only thing that should matter in the context of this test is
whether or not posix_fadvise() is supported by the kernel.
For some reason that is not clear to me (are we tinyfying the kernel syscall
by syscall now?), the support for fadvise in the kernel can be configured out
with CONFIG_ADVISE_SYSCALLS=n. So IMO, this test really needs a
runtime check, not a build time check like above.

We can try POSIX_FADV_NORMAL in setup() and report TCONF if it fails.

>         }
>
> +       fd = SAFE_OPEN(, fname, O_RDONLY);

typo SAFE_OPEN(,

Thanks,
Amir.
