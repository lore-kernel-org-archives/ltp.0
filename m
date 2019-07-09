From: Sandeep Patil <sspatil@android.com>
Date: Mon, 8 Jul 2019 21:14:44 -0700
Subject: [LTP] [PATCH ltp] syscalls/stat: add stat02{,
 _64} into .gitignore
In-Reply-To: <20190709021545.23772-1-yixin.zhang@intel.com>
References: <20190709021545.23772-1-yixin.zhang@intel.com>
Message-ID: <20190709041444.GA102801@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 09, 2019 at 10:15:45AM +0800, Yixin Zhang wrote:
> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  testcases/kernel/syscalls/stat/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
> index 4a8f61858..fa0a4ce9f 100644
> --- a/testcases/kernel/syscalls/stat/.gitignore
> +++ b/testcases/kernel/syscalls/stat/.gitignore
> @@ -1,4 +1,6 @@
>  /stat01
>  /stat01_64
> +/stat02
> +/stat02_64
>  /stat03
>  /stat03_64

I probably should have done this when stat02 was added.
Thanks for fixing.

Acked-by: Sandeep Patil <sspatil@android.com>
