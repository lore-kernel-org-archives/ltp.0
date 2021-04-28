From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 28 Apr 2021 07:40:42 +0000
Subject: [LTP] [PATCH] runtest/mm: Remove mem03 from runtest/mm
In-Reply-To: <1619589411-3349-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1619589411-3349-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <60891197.60306@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui

Good catch, merged with adding fixes tag.

Best Regards
Yang Xu
> Signed-off-by: Jinhui Huang<huangjh.jy@cn.fujitsu.com>
> ---
>   runtest/mm | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/runtest/mm b/runtest/mm
> index eeebd87..6537666 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -21,7 +21,6 @@ mtest06_3 mmap3 -x 0.002 -p
>   #mtest-6_4 shmat1 -x 0.00005
> 
>   mem02 mem02
> -mem03 mem03
> 
>   page01 page01
>   page02 page02
