From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Nov 2019 11:03:21 +0100
Subject: [LTP] [PATCH] pan/ltp-pan.c: Add file parsing protection
In-Reply-To: <20191115052906.2643-1-dylan@andestech.com>
References: <20191115052906.2643-1-dylan@andestech.com>
Message-ID: <20191115100321.GB18488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> A segmentation fault occurs given the wrong format in test cases file.
> for example:
>     name  command line
>     ----- -----------------
>     dio10 diotest4 -b 65536    (O)
>     dio10                      (X)
>     dio10    diotest4 -b 65536 (X)
> This patch adds protection and print warning when the command part
> of the tests is empty or multiple whitespaces.

And the expected action here is that we return empty collection when the
file is wrongly formatted and ltp-pan aborts, right?

You should probably write something along these lines here as well.

> Signed-off-by: Dylan Chung <dylan@andestech.com>
> ---
>  pan/ltp-pan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
> index 8ac484ec6..470bcbfc5 100644
> --- a/pan/ltp-pan.c
> +++ b/pan/ltp-pan.c
> @@ -1200,6 +1200,14 @@ static struct collection *get_collection(char *file, int optind, int argc,
>  				n->pcnt_f[1] = 's';
>  			}
>  			n->name = strdup(strsep(&a, " \t"));
> +			while (a != NULL && isspace(*a))
> +				a++;
> +			if (a == NULL || strlen(a) == 0) {
                                           ^
					   Maybe just || a[0] == 0 there is
					   no point in using strlen for
					   checking for empty string...
> +				fprintf(stderr,
> +					"pan(%s): Testcase '%s' requires a command to execute.\n",
> +					panname, n->name);
> +				return 0;
                                       ^
				       This should be NULL
> +			}
>  			n->cmdline = strdup(a);
>  			n->next = NULL;

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
