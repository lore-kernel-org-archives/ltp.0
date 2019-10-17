From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Oct 2019 14:08:30 +0200
Subject: [LTP] [PATCH] doc: Add very simple library API writing
 guidelines docs
In-Reply-To: <20190924183325.6143-1-pvorel@suse.cz>
References: <20190924183325.6143-1-pvorel@suse.cz>
Message-ID: <20191017120829.GA31415@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Feel free to write more useful docs than my stub.

It's a good stub actually, there is a lot that is not described at all.

We should probably draft a longer readme that describes why we also
have a mechanism for additional libraries in place and when to use it.
Generally we lack a lot of documentation.

Now we only need someone to volunteer to write it down.

> [1] https://patchwork.ozlabs.org/patch/1151766/
> 
>  doc/library-api-writing-guidelines.txt | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 doc/library-api-writing-guidelines.txt
> 
> diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
> new file mode 100644
> index 000000000..a238ee046
> --- /dev/null
> +++ b/doc/library-api-writing-guidelines.txt
> @@ -0,0 +1,25 @@
> +LTP Library API Writing Guidelines
> +==================================
> +
> +1. General Rules
> +----------------
> +
> +For extending library API it applies the same general rules as for writing tests
> +(see test-writing-guidelines.txt), with strong focus on readability and simplicity.
> +
> +Library tests are in lib/newlib_tests directory.
> +
> +2. C API
> +--------
> +
> +API source code is in headers include/*.h, include/lapi/*.h (backward compatibility)
> +and C sources in lib/*.c. Files have tst_ prefix.
> +
> +3. Shell API
> +------------
> +
> +API source code is in tst_test.sh, tst_security.sh and tst_net.sh
> +(all in testcases/lib directory).
> +
> +Changes in the shell API should not introduce uncommon dependencies
> +(use basic commands installed everywhere by default).
> -- 
> 2.22.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
