From: Eryu Guan <eguan@redhat.com>
Date: Mon, 9 Nov 2015 14:55:11 +0800
Subject: [LTP] [PATCH 1/2] test_robind.sh: set default FSTYPES to
 LTP_BIG_DEV_FS_TYPE
In-Reply-To: <BLU436-SMTP246325283779603A7A41F76CF150@phx.gbl>
References: <1446273800-2494-1-git-send-email-eguan@redhat.com>
 <BLU436-SMTP246325283779603A7A41F76CF150@phx.gbl>
Message-ID: <20151109065511.GH20082@dhcp-13-216.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 09, 2015 at 02:31:32PM +0800, Lei Li wrote:
> >In test_robind.sh LTP_BIG_DEV is used, so use LTP_BIG_DEV_FS_TYPE as
> >default fs type accordingly. If LTP_BIG_DEV_FS_TYPE is not set, fall
> >back to ext3.
> >
> >Signed-off-by: Eryu Guan <eguan@redhat.com>
> >---
> >  testcases/kernel/fs/fs_readonly/test_robind.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> >diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
> >index 0513275..5674ca4 100755
> >--- a/testcases/kernel/fs/fs_readonly/test_robind.sh
> >+++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
> >@@ -123,9 +123,10 @@ setup()
> >  		mkdir -p $dir
> >  	done
> >
> >-	# populating the default FS as ext3, if FS is not given
> >+	# populating the default FS as $LTP_BIG_DEV_FS_TYPE
> >+	# (or ext3 if it's not set), if FS is not given
> >  	if [ -z "$*" ]; then
> >-		FSTYPES="ext3"
> >+		FSTYPES=${LTP_BIG_DEV_FS_TYPE:-ext3}
> Hi!
> 	Except LTP_BIG_DEV is not set, is there any chance that LTP_BIG_DEV_FS_TYP
> will be NULL? If LTP_BIG_DEV is not set, this test case will exit with a
> tst_brkm, and if LTP_BIG_DEV is set, LTP_BIG_DEV_FS_TYPE always gets a value
> in runltp script, here is the snippet:

When we "export LTP_BIG_DEV=xxx" but don't export LTP_BIG_DEV_FS_TYPE

> 
>     if [ -z "$BIG_DEVICE" ]; then
>         echo "no big block device was specified on commandline."
>         echo "Tests which require a big block device are disabled."
>         echo "You can specify it with option -z"

runltp checks "$BIG_DEVICE" here, but test_robind.sh checks
"$LTP_BIG_DEV" and tst_brkm if it's empty. So we can export LTP_BIG_DEV
directly to bypass the BIG_DEVICE check in runltp and get no
LTP_BIG_DEV_FS_TYPE set.

Thanks,
Eryu

>     else
>         export LTP_BIG_DEV=$BIG_DEVICE
>         if [ -z "$BIG_DEVICE_FS_TYPE" ]; then
>             export LTP_BIG_DEV_FS_TYPE="ext2"
>         else
>             export LTP_BIG_DEV_FS_TYPE=$BIG_DEVICE_FS_TYPE
>         fi
>     fi
> 
> IMHO, FSTYPES should be ${LTP_BIG_DEV_FS_TYP} rather than
> ${LTP_BIG_DEV_FS_TYPE:-ext3}.
> >  	else
> >  		FSTYPES="$*"
> >  	fi
> >
> 
> Thanks
> -- 
> Rock Lee
> rocklee_104@outlook.com
