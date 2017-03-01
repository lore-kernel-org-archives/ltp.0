From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Mar 2017 14:13:23 +0100
Subject: [LTP] [PATCH 2/2] color: Fix backslash-escape sequences for
 some non-bash shells
In-Reply-To: <20170217000345.18704-2-pvorel@suse.cz>
References: <20170217000345.18704-1-pvorel@suse.cz>
 <20170217000345.18704-2-pvorel@suse.cz>
Message-ID: <20170301131323.GC32207@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -21,13 +21,13 @@
>   * NOTE: these colors should match colors defined in tst_flag2color() in
>   * testcases/lib/tst_ansi_color.sh
>   */
> -#define ANSI_COLOR_BLUE		"\e[1;34m"
> -#define ANSI_COLOR_GREEN	"\e[1;32m"
> -#define ANSI_COLOR_MAGENTA	"\e[1;35m"
> -#define ANSI_COLOR_RED		"\e[1;31m"
> -#define ANSI_COLOR_YELLOW	"\e[1;33m"
> +#define ANSI_COLOR_BLUE		"\033[34;1m"
> +#define ANSI_COLOR_GREEN	"\033[32;1m"
> +#define ANSI_COLOR_MAGENTA	"\033[35;1m"
> +#define ANSI_COLOR_RED		"\033[31;1m"
> +#define ANSI_COLOR_YELLOW	"\033[33;1m"
>  
> -#define ANSI_COLOR_RESET	"\e[00m"
> +#define ANSI_COLOR_RESET	"\033[0m"

I suppose that we are changing the C header to keep it consistent with
the shell one? I guess that's OK.

>  char* tst_ttype2color(int ttype);
>  int tst_color_enabled(int fd);
> diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
> index 987397144..1fcd7a4c9 100644
> --- a/testcases/lib/tst_ansi_color.sh
> +++ b/testcases/lib/tst_ansi_color.sh
> @@ -21,11 +21,11 @@
>  tst_flag2color()
>  {
>  	# NOTE: these colors should match colors defined in include/tst_ansi_color.h
> -	local ansi_color_blue='\e[1;34m'
> -	local ansi_color_green='\e[1;32m'
> -	local ansi_color_magenta='\e[1;35m'
> -	local ansi_color_red='\e[1;31m'
> -	local ansi_color_yellow='\e[1;33m'
> +	local ansi_color_blue='\033[34;1m'
> +	local ansi_color_green='\033[32;1m'
> +	local ansi_color_magenta='\033[35;1m'
> +	local ansi_color_red='\033[31;1m'
> +	local ansi_color_yellow='\033[33;1m'

I'm a bit puzzled by the change of the position of color and bold in the
escape sequence. As far as I can tell it does not matter at all, or does
it?

And the patch description does not describe this part of the change
either...

>  	case "$1" in
>  	TPASS) printf $ansi_color_green;;
> @@ -52,5 +52,5 @@ tst_print_colored()
>  
>  	[ "$color" = "1" ] && tst_flag2color "$1"
>  	printf "$2"
> -	[ "$color" = "1" ] && printf '\e[00m'
> +	[ "$color" = "1" ] && printf '\033[0m'
>  }
> -- 
> 2.11.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
