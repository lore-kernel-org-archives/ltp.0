From: Li Wang <liwang@redhat.com>
Date: Thu, 5 Sep 2019 16:29:44 +0800
Subject: [LTP] [PATCH] madvise09:Change PAGES size to the value more
 than 32
In-Reply-To: <1567576823-10080-1-git-send-email-shuang.qiu@oracle.com>
References: <1567576823-10080-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <CAEemH2fiJkau0A3yQH+nHVPXMwtTzyV3_weTQRniZFR+EJqN_g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 4, 2019 at 2:01 PM <shuang.qiu@oracle.com> wrote:
>
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> In upstream patch 1a61ab (mm: memcontrol: replace zone summing with lruvec_page_state()),
> it modify the lruvec state in batch,equal and less than 32 MADV_FREE pages will not trigger
> the account of lruvec_stat,and will not be free in memory pressure either.
> So the testcase may fail with:
> ...
> madvise09.c:219: INFO: Memory hungry child 6178 started, try 10
> madvise09.c:254: INFO: Memory map: pppppppppppppppppppppppppppppppp
> madvise09.c:259: FAIL: No MADV_FREE page was freed on low memory
> ...
> Change the PAGES to the value more than 32 can fix such issue.
>
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>  testcases/kernel/syscalls/madvise/madvise09.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
> index 01075f6..3759053 100644
> --- a/testcases/kernel/syscalls/madvise/madvise09.c
> +++ b/testcases/kernel/syscalls/madvise/madvise09.c
> @@ -57,7 +57,7 @@ static int sleep_between_faults;
>
>  static int swap_accounting_enabled;
>
> -#define PAGES 32
> +#define PAGES 64

I'm not sure why 64 pages is a proper value? Can you explain more?

-- 
Regards,
Li Wang
