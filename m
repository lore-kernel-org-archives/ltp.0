From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 30 Mar 2020 11:02:41 +0800
Subject: [LTP] [PATCH v2] security/dirtyc0w: Get and set umask in setup
In-Reply-To: <1585536316-23604-1-git-send-email-zou_wei@huawei.com>
References: <1585536316-23604-1-git-send-email-zou_wei@huawei.com>
Message-ID: <5E816151.9060507@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/30 10:45, Zou Wei wrote:
> v2:
> Clear current umask by umask(0) in setup()
Hi Zou,

1) needs to update the subject as well.
2) add some commit message to describe the issue.

Thanks,
Xiao Yang
>
> Signed-off-by: Zou Wei<zou_wei@huawei.com>
> ---
>   testcases/kernel/security/dirtyc0w/dirtyc0w.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> index a0a81b6..6455f9c 100644
> --- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> +++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> @@ -45,6 +45,8 @@ static void setup(void)
>   {
>   	struct passwd *pw;
>
> +	umask(0);
> +
>   	pw = SAFE_GETPWNAM("nobody");
>
>   	nobody_uid = pw->pw_uid;
> --
> 2.6.2
>
>



