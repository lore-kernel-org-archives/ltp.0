From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Jan 2019 13:56:27 +0800
Subject: [LTP] [PATCH 2/2] aio_tio: determine alignment based on target
	filesystem
In-Reply-To: <20190110132811.175790-2-maennich@google.com>
References: <20190110132811.175790-1-maennich@google.com>
 <20190110132811.175790-2-maennich@google.com>
Message-ID: <CAEemH2c7yAOAK=jDvfjOz5+LkYOQr3Ab9cNmJEMBoa-aGNWdkg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jan 10, 2019 at 10:03 PM Matthias Maennich <maennich@google.com> wrote:
>
> The alignment for O_DIRECT operations has to match the blocksize of the
> underlying filesystem. Determine the alignment from the target file's
> file system.
>
> aio_tio test cases 1 and 2 failed (nondeterministic) on aarch64 when run
> on a 4096 byte blocksize filesystem and with an alignment of 512 bytes.
>
> Determining the blocksize from the file system and using it for the
> alignment resolves the test issue.
>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> Reviewed-by: Alessio Balsini <balsini@google.com>
> ---
>  testcases/kernel/io/aio/aio02/aio_tio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/io/aio/aio02/aio_tio.c b/testcases/kernel/io/aio/aio02/aio_tio.c
> index 623c81a5e..b2d9a7bec 100644
> --- a/testcases/kernel/io/aio/aio02/aio_tio.c
> +++ b/testcases/kernel/io/aio/aio02/aio_tio.c
> @@ -34,6 +34,7 @@
>  #include "config.h"
>  #include "common.h"
>  #include "test.h"
> +#include "tst_safe_macros.h"

Since aio_tio.c is still written in old API, so here we probably need
to include original safe_macros.h but not the tst_safe_macros.h which
is for new LTP API.

>
> +       /* determine the alignment from the blksize of the underlying fs */
> +       SAFE_FSTAT(fd, &fi_stat);

Then, here needs old using way too: SAFE_FSTAT(NULL, fd, &fi_stat);

Beside these tiny issues, patch set LGTM.


--
Regards,
Li Wang
