From: Li Wang <liwang@redhat.com>
Date: Fri, 19 May 2017 16:32:01 +0800
Subject: [LTP] [PATCH v3 3/3] ltp/numa: use string to describe operation
In-Reply-To: <20170519082519.9471-3-liwang@redhat.com>
References: <20170519082519.9471-1-liwang@redhat.com>
 <20170519082519.9471-3-liwang@redhat.com>
Message-ID: <CAEemH2fcV1Jv4uLQcJOZ0w-hhBgqCsduk6vA2GFZs3tFOnJ8iA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 19, 2017 at 4:25 PM, Li Wang <liwang@redhat.com> wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
> index 97f3008..fef8277 100644
> --- a/testcases/kernel/numa/support_numa.c
> +++ b/testcases/kernel/numa/support_numa.c
> @@ -50,10 +50,10 @@
>  static void help(void)
>  {
>         printf("Input:  Describe input arguments to this program\n");
> -       printf("        argv[1] == 1 then allocate 1MB of memory\n");
> -       printf("        argv[1] == 2 then allocate 1MB of share memory\n");
> -       printf("        argv[1] == 3 then allocate 1HUGE PAGE SIZE of memory\n");
> -       printf("        argv[1] == 4 then pause the program to catch sigint\n");
> +       printf("        argv[1] == "alloc_1MB" then allocate 1MB of memory\n");
> +       printf("        argv[1] == "alloc_1MB_shared" then allocate 1MB of share memory\n");
> +       printf("        argv[1] == "alloc_1huge_page" then allocate 1HUGE PAGE SIZE of memory\n");
> +       printf("        argv[1] == "pause" then pause the program to catch sigint\n");
>         printf("Exit:   On failure - Exits with non-zero value\n");
>         printf("        On success - exits with 0 exit value\n");
>
> @@ -97,8 +97,7 @@ int main(int argc, char *argv[])
>                 exit(1);
>         }

Oops, this one has little syntax error.

please apply the latest:

  [PATCH v3 3/3] ltp/numa: use string to describe operation





-- 
Regards,
Li Wang
Email: liwang@redhat.com
