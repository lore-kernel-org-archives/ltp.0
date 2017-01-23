From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 13:12:09 +0100
Subject: [LTP] [RFC PATCH v2 1/1] test.sh: colorize the output
In-Reply-To: <20170120161024.1744-1-pvorel@suse.cz>
References: <20170120161024.1744-1-pvorel@suse.cz>
Message-ID: <20170123121209.GA22484@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> By default colorize unless using pipe or redirect to file.
> It's possible to force behaviour with LTP_COLORIZE_OUTPUT environment
> variable:
> y or 1: allways colorize
> n or 0: never colorize
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> TODO:
> * Allow user to define colors (overwrite with environment variables) -
>   allow to handle dark vs. light terminal background.

I still think that this is too much work for no real gain...

> * Colorize also "ltp-pan reported PASS|FAIL".

I would avoid doing any changes to ltp-pan, that code is old and complex
and in maintenance mode only.

> * DOC: where to put docs?

I'm unsure as well. I guess that we can start a new file under doc/ if
we do not find a better fit.

> * DRY: Keep default definition only on one place => generate with make?
> ---
>  include/ansi_colors.h | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_res.c         | 32 +++++++++++++++++++++---
>  lib/tst_test.c        | 30 ++++++++++++++++++-----
>  testcases/lib/test.sh | 37 +++++++++++++++++++++++++++-
>  4 files changed, 157 insertions(+), 10 deletions(-)
>  create mode 100644 include/ansi_colors.h
> 
> diff --git a/include/ansi_colors.h b/include/ansi_colors.h
> new file mode 100644
> index 000000000..fbe602f00
> --- /dev/null
> +++ b/include/ansi_colors.h
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * NOTE: these colors should match colors defined in tst_flag2color() in
> + * testcases/lib/test.sh
> + */
> +#define ANSI_COLOR_BLUE	"\e[1;34m"
> +#define ANSI_COLOR_GREEN	"\e[1;32m"
> +#define ANSI_COLOR_RED	"\e[1;31m"
> +#define ANSI_COLOR_YELLOW	"\e[1;33m"
> +#define ANSI_COLOR_RESET	"\E[00m"
> +
> +static inline char* ttype2color(int ttype) {
                                              ^
			      This opening bracket should be on a
			      separate line, but that is minor
> +	switch (TTYPE_RESULT(ttype)) {
> +	case TPASS:
> +		return ANSI_COLOR_GREEN;
> +	break;
> +	case TFAIL:
> +		return ANSI_COLOR_RED;
> +	break;
> +	case TBROK:
> +		return ANSI_COLOR_YELLOW;

TBROK should IMHO be red as well. Or at least TBROK which means broken
test should be different from TCONF which means test skipped.

> +	break;
> +	case TCONF:
> +		return ANSI_COLOR_YELLOW;

And TCONF should be different from TWARN as well. What about blue for
TCONF and yellow for TWARN?

> +	break;
> +	case TWARN:
> +		return ANSI_COLOR_YELLOW;
> +	break;
> +	case TINFO:
> +		return ANSI_COLOR_GREEN;

And TINFO messages are not important, I would just let them gray, or
without any coloring.

> +	break;
> +	default:
> +		return "";
> +	}
> +}
> +
> +static inline int color_enabled() {
> +	char *env = getenv("LTP_COLORIZE_OUTPUT");
> +
> +	if (env != NULL) {

Use just if (env) {

> +		if (strcmp(env, "n") == 0 || strcmp(env, "0") == 0)
> +			return 0;

And more cannical way is if (!strcmp(env, "n") || !strcmp(env, "0"))

> +		if (strcmp(env, "y") == 0 || strcmp(env, "1") == 0)
> +			return 1;
> +	}
> +
> +	if (isatty(STDOUT_FILENO) == 0)
> +		return 0;
> +
> +	return 1;
> +}

We can prefix these functions with tst_ and put them into a
lib/ansi_colors.c.

> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 61daaeb49..fe8d15112 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -50,6 +50,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "ltp_priv.h"
> +#include "ansi_colors.h"
>  
>  long TEST_RETURN;
>  int TEST_ERRNO;
> @@ -254,7 +255,8 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
>  	const char *type;
>  	int ttype_result = TTYPE_RESULT(ttype);
>  	char message[USERMESG];
> -	size_t size;
> +	size_t size = 0;
> +	int color = color_enabled();
>  
>  	/*
>  	 * Save the test result type by ORing ttype into the current exit value
> @@ -280,11 +282,23 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
>  	 * Build the result line and print it.
>  	 */
>  	type = strttype(ttype);
> +
> +	if (color) {
> +		char *color = ttype2color(ttype);
> +
> +		size += snprintf(message + size, sizeof(message) - size, color);
> +
> +		if (size >= sizeof(message)) {
> +			printf("%s: %i: line too long\n", __func__, __LINE__);
> +			abort();
> +		}
> +	}
> +
>  	if (T_mode == VERBOSE) {
> -		size = snprintf(message, sizeof(message),
> +		size += snprintf(message + size, sizeof(message) - size,
>  				"%-8s %4d  %s  :  %s", tcid, tnum, type, tmesg);
>  	} else {
> -		size = snprintf(message, sizeof(message),
> +		size += snprintf(message + size, sizeof(message) - size,
>  				"%-8s %4d       %s  :  %s",
>  				tcid, tnum, type, tmesg);
>  	}
> @@ -305,6 +319,8 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
>  		abort();
>  	}
>  
> +
> +

Why do we add two empty lines here?

>  	if (ttype & TTERRNO) {
>  		size += snprintf(message + size, sizeof(message) - size,
>  				 ": TEST_ERRNO=%s(%i): %s",
> @@ -324,6 +340,16 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
>  				 strerror(TEST_RETURN));
>  	}
>  
> +	if (color) {
> +		if (size >= sizeof(message)) {
> +			printf("%s: %i: line too long\n", __func__, __LINE__);
> +			abort();
> +		}
> +
> +		size += snprintf(message + size, sizeof(message) - size,
> +				 ANSI_COLOR_RESET);
> +	}
> +
>  	if (size + 1 >= sizeof(message)) {
>  		printf("%s: %i: line too long\n", __func__, __LINE__);
>  		abort();
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c48d71877..bd47d8f2f 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -29,6 +29,7 @@
>  #include "tst_test.h"
>  #include "tst_device.h"
>  #include "lapi/futex.h"
> +#include "ansi_colors.h"
>  
>  #include "old_resource.h"
>  #include "old_device.h"
> @@ -164,6 +165,7 @@ static void print_result(const char *file, const int lineno, int ttype,
>  	int ret, size = sizeof(buf);
>  	const char *str_errno = NULL;
>  	const char *res;
> +	int color = color_enabled();
>  
>  	switch (TTYPE_RESULT(ttype)) {
>  	case TPASS:
> @@ -194,20 +196,36 @@ static void print_result(const char *file, const int lineno, int ttype,
>  	if (ttype & TTERRNO)
>  		str_errno = tst_strerrno(TEST_ERRNO);
>  
> -	ret = snprintf(str, size, "%s:%i: %s: ", file, lineno, res);
> +	if (color) {
> +		char *color = ttype2color(ttype);
> +
> +		ret = snprintf(str, size, "%s", color);
> +		str += ret;
> +		size -= ret;
> +	}
>  
> +	ret = snprintf(str, size, "%s:%i: %s: ", file, lineno, res);
>  	str += ret;
>  	size -= ret;

I'm also wondering if we should colorize only the res here. That would
keep the actual message readable while we would make the output
colorized as well.

> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 76b706267..c3321f706 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -39,15 +39,50 @@ tst_flag2mask()
>  	esac
>  }
>  
> +tst_flag2color()
> +{
> +	# NOTE: these colors should match colors defined in include/ansi_colors.h
> +	local blue='\e[1;34m'
> +	local green='\e[1;32m'
> +	local red='\e[1;31m'
> +	local yellow='\e[1;33m'
> +
> +	case "$1" in
> +	TPASS) printf $green;;
> +	TFAIL) printf $red;;
> +	TBROK) printf $yellow;;
> +	TWARN) printf $yellow;;
> +	TINFO) printf $blue;;
> +	TCONF) printf $yellow;;
> +	*) tst_brkm TBROK "Invalid resm type '$1'";;
> +	esac
> +}
> +
> +tst_color_enabled()
> +{
> +	[ "$LTP_COLORIZE_OUTPUT" = "n" ] || [ "$LTP_COLORIZE_OUTPUT" = "0" ] && return 0
> +	[ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ] && return 1
> +	[ -t 1 ] || return 0
> +	return 1
> +}

We would need to put this into a shell library (something as
tst_ansi_color.sh) as well, since we need this code to be used in
tst_test.sh as well.

-- 
Cyril Hrubis
chrubis@suse.cz
