From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 28 Apr 2020 13:55:39 +0800
Subject: [LTP] [PATCH V2] syscalls/pipe2: Add pipe2_02_child in
 .gitignore
In-Reply-To: <c3cbc45d1758c6eaf1957c7e75d920b7990e24eb.1588051498.git.viresh.kumar@linaro.org>
References: <c3cbc45d1758c6eaf1957c7e75d920b7990e24eb.1588051498.git.viresh.kumar@linaro.org>
Message-ID: <5EA7C55B.5010902@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

It is simple and fine and I will push it directly.

Thanks,
Xiao Yang
On 2020/4/28 13:25, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar<viresh.kumar@linaro.org>
> ---
> V2: Move it a line up to keep ordering intact.
>
>   testcases/kernel/syscalls/pipe2/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
> index 773450a484af..50f7023b8dd4 100644
> --- a/testcases/kernel/syscalls/pipe2/.gitignore
> +++ b/testcases/kernel/syscalls/pipe2/.gitignore
> @@ -1,3 +1,4 @@
>   /pipe2_01
>   /pipe2_02
> +/pipe2_02_child
>   /pipe2_04



