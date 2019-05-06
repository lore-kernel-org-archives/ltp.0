From: Steve Muckle <smuckle@google.com>
Date: Mon, 6 May 2019 11:06:25 -0700
Subject: [LTP] [PATCH] ANDROID: Fix ioctl03 test for Android
In-Reply-To: <20190506153836.232148-1-paullawrence@google.com>
References: <20190506153836.232148-1-paullawrence@google.com>
Message-ID: <e9e6ad70-3f35-1c07-d7e7-db2d1fe0477e@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Steve Muckle <smuckle@google.com>

On 5/6/19 8:38 AM, 'Paul Lawrence' via kernel-team wrote:
> Android has tun file at /dev/tun not /dev/net/tun
> 
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl03.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
> index b1b50edb4..cc9a2edaf 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl03.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
> @@ -79,6 +79,11 @@ static void verify_features(void)
>   	unsigned int features, i;
>   
>   	int netfd = open("/dev/net/tun", O_RDWR);
> +
> +	/* Android has tun at /dev/tun */
> +	if (netfd == -1 && (errno == ENODEV || errno == ENOENT))
> +		netfd = open("/dev/tun", O_RDWR);
> +
>   	if (netfd == -1) {
>   		if (errno == ENODEV || errno == ENOENT)
>   			tst_brk(TCONF, "TUN support is missing?");
> 

