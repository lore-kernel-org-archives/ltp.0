From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Sep 2020 18:12:09 +0800
Subject: [LTP] [PATCH 2/2] mmap18: Increase minimal stack mapping to 8KB
In-Reply-To: <20200924144246.12750-2-mdoucha@suse.cz>
References: <20200924144246.12750-1-mdoucha@suse.cz>
 <20200924144246.12750-2-mdoucha@suse.cz>
Message-ID: <CAEemH2cmi+sL5CkBT--0Mz+Kg9XVvcnxL7EwXdyxOHW9hdLeEw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 24, 2020 at 10:43 PM Martin Doucha <mdoucha@suse.cz> wrote:

> The first testcase keeps segfaulting on older kernels with only 4KB initial
> stack mapping
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>
> Note: Increasing initial stack size to 8KB fixes the segfaults but I'm not
> entirely sure whether we shouldn't use PTHREAD_STACK_MIN as the minimal
> size
> instead. Pthread man page isn't entirely clear whether PTHREAD_STACK_MIN
> is
> the minimal value for stack size after it grows to the limit, or the
> minimal
> size of the initial stack mapping (before it starts growing).
>

I slightly think the latter, which means PTHREAD_STACK_MIN is the minimal
size of the initial stack mapping. So maybe better to use the
PTHREAD_STACK_MIN
as mmaped_size, we even don't need to have a MAX() there.


>
> On x86_64, PTHREAD_STACK_MIN is 4 pages (16KB). On PPC64, it's 2 pages
> (128KB).


>  testcases/kernel/syscalls/mmap/mmap18.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap18.c
> b/testcases/kernel/syscalls/mmap/mmap18.c
> index 966bf673e..8b149fb93 100644
> --- a/testcases/kernel/syscalls/mmap/mmap18.c
> +++ b/testcases/kernel/syscalls/mmap/mmap18.c
> @@ -201,10 +201,11 @@ static void grow_stack_fail(size_t stack_size,
> size_t mapped_size)
>  static void run_test(void)
>  {
>         size_t stack_size = 8 * PTHREAD_STACK_MIN;
> +       size_t minsize = MAX(page_size, 8192);
>
> -       grow_stack_success(stack_size, page_size);
> +       grow_stack_success(stack_size, minsize);
>         grow_stack_success(stack_size, stack_size/2);
> -       grow_stack_fail(stack_size, page_size);
> +       grow_stack_fail(stack_size, minsize);
>         grow_stack_fail(stack_size, stack_size/2);
>  }
>
> --
> 2.28.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200925/9be3da58/attachment.htm>
