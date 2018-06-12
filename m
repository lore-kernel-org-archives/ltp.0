From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jun 2018 13:02:09 +0200
Subject: [LTP] [PATCH] [RFC] README.md: Add shortcut to running a single
 test
In-Reply-To: <20180611123607.19390-1-chrubis@suse.cz>
References: <20180611123607.19390-1-chrubis@suse.cz>
Message-ID: <20180612110209.xmsglkkwzvrxqur2@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Add a shortcut to compiling and running a single test, which is
> something that I've been asked for a few times.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice idea. LGTM, just 2 typos found.
> ---
>  README.md | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

> diff --git a/README.md b/README.md
> index ffa769d73..6c2d203b7 100644
> --- a/README.md
> +++ b/README.md
> @@ -42,6 +42,49 @@ $ git clone https://github.com/linux-test-project/ltp.git
>  $ cd ltp
>  $ make autotools
>  $ ./configure
> +```
> +
> +Now you can continue either with compiling and running a single test or with
> +compling and installing the whole testsuite.
typo ^
compiling and installing the whole testsuite.

...
> +$ cd testcases/open_posix_testsuite/
> +$ make generate-makefiles
> +$ cd conformance/interfaces/foo
> +$ make
> +$ ./foo_1-1.run-test
> +```
> +
> +Copiling and installing all testcases
typo ^
Compiling and installing all testcases


Kind regards,
Petr
