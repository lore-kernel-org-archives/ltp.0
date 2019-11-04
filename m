From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Nov 2019 16:59:01 +0100
Subject: [LTP] [PATCH] read_all_sys: skip debugfs
In-Reply-To: <4e93b0d943960d957b71bdb998b33ad30424b07c.1572881777.git.jstancek@redhat.com>
References: <4e93b0d943960d957b71bdb998b33ad30424b07c.1572881777.git.jstancek@redhat.com>
Message-ID: <20191104155900.GA5683@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> debugfs is meant for debugging, it exposes also device registers
> and can pretty much do anything:
>   https://lore.kernel.org/linux-arm-kernel/1507592549.3785589.1570404050459.JavaMail.zimbra@redhat.com/
>   https://lore.kernel.org/stable/2029139028.10333037.1572874551626.JavaMail.zimbra@redhat.com/
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/fs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/runtest/fs b/runtest/fs
> index 07d6e2b67964..fba19cae03e8 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -71,7 +71,7 @@ proc01 proc01 -m 128
>  
>  read_all_dev read_all -d /dev -p -q -r 10
>  read_all_proc read_all -d /proc -q -r 10
> -read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count
> +read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count -e '/sys/kernel/debug/*'

Do we even support multiple parameters for the same option?

I looked that the library code and I would say that we will replace the
value with each iteration which means that we will effectively use the
last one.

-- 
Cyril Hrubis
chrubis@suse.cz
