From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 18 Aug 2021 11:31:52 +0200
Subject: [LTP] [PATCH 2/3] binfmt_misc02.sh: Use "command -v" instead of
 "which"
In-Reply-To: <20210818091224.27578-3-pvorel@suse.cz>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-3-pvorel@suse.cz>
Message-ID: <a695f1b3-ce44-b4b5-6a11-edd75df093fc@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 8/18/2021 11:12 AM, Petr Vorel wrote:
> "which" has been discontinued after 2.21 release in 2015 due this (git
> repository is empty [1]) it provides warning on Debian/Ubuntu [2].
>
> Use "command -v" which is POSIX [3] and supported on all common shells
> (bash, zsh, dash, busybox sh, mksh).
>
> [1] https://git.savannah.gnu.org/cgit/which.git
> [2] https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb
> [3] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
> index 9dbcd68cc..cb4e770e3 100755
> --- a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
> +++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
> @@ -19,7 +19,7 @@
>   
>   TST_CNT=6
>   TST_TESTFUNC=do_test
> -TST_NEEDS_CMDS="which cat head"
> +TST_NEEDS_CMDS="cat head"
>   
>   . binfmt_misc_lib.sh
>   
> @@ -89,17 +89,17 @@ verify_binfmt_misc()
>   do_test()
>   {
>   	case $1 in
> -	1) verify_binfmt_misc ":textension:E::extension::$(which cat):" \
> +	1) verify_binfmt_misc ":textension:E::extension::$(type cat):" \
>   			      "$TST_DATAROOT/file.extension" "1";;
> -	2) verify_binfmt_misc ":tmagic:M:1:This::$(which cat):" \
> +	2) verify_binfmt_misc ":tmagic:M:1:This::$(type cat):" \
>   			      "$TST_DATAROOT/file.magic" "1";;
> -	3) verify_binfmt_misc ".textension.E..extension..$(which cat)." \
> +	3) verify_binfmt_misc ".textension.E..extension..$(type cat)." \
>   			      "$TST_DATAROOT/file.extension" "1";;
> -	4) verify_binfmt_misc ",tmagic,M,1,This,,$(which cat)," \
> +	4) verify_binfmt_misc ",tmagic,M,1,This,,$(type cat)," \
>   			      "$TST_DATAROOT/file.magic" "1";;
> -	5) verify_binfmt_misc ":textension:E::ltp::$(which cat):" \
> +	5) verify_binfmt_misc ":textension:E::ltp::$(type cat):" \
>   			      "$TST_DATAROOT/file.extension" "0";;
> -	6) verify_binfmt_misc ":tmagic:M:0:This::$(which cat):" \
> +	6) verify_binfmt_misc ":tmagic:M:0:This::$(type cat):" \
>   			      "$TST_DATAROOT/file.magic" "0";;
This does not match the description, you say you replace which with 
command, but actually you replaced it with type.

>   	esac
>   }

