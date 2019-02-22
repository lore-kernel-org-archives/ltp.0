From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 22 Feb 2019 15:48:21 +0800
Subject: [LTP] [PATCH ltp] syscalls: add compat_16 tests into .gitignore
 for	getresgid, getresuid
In-Reply-To: <20190222035345.8887-1-yixin.zhang@intel.com>
References: <20190222035345.8887-1-yixin.zhang@intel.com>
Message-ID: <5C6FA945.8010402@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,

It looks fine to me.

Best Regards,
Xiao Yang
On 2019/02/22 11:53, Yixin Zhang wrote:
> Signed-off-by: Yixin Zhang<yixin.zhang@intel.com>
> ---
>   testcases/kernel/syscalls/getresgid/.gitignore | 3 +++
>   testcases/kernel/syscalls/getresuid/.gitignore | 3 +++
>   2 files changed, 6 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/getresgid/.gitignore b/testcases/kernel/syscalls/getresgid/.gitignore
> index e8ddb17e8..9309a2b8b 100644
> --- a/testcases/kernel/syscalls/getresgid/.gitignore
> +++ b/testcases/kernel/syscalls/getresgid/.gitignore
> @@ -1,3 +1,6 @@
>   /getresgid01
> +/getresgid01_16
>   /getresgid02
> +/getresgid02_16
>   /getresgid03
> +/getresgid03_16
> diff --git a/testcases/kernel/syscalls/getresuid/.gitignore b/testcases/kernel/syscalls/getresuid/.gitignore
> index 0324bb7c0..387ed1b59 100644
> --- a/testcases/kernel/syscalls/getresuid/.gitignore
> +++ b/testcases/kernel/syscalls/getresuid/.gitignore
> @@ -1,3 +1,6 @@
>   /getresuid01
> +/getresuid01_16
>   /getresuid02
> +/getresuid02_16
>   /getresuid03
> +/getresuid03_16



