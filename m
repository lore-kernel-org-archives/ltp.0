From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Sep 2018 14:40:11 +0200
Subject: [LTP] [PATCH] ver_linux: use lscpu command result instead of
 /proc/cpuinfo
In-Reply-To: <20180815185516.32726-1-msys.mizuma@gmail.com>
References: <20180815185516.32726-1-msys.mizuma@gmail.com>
Message-ID: <20180927124010.GB11658@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  ver_linux | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/ver_linux b/ver_linux
> index dda337926..5f9260f5f 100755
> --- a/ver_linux
> +++ b/ver_linux
> @@ -96,5 +96,10 @@ echo 'free reports:'
>  free
>  
>  echo
> -echo '/proc/cpuinfo'
> -cat /proc/cpuinfo
> +echo 'cpuinfo:'
> +which lscpu > /dev/null 2>&1
> +if [ $? -eq 0 ]; then

You can just write:

if which lscpu > /dev/null 2>&1; then
...


Other than that it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
