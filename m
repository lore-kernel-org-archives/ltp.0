From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 24 Aug 2020 16:28:03 +0200
Subject: [LTP] [PATCH v2 1/1] prepare_lvm.sh: Allow to define tmp
 directory
In-Reply-To: <20200824112109.2995-1-pvorel@suse.cz>
References: <20200824112109.2995-1-pvorel@suse.cz>
Message-ID: <648dc99d-5079-23ec-eba2-b10215ae8130@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24. 08. 20 13:21, Petr Vorel wrote:
> Many distros don't have enough /tmp size for LVM tests, thus
> allow to set $LVM_DIR to use different temporary directory.
> 
> Most of the space take backing files ($LVM_IMGDIR), but for consistency
> changed both directories. $LVM_TMPDIR requires to update
> generate_lvm_runfile.sh.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * Update all required scripts
> 
>  testcases/misc/lvm/cleanup_lvm.sh          | 5 +++--
>  testcases/misc/lvm/generate_lvm_runfile.sh | 4 +++-
>  testcases/misc/lvm/prepare_lvm.sh          | 5 +++--
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/misc/lvm/cleanup_lvm.sh b/testcases/misc/lvm/cleanup_lvm.sh
> index e18efe2b0..03eb384be 100755
> --- a/testcases/misc/lvm/cleanup_lvm.sh
> +++ b/testcases/misc/lvm/cleanup_lvm.sh
> @@ -9,8 +9,9 @@ TST_NEEDS_ROOT=1
>  TST_NEEDS_CMDS="losetup umount vgremove"
>  . tst_test.sh
>  
> -LVM_TMPDIR="/tmp/ltp/growfiles"
> -LVM_IMGDIR="/tmp/ltp/imgfiles"
> +LVM_DIR="${LVM_DIR:-/tmp}"
> +LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
> +LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
>  
>  cleanup_lvm()
>  {
> diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
> index 5ca035f22..a8388cf3d 100755
> --- a/testcases/misc/lvm/generate_lvm_runfile.sh
> +++ b/testcases/misc/lvm/generate_lvm_runfile.sh
> @@ -9,6 +9,8 @@ TST_NEEDS_ROOT=1
>  TST_NEEDS_CMDS="sed"
>  . tst_test.sh
>  
> +LVM_DIR="${LVM_DIR:-/tmp}"
> +
>  generate_runfile()
>  {
>  	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
> @@ -20,7 +22,7 @@ generate_runfile()
>  	for fsname in $FS_LIST; do
>  		# Btrfs needs too much space for reliable stress testing
>  		if [ "x$fsname" != "xbtrfs" ]; then
> -			sed -e "s/{fsname}/$fsname/g" "$INFILE" >>"$OUTFILE"
> +			sed -e "s/{fsname}/$fsname/g; s^/tmp/ltp^$LVM_DIR/ltp^g" "$INFILE" >>"$OUTFILE"

If you want to change the path in the runfile instead, it'd be cleaner
to use a placeholder like {tempdir}. Otherwise:

Acked-by: Martin Doucha <mdoucha@suse.cz>

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
