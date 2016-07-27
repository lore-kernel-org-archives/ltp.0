From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 11:22:10 +0200
Subject: [LTP] [PATCH 2/2] mkfs01: extend the loop device size to 256M
In-Reply-To: <1469598247-23993-2-git-send-email-liwang@redhat.com>
References: <1469598247-23993-1-git-send-email-liwang@redhat.com>
 <1469598247-23993-2-git-send-email-liwang@redhat.com>
Message-ID: <20160727092210.GB10645@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/commands/mkfs/mkfs01.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
> index eda9829..9a26899 100755
> --- a/testcases/commands/mkfs/mkfs01.sh
> +++ b/testcases/commands/mkfs/mkfs01.sh
> @@ -32,7 +32,8 @@ setup()
>  
>  	tst_tmpdir
>  
> -	tst_acquire_device
> +	# set test_dev.img size
> +	tst_acquire_device 256

As far as I can tell 150MB should suffice as well, at least for me the
btrfs-progs v4.3.1+ requests at least 136MB. Or did they increase the
minimal size again?

And I guess that we should bump the size in runltp script as well.

-- 
Cyril Hrubis
chrubis@suse.cz
