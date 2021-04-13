From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Apr 2021 22:27:41 +0200
Subject: [LTP] [PATCH] bugfix for iso9660/isofs.sh
In-Reply-To: <20210407052424.5795-1-zhanglianjie@uniontech.com>
References: <20210407052424.5795-1-zhanglianjie@uniontech.com>
Message-ID: <YHX+vS+SnHJt7mDi@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> Thank you very much for your guidance, but I want to submit it myself. 
> Because this is the first time I submit a patch in the community.

I added this as your commit and merged. But please next time send a proper patch
(it's easier to use proper patch via LTP patchwork [1]).
And I added additional cleanup patch.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/

> ---
>  testcases/kernel/fs/iso9660/isofs.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
> index 9de3f7cdc..c0e2d1ff8 100755
> --- a/testcases/kernel/fs/iso9660/isofs.sh
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -9,14 +9,26 @@
>  # It makes ISO9660 file system with different options and also
>  # mounts ISO9660 file system with different mount options.

> -TST_NEEDS_CMDS="mkisofs"
>  TST_NEEDS_TMPDIR=1
>  TST_TESTFUNC=do_test
> +TST_SETUP=setup
> +
>  . tst_test.sh

>  MAX_DEPTH=3
>  MAX_DIRS=4

> +setup()
> +{
> +	if tst_cmd_available mkisofs; then
> +		MKISOFS_CMD="mkisofs"
> +	elif tst_cmd_available genisoimage; then
> +		MKISOFS_CMD="genisoimage"
> +	else
> +		tst_brk TCONF "please install mkisofs or genisoimage"
> +	fi
> +}
> +
>  gen_fs_tree()
>  {
>  	local cur_path="$1"
> @@ -56,7 +68,7 @@ do_test() {
>  		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
>  	do
>  		rm -f isofs.iso
> -		EXPECT_PASS mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
> +		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
>  			|| continue

>  		for mount_opt in \
