From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 24 Aug 2020 12:35:46 +0200
Subject: [LTP] [PATCH 1/1] prepare_lvm.sh: Allow to define tmp directory
In-Reply-To: <20200824102439.26587-1-pvorel@suse.cz>
References: <20200824102439.26587-1-pvorel@suse.cz>
Message-ID: <332d88d9-7a5e-c45a-273e-61da8aaad3c6@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24. 08. 20 12:24, Petr Vorel wrote:
> Many distros don't have enough /tmp size for LVM tests, thus
> allow to set $LVM_DIR to use different temporary directory.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/misc/lvm/prepare_lvm.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
> index e7f9c90e4..b6557f221 100755
> --- a/testcases/misc/lvm/prepare_lvm.sh
> +++ b/testcases/misc/lvm/prepare_lvm.sh
> @@ -9,8 +9,9 @@ TST_NEEDS_ROOT=1
>  TST_NEEDS_CMDS="mount pvcreate vgcreate lvcreate"
>  . tst_test.sh
>  
> -LVM_TMPDIR="/tmp/ltp/growfiles"
> -LVM_IMGDIR="/tmp/ltp/imgfiles"
> +LVM_DIR="${LVM_DIR:-/tmp}"
> +LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
> +LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
>  
>  error_check()
>  {
> 

You should change only LVM_IMGDIR where the backing files are stored. If
you also change LVM_TMPDIR, it'll break the lvm.local runfile.

Also don't forget to update cleanup_lvm.sh.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
