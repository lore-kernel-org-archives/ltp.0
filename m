From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Sep 2015 03:48:12 -0400 (EDT)
Subject: [LTP] [PATCH] lib/tst_mkfs: detect btrfs -f option correctly
In-Reply-To: <1442462652-15371-1-git-send-email-eguan@redhat.com>
References: <1442462652-15371-1-git-send-email-eguan@redhat.com>
Message-ID: <1915646876.13132827.1442476092616.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Eryu Guan" <eguan@redhat.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 17 September, 2015 6:04:12 AM
> Subject: [LTP] [PATCH] lib/tst_mkfs: detect btrfs -f option correctly
> 
> btrfs-progs commit 3f312d500b73 ("btrfs-progs: mkfs, align help
> strings") changed the usage text:
> 
>  - -f --force
>  + -f|--force
> 
> and tst_mkfs failed to add -f option to mkfs.btrfs.
> 
> Update the grep regex to match both old and new text, and now -f option
> is added to mkfs.btrfs.
> 
> [root@host ltp]# LTP_DEV_FS_TYPE=btrfs ./chown04
> chown04     0  TINFO  :  Found free device '/dev/loop0'
> chown04     0  TINFO  :  Appending '-f' flag to mkfs.btrfs
> chown04     0  TINFO  :  Formatting /dev/loop0 with btrfs extra opts=''
> ...
> 
> Also use -q option of grep instead of redirecting output to /dev/null to
> avoid line over 80 column.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Pushed, also thanks for referencing commit that introduced the change.

Regards,
Jan


> ---
>  lib/tst_mkfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index c01cdf3..5f959a4 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -45,7 +45,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  		/*
>  		 * The -f option was added to btrfs-progs v3.12
>  		 */
> -		if (!tst_system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null")) {
> +		if (!tst_system("mkfs.btrfs 2>&1 | grep -q '\\-f[ |]'")) {
>  			tst_resm(TINFO, "Appending '-f' flag to mkfs.%s",
>  				fs_type);
>  			argv[pos++] = "-f";
> --
> 2.4.3
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
