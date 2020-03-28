From: Xiao Yang <ice_yangxiao@163.com>
Date: Sat, 28 Mar 2020 19:22:09 +0800
Subject: [LTP] [PATCH] security/dirtyc0w: Get and set umask in setup
In-Reply-To: <1585378614-16872-1-git-send-email-zou_wei@huawei.com>
References: <1585378614-16872-1-git-send-email-zou_wei@huawei.com>
Message-ID: <37690463-e988-cc75-4ffb-da036a83d027@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/28/20 2:56 PM, Zou Wei wrote:
> The case is only successful when system default umask is 0022.
> When umask is 0077, should change the value to 0022 in setup.
>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   testcases/kernel/security/dirtyc0w/dirtyc0w.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> index a0a81b6..7abb5a2 100644
> --- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> +++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> @@ -45,6 +45,10 @@ static void setup(void)
>   {
>   	struct passwd *pw;
>
> +	if ((umask(0))==63){
> +		umask(18);
> +	}
> +

Hi Zou,

just clear current umask by umask(0) here if you want to exclude the 
impact of umask.

btw: it is readable to use otcal number(e.g. umask(0022) == 0022)

Thanks,

Xiao Yang

>   	pw = SAFE_GETPWNAM("nobody");
>
>   	nobody_uid = pw->pw_uid;
> --
> 2.6.2
>
>

