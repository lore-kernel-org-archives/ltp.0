From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Sep 2019 17:52:15 +0200
Subject: [LTP] [PATCH] fzsync: Add reproducing race-conditions section
 to docs
In-Reply-To: <20190923125914.2572-1-rpalethorpe@suse.com>
References: <20190923125914.2572-1-rpalethorpe@suse.com>
Message-ID: <20190923155215.GA2531@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Give people some hint about how to do this with the Fuzzy Sync library. This
> is really just a pointer. A full explanation would require way too much detail
> for this document.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Nice, thanks for caring about docs.
Acked-by: Petr Vorel <pvorel@suse.cz>

> ---
>  doc/test-writing-guidelines.txt | 79 +++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)

> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index a735b43bb..49cc92a27 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1854,6 +1854,85 @@ However a lot of problems can be solved by using 'tst_cap_action(struct
>  tst_cap  *cap)' directly which can be called at any time. This also helps if
>  you wish to drop a capability at the begining of setup.

> +2.2.33 Reproducing race-conditions
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +If a bug is caused by two tasks in the kernel racing and you wish to create a
> +regression test (or bug-fix validation test). The 'tst_fuzzy_sync.h' library
> +should be used.
Looks a bit strange to have this in 2 sentences (I'd write single one),
but you're a native speaker, so you must know what is correct :).

...
> +Fuzzy sync synchronises 'run_a' and 'run_b', which act as barriers, so that
> +niether thread can progress until the other has caught up with it. There is
typo: niether => neither

Kind regards,
Petr
