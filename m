From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Apr 2021 12:35:54 +0200
Subject: [LTP] [PATCH] fs/iso9660: bugfix for iso9660/isofs.sh
In-Reply-To: <20210402031934.14615-1-zhanglianjie@uniontech.com>
References: <20210402031934.14615-1-zhanglianjie@uniontech.com>
Message-ID: <YGw5inZ09uZY2uRs@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> Currently in Debian, only the package genisoimage in sid and bullseye contains mkisofs,
> and there is no deb package of mkisofs in architectures such as mips. In addition, 
> this patch increases compatibility and is better than the previous one. 

Well, bullseye is stable. But ok, some people might care about oldstable (we
test it built LTP in Travis) and even oldoldstable.

> It is necessary to modify it.
> Reference: https://packages.debian.org/search?suite=sid&searchon=contents&keywords=mkisofs 

> According to your suggestion, the revised patch:
> ---
>  testcases/kernel/fs/iso9660/isofs.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
> index 9de3f7cdc..1da3a398f 100755
> --- a/testcases/kernel/fs/iso9660/isofs.sh
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -12,6 +12,11 @@
>  TST_NEEDS_CMDS="mkisofs"
>  TST_NEEDS_TMPDIR=1
>  TST_TESTFUNC=do_test
> +if ! which mkisofs >/dev/null 2>&1; then
> +       TST_NEEDS_CMDS="genisoimage"
> +fi
> +MKISOFS_CMD=$TST_NEEDS_CMDS

Actually, this depends on which (take look on tst_cmd_available(), it also uses
command and trying to use which only if missing). And also it's misleading to
suggest to use only genisoimage.

Although for our documentation ("docparse"), it'd be better to use
TST_NEEDS_CMDS, until (if ever) shell API supports logical OR (e.g.
TST_NEEDS_CMDS="mkisofs|genisoimage") it'd be better to avoid TST_NEEDS_CMDS and
decide in the setup. Thus if you don't mind I'll merge this fix with you as an author:

setup()
{
	if ! tst_cmd_available mkisofs && ! tst_cmd_available genisoimage; then
		tst_brk TCONF "please install mkisofs or genisoimage"
	fi
}

> @@ -56,7 +61,7 @@ do_test() {
>  		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
>  	do
>  		rm -f isofs.iso
> -		EXPECT_PASS mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
> +		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \

Kind regards,
Petr
