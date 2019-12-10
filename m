From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 10 Dec 2019 09:37:15 +0800
Subject: [LTP] [PATCH 1/1] shell: TST_NEEDS_DEVICE imply TST_TMPDIR
In-Reply-To: <20191209203248.2427967-1-pvorel@suse.cz>
References: <20191209203248.2427967-1-pvorel@suse.cz>
Message-ID: <e72e0225-1b5d-1e4b-051f-a392c13a97c8@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



on 2019/12/10 4:32, Petr Vorel wrote:
> instead of requiring to be set.
> This is a sync with C API (previous commit).
> 
Hi Petr

Looks good to me, let's wait whether others have some objections.

Kind Regards,
Yang Xu
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> sync shell API with patch for C API
> (should be accepted only if we agree on
> https://patchwork.ozlabs.org/patch/1204029/).
> 
> Kind regards,
> Petr
> 
>   doc/test-writing-guidelines.txt                            | 1 +
>   testcases/commands/df/df01.sh                              | 1 -
>   testcases/commands/mkfs/mkfs01.sh                          | 1 -
>   testcases/commands/mkswap/mkswap01.sh                      | 1 -
>   testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 1 -
>   testcases/lib/tst_test.sh                                  | 5 ++---
>   6 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index e8e766753..79d857fea 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -2125,6 +2125,7 @@ simply by setting right '$TST_NEEDS_FOO'.
>   | 'TST_NEEDS_TMPDIR' | Create test temporary directory and cd into it.
>   | 'TST_NEEDS_DEVICE' | Prepare test temporary device, the path to testing
>                          device is stored in '$TST_DEVICE' variable.
> +                       The option implies 'TST_NEEDS_TMPDIR'.
>   | 'TST_NEEDS_CMDS'   | String with command names that has to be present for
>                          the test (see below).
>   | 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index 1ab4547f4..02aeec7b4 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -13,7 +13,6 @@ TST_OPTS="f:"
>   TST_USAGE=usage
>   TST_PARSE_ARGS=parse_args
>   TST_NEEDS_ROOT=1
> -TST_NEEDS_TMPDIR=1
>   TST_NEEDS_DEVICE=1
>   . tst_test.sh
>   
> diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
> index 81f1a168c..90368190d 100755
> --- a/testcases/commands/mkfs/mkfs01.sh
> +++ b/testcases/commands/mkfs/mkfs01.sh
> @@ -12,7 +12,6 @@ TST_OPTS="f:"
>   TST_USAGE=usage
>   TST_PARSE_ARGS=parse_args
>   TST_NEEDS_ROOT=1
> -TST_NEEDS_TMPDIR=1
>   TST_NEEDS_DEVICE=1
>   TST_NEEDS_CMDS="blkid df"
>   . tst_test.sh
> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
> index 9437c4a4e..f6494f6e3 100755
> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -9,7 +9,6 @@ TST_CNT=10
>   TST_SETUP=setup
>   TST_TESTFUNC=do_test
>   TST_NEEDS_ROOT=1
> -TST_NEEDS_TMPDIR=1
>   TST_NEEDS_DEVICE=1
>   TST_NEEDS_CMDS="uuidgen blkid blockdev mkswap"
>   . tst_test.sh
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 51c03013d..422ec0b47 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -9,7 +9,6 @@ TST_SETUP_CALLER="$TST_SETUP"
>   TST_SETUP="ima_setup"
>   TST_CLEANUP_CALLER="$TST_CLEANUP"
>   TST_CLEANUP="ima_cleanup"
> -TST_NEEDS_TMPDIR=1
>   TST_NEEDS_ROOT=1
>   
>   . tst_test.sh
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index f772857eb..e0265c1d1 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -525,6 +525,8 @@ tst_run()
>   
>   	_tst_setup_timer
>   
> +	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_TMPDIR=1
> +
>   	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
>   		if [ -z "$TMPDIR" ]; then
>   			export TMPDIR="/tmp"
> @@ -541,9 +543,6 @@ tst_run()
>   
>   	TST_MNTPOINT="${TST_MNTPOINT:-mntpoint}"
>   	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
> -		if [ -z ${TST_TMPDIR} ]; then
> -			tst_brk TBROK "Use TST_NEEDS_TMPDIR must be set for TST_NEEDS_DEVICE"
> -		fi
>   
>   		TST_DEVICE=$(tst_device acquire)
>   
> 


