From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 18 Aug 2021 11:30:53 +0200
Subject: [LTP] [PATCH 1/3] tst_test.sh: Simplify tst_cmd_available()
In-Reply-To: <20210818091224.27578-2-pvorel@suse.cz>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-2-pvorel@suse.cz>
Message-ID: <7ac7a1d6-2d97-f8f5-8d60-040eb0753681@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 8/18/2021 11:12 AM, Petr Vorel wrote:
> "command -v" [1] and "type" [2] are POSIX. They're supported in all
> common shells (bash, zsh, dash, busybox sh, mksh). Thus we don't have to
> fallback on "which", which has been discontinued after 2.21 release in
> 2015 due this (git repository is empty [3]).
>
> Use "type" instead of "command -v" which is IMHO more known.
>
> Also drop explicit return as the exit code is reliable an all
> implementations.
>
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
> [2] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html
> [3] https://git.savannah.gnu.org/cgit/which.git
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/lib/tst_test.sh | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index c6aa2c487..fa35a64f1 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -346,18 +346,7 @@ tst_virt_hyperv()
>   
>   tst_cmd_available()
>   {
> -	if type command > /dev/null 2>&1; then
> -		command -v $1 > /dev/null 2>&1 || return 1
> -	else
> -		which $1 > /dev/null 2>&1
> -		if [ $? -eq 0 ]; then
> -			return 0
> -		elif [ $? -eq 127 ]; then
> -			tst_brk TCONF "missing which command"
> -		else
> -			return 1
> -		fi
> -	fi
> +	type $1 >/dev/null 2>&1
I guess there was a reason, why command was used here in the first place.
Iirc type is often a shell builtin, that can have different behavior, 
while command -v is posix and should be extremely portable.
So maybe it is better to use "command -v" instead of type here. I hope 
most distributions have a command-command...

Joerg
