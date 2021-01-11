From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 11 Jan 2021 16:45:00 +0800
Subject: [LTP] [PATCH 1/2] build.sh: Remove deprecated CROSS_COMPILE
In-Reply-To: <20210111030704.5761-1-lizhijian@cn.fujitsu.com>
References: <20210111030704.5761-1-lizhijian@cn.fujitsu.com>
Message-ID: <5FFC100C.5080200@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I have merged it because CROSS_COMPILE seems unneeded.
Please tell me if you have any objection.

Best Regards,
Xiao Yang
On 2021/1/11 11:07, Li Zhijian wrote:
> The CROSS_COMPILE was no longer used by ltp since 400ac9bbe20.
>
> Signed-off-by: Li Zhijian<lizhijian@cn.fujitsu.com>
> ---
>   build.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/build.sh b/build.sh
> index 452cc6f4c..602ca419e 100755
> --- a/build.sh
> +++ b/build.sh
> @@ -64,7 +64,7 @@ build_cross()
>   	fi
>
>   	echo "===== cross-compile ${host} ${1}-tree build into $PREFIX ====="
> -	build $1 $2 "--host=$host" CROSS_COMPILE="${host}-"
> +	build $1 $2 "--host=$host"
>   }
>
>   build()



