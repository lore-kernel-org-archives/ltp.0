From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Sep 2019 11:16:37 +0200
Subject: [LTP] [PATCH ltp 3/5] runtest/ltp-aiodio.part4: rename
 aiodio_append tests to avoid duplication
In-Reply-To: <20190809062000.8671-3-yixin.zhang@intel.com>
References: <20190809062000.8671-1-yixin.zhang@intel.com>
 <20190809062000.8671-3-yixin.zhang@intel.com>
Message-ID: <20190902091637.GB21733@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> The name AD00{1..9} is already used in ltp-aiodio.part1, change them to
> ADA00{1..9}.
Not really have a strong opinion about trying to keep runtest names unique
across different runtests, but adding A is not really descriptive :).

I leave the final decision to Cyril.

Kind regards,
Petr

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  runtest/ltp-aiodio.part4 | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

> diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
> index bb8abfdf1..1c845cd7d 100644
> --- a/runtest/ltp-aiodio.part4
> +++ b/runtest/ltp-aiodio.part4
> @@ -34,16 +34,16 @@ DIO07 dio_sparse
>  DIO08 dio_sparse
>  DIO09 dio_sparse
>  #Running aiodio_append
> -AD000 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD001 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD002 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD003 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD004 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD005 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD006 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD007 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD008 aiodio_append $TMPDIR/aiodio.$$/file2
> -AD009 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA000 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA001 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA002 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA003 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA004 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA005 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA006 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA007 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA008 aiodio_append $TMPDIR/aiodio.$$/file2
> +ADA009 aiodio_append $TMPDIR/aiodio.$$/file2
>  #Running dio_append
>  ADI000 dio_append
>  ADI001 dio_append
