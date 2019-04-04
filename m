From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Apr 2019 15:41:39 +0800
Subject: [LTP] [PATCH v2] hugetlb: dynamically change default hugepages
In-Reply-To: <20190404054347.6499-1-xiliang@redhat.com>
References: <20190404054347.6499-1-xiliang@redhat.com>
Message-ID: <CAEemH2fN0r6zA0syYKpDCAjetL1ZtLAq4anoBkokjh3CTYU0mg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Apr 4, 2019 at 1:44 PM Xiao Liang <xiliang@redhat.com> wrote:

> When the system's Hugepagesize is large(eg. 512MiB), the test may
> break as cannot set nr_hugepages to default 128.
>
> This patch continue to use 128 as default hugepages, but it checks
> the memory available and Hugepagesize registered. If default 128 is
> larger than available count, then use the small one.
>
> With this patch:
> tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> hugemmap01.c:99: INFO: max page available count is 54
> mem.c:814: INFO: set nr_hugepages to 54
> hugemmap01.c:73: PASS: call succeeded
> mem.c:814: INFO: set nr_hugepages to 0
>
> Without this patch:
> tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> mem.c:814: INFO: set nr_hugepages to 128
> mem.c:823: BROK: nr_hugepages = 54, but expect 128
> mem.c:814: INFO: set nr_hugepages to 0
>
> [...snip...]
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> index 841f527b7..998bee717 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> @@ -79,8 +79,11 @@ void setup(void)
>         long hpage_size;
>
>         save_nr_hugepages();
> -       if (nr_opt)
> +       if (nr_opt) {
>                 hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
> +       } else {
> +               hugepages = get_available_hugepages();
> +       }
>

There are still have two disadvantages if code change like these above.

1. No ganrantee for each hugepage test to initialize their default
hugepages to 128. Suppose that if a new hugemmap07 is created with
'hugepages == 100' (or anything else but not 128), then this patch is make
no sense to it. What we can do maybe just to create a simple function
get_max_hugepages() in libarary.

2. if someone pass an improper value to hugepages via '-s #big_number#',
that would still break this test as what you hit before.

So a wiser method is probably to compare a decided(no matter setting by ltp
user or using default 128) huagepages with the max avaliable hugepages
which system can provides. If the default value is larger than system
max_hugepages, just use the proper one.

Something I'm thinking maybe like:

In hugemmap01.c:
---------------

void setup(void)
{
...

if (nr_opt)
hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);

if (hugepages > get_max_hugepages()) {
tst_res(TINFO, "The hugepages beyond system available, here "
"reset to 80%% of the max page count %ld",
get_max_hugepages());
hugepages = get_max_hugepages() * 0.8;
}

...
}

In hugetlb libarary:
---------------
long get_max_hugepages(void)
{
return SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
}

More declaration:
I found that some old platforms(e.g. rhel6 i686) has no "MemAvailable:" in
their /proc/meminfo, so I'd take use of "MemFree:" as an replacement. About
to set hugepages only as 80% of the max pages count, is becuase of
memory fragment issue, we cann't always get sequential meory to all reserve
as huage pages, so this is to avoid the nr_hugepages setting failure in
next step.

And what do you think? comment?


>         set_sys_tune("nr_hugepages", hugepages, 1);
>         hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> index 1ea47ebb5..dacbe4918 100644
> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> @@ -56,6 +56,22 @@ void restore_nr_hugepages(void)
>                 set_sys_tune("nr_hugepages", orig_hugepages, 0);
>  }
>
> +long get_available_hugepages(void)
> +{
> +       long page_sz = 0;


maybe declare as hpage_sz ?

> +       long mem_avail = 0;
> +       long max_pages = 0;
>

max_hpages?

> +       long hugepages = 128;
>

Or, these local variable are redundant to the function.


> +
> +       page_sz = SAFE_READ_MEMINFO("Hugepagesize:");
> +       mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
> +       max_pages = mem_avail/page_sz;
> +       tst_res(TINFO, "max page available count is %ld", max_pages);
> +       hugepages=(page_sz*hugepages>mem_avail)?max_pages:hugepages;
>

Spaces are required between the operation expression.

> +
> +       return hugepages;
> +}
> +
>  /*
>   * getipckey() - generates and returns a message key used by the "get"
>   *              calls to create an IPC resource.
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> index 2843f0a8e..48a8d08f3 100644
> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> @@ -58,5 +58,6 @@ char *Hopt;
>  void check_hugepage(void);
>  long save_nr_hugepages(void);
>  void restore_nr_hugepages(void);
> +long get_available_hugepages(void);
>
>  #endif /* hugetlb.h */
> --
> 2.17.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190404/b09364d0/attachment.html>
