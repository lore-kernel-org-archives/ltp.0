From: Christian Amann <camann@suse.com>
Date: Tue, 11 Jun 2019 07:53:44 +0200
Subject: [LTP] [PATCH] syscalls/acct02.c: Fix EMFILE error
In-Reply-To: <1559989633-24711-1-git-send-email-ice_yangxiao@163.com>
References: <1559989633-24711-1-git-send-email-ice_yangxiao@163.com>
Message-ID: <e260a2b5-85cc-2ee6-d38b-0acd19c73347@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Nice catch! Patch makes sense and works.

Kind regards,

Christian


Tested-by: Christian Amann <camann@suse.com>

On 08/06/2019 12:27, Xiao Yang wrote:
> Running acct02 with "-i large number" option may get EMFILE error,
> because 'fd' file descriptor is not closed on each iteration.
>
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> ---
>  testcases/kernel/syscalls/acct/acct02.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index 8a99bb9..f61faf2 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -140,6 +140,8 @@ static void run(void)
>  		tst_res(TPASS, "acct() wrote correct file contents!");
>  	else
>  		tst_res(TFAIL, "acct() wrote incorrect file contents!");
> +
> +	SAFE_CLOSE(fd);
>  }
>  
>  static void setup(void)
