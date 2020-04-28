From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 28 Apr 2020 13:21:48 +0800
Subject: [LTP] [PATCH] syscalls/pipe2: Add pipe2_02_child in .gitignore
In-Reply-To: <6bbeda113f33b284abcd652647273726fc1bef5c.1588050829.git.viresh.kumar@linaro.org>
References: <6bbeda113f33b284abcd652647273726fc1bef5c.1588050829.git.viresh.kumar@linaro.org>
Message-ID: <9410c366-907c-fee2-3145-16f3c62627e1@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   testcases/kernel/syscalls/pipe2/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
> index 773450a484af..7e7b3cc89916 100644
> --- a/testcases/kernel/syscalls/pipe2/.gitignore
> +++ b/testcases/kernel/syscalls/pipe2/.gitignore
> @@ -1,3 +1,4 @@
>   /pipe2_01
>   /pipe2_02
>   /pipe2_04
> +/pipe2_02_child
Sorry for missing pipe2_02_child, putting it before pipe2_04 is better.

Best Regards
Yang Xu
> 


