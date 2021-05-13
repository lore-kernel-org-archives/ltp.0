From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 13 May 2021 11:05:40 +0200
Subject: [LTP] [PATCH] syscalls/mallinfo01: Disable free fastbin blocks
In-Reply-To: <1620896054-26151-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1620896054-26151-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <96c15b88-4251-5794-03e0-12bcc048fa5e@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

On 13. 05. 21 10:54, Yang Xu wrote:
> When using malloc to allocate small space, it will use fastbin block firstly if
> we have free fastbin free blocks, it is more quickly.
> In here, we just test oldblks free chunks, it is the number of ordinary
> (i.e. non-fastbin) free blocks. So use mallopt(M_MXFAST, 0) to disable
> free fastbin block.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/mallinfo/mallinfo01.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo01.c b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
> index 48fce0132..4e10e352e 100644
> --- a/testcases/kernel/syscalls/mallinfo/mallinfo01.c
> +++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
> @@ -64,6 +64,8 @@ static void setup(void)
>  {
>  	if (sizeof(info1.arena) != sizeof(int))
>  		tst_res(TFAIL, "The member of mallinfo struct is not int");
> +	if (mallopt(M_MXFAST, 0) == 0)
> +		tst_res(TFAIL, "mallopt(M_MXFAST, 0) failed");
>  
>  	info1 = mallinfo();
>  	print_mallinfo("Start", &info1);
> 

Sorry but this does not fix the problem. The failing subtest assumes that:
- malloc() will never increase ordblks
- free() will allways increase ordblks

mallinfo01 is failing because both of these assumptions are wrong.
Disabling fastbin block usage will not fix the failure.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
