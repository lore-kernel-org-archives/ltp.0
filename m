From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Dec 2020 10:44:18 +0800
Subject: [LTP] [PATCH 1/1] doc: Document .min_cpus
In-Reply-To: <20201207145639.8424-1-pvorel@suse.cz>
References: <20201207145639.8424-1-pvorel@suse.cz>
Message-ID: <CAEemH2eWAvsyveMm6kaJ=UwMcuPSWZif8yDXr4zBpc-V5MpOGg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I didn't write down this since I thought it's easy to understand the
.min_cpus.
(sounds like an excuse to mask my lazy :)
But it's nice to have, thanks for writing this!

Just a minor comment below.

On Mon, Dec 7, 2020 at 10:56 PM Petr Vorel <pvorel@suse.cz> wrote:

> Recently added (in fa32a727d).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>
Acked-by: Li Wang <liwang@redhat.com>


> ---
> Feel free to document it more.
>
> Kind regards,
> Petr
>
>  doc/test-writing-guidelines.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index 3c2ab7166..dcb5d9d43 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -2134,8 +2134,14 @@ struct tst_test test = {
>         .test_all = run,
>         ...
>  };
> -
>
>  -------------------------------------------------------------------------------
> +
> +2.2.37 Require minimum numbers of CPU for a testcase
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Some tests require more than single CPU. It can be defined with
>

single --> specific number of



> +`.min_cpus = N`.
> +
>  2.3 Writing a testcase in shell
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.29.2
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201208/afc8b782/attachment-0001.htm>
