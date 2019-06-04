From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 4 Jun 2019 16:09:58 +0800
Subject: [LTP] [PATCH] lib/tst_test.c: set mount_device amd
 format_device of	all_filesystems is set
In-Reply-To: <20190604074035.4523-1-xzhou@redhat.com>
References: <20190604074035.4523-1-xzhou@redhat.com>
Message-ID: <5CF62756.3000608@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/06/04 15:40, Murphy Zhou wrote:
> preadv203.c does not set mount_device, which makes BROK:
>    preadv203.c:122: BROK: preadv2() failed: EOPNOTSUPP
>
> Fixing this by format and mount device if all_filesystems is set in library.
>
> Signed-off-by: Murphy Zhou<xzhou@redhat.com>
> ---
>   lib/tst_test.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 95f389d2e..61dba793e 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -808,8 +808,11 @@ static void do_setup(int argc, char *argv[])
>   		tst_test->format_device = 1;
>   	}
>
> -	if (tst_test->all_filesystems)
> +	if (tst_test->all_filesystems) {
>   		tst_test->needs_device = 1;
> +		tst_test->mount_device = 1;
> +		tst_test->format_device = 1;
> +	}
Hi Murph,

1) tst_test->format_device will be set automatically when we set 
tst_test->mount_device.
2) It's unreasonable to set tst_test->mount_device for all filesystems 
forcely because we
    don't need to mount for all filesystems in some cases(e.g. just test 
formating).

Perhaps, you just add tst_test->mount_device in preadv203.c. :-)

Best Regards,
Xiao Yang
>
>   	setup_ipc();
>



