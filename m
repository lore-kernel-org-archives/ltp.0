From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Tue, 16 Jan 2018 16:56:26 +0900
Subject: [LTP] [PATCH] skipfile: allow regular expressions
In-Reply-To: <1516089248-2268-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1516089248-2268-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <005a01d38e9f$82958e60$87c0ab20$@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ooops sorry, I shouldn't remove the \# line, I will resend in a second.

> -----Original Message-----
> From: Daniel Sangorrin [mailto:daniel.sangorrin@toshiba.co.jp]
> Sent: Tuesday, January 16, 2018 4:54 PM
> To: ltp@lists.linux.it
> Subject: [PATCH] skipfile: allow regular expressions
> 
> This patch allows using regular expressions to match
> test cases that should be skipped when using the -S option.
> For example, creating a SKIPFILE with "cron.*" on it will
> skip all test names that start with cron.
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>  runltp | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/runltp b/runltp
> index 302c4a7..c6a8d6e 100755
> --- a/runltp
> +++ b/runltp
> @@ -692,10 +692,10 @@ main()
>      fi
> 
>      # Blacklist or skip tests if a SKIPFILE was specified with -S
> +    # The SKIPFILE can contain regular expressions (e.g.: cron.*)
>      if [ -n "${SKIPFILE}" ]; then
>          for test_name in $(awk '{print $1}' "${SKIPFILE}"); do
> -            case "${test_name}" in \#*) continue;; esac
> -            sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
> +            sed -i "s/^\(${test_name}\)\s.*/\1 exit 32;/" alltests
>          done
>      fi
> 
> --
> 2.1.4



