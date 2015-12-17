From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Dec 2015 09:05:39 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/xattr: avoid creating whiteout device
In-Reply-To: <1450360354-18399-1-git-send-email-eguan@redhat.com>
References: <1450360354-18399-1-git-send-email-eguan@redhat.com>
Message-ID: <1123103187.29766703.1450361139646.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Eryu Guan" <eguan@redhat.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 17 December, 2015 2:52:34 PM
> Subject: [LTP] [PATCH] syscalls/xattr: avoid creating whiteout device
> 
> Do the same as in commit 3337c31d3577 ("syscalls: avoid creating
> whiteout device in tests"), because overlayfs refuses to create whiteout
> device.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Thanks for the follow-up, pushed.

Regards,
Jan

> ---
> 
> I missed [sg]etxattr02.c in commit 3337c31d3577. After searching around all
> the
> tests I confirmed that [sg]etxattr02.c are the last two places to create
> whiteout device.
> 
>  testcases/kernel/syscalls/getxattr/getxattr02.c | 4 +++-
>  testcases/kernel/syscalls/setxattr/setxattr02.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c
> b/testcases/kernel/syscalls/getxattr/getxattr02.c
> index 1e991cf..8c5be0f 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr02.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
> @@ -118,6 +118,7 @@ int main(int argc, char *argv[])
>  static void setup(void)
>  {
>  	int fd;
> +	dev_t dev;
>  
>  	tst_require_root();
>  
> @@ -139,7 +140,8 @@ static void setup(void)
>  		tst_brkm(TBROK | TERRNO, cleanup, "Create FIFO(%s) failed",
>  			 FIFO);
>  
> -	if (mknod(CHR, S_IFCHR | 0777, 0) == -1)
> +	dev = makedev(1, 3);
> +	if (mknod(CHR, S_IFCHR | 0777, dev) == -1)
>  		tst_brkm(TBROK | TERRNO, cleanup, "Create char special(%s)"
>  			 " failed", CHR);
>  
> diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c
> b/testcases/kernel/syscalls/setxattr/setxattr02.c
> index 169a9d6..0ae0b3f 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr02.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
> @@ -178,6 +178,7 @@ int main(int argc, char *argv[])
>  static void setup(void)
>  {
>  	int fd;
> +	dev_t dev;
>  
>  	tst_require_root();
>  
> @@ -213,7 +214,8 @@ static void setup(void)
>  		tst_brkm(TBROK | TERRNO, cleanup, "Create FIFO(%s) failed",
>  			 FIFO);
>  
> -	if (mknod(CHR, S_IFCHR | 0777, 0) == -1)
> +	dev = makedev(1, 3);
> +	if (mknod(CHR, S_IFCHR | 0777, dev) == -1)
>  		tst_brkm(TBROK | TERRNO, cleanup, "Create char special(%s)"
>  			 " failed", CHR);
>  
> --
> 2.5.0
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
