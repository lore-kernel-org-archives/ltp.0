From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jan 2016 17:14:52 +0800
Subject: [LTP] [PATCH] lib/mem.c: exit from test_transparent_hugepage()
 if shortage of memory
In-Reply-To: <1453790132-2360-1-git-send-email-liwang@redhat.com>
References: <1453790132-2360-1-git-send-email-liwang@redhat.com>
Message-ID: <CAEemH2fJQh_g2cTtEL7mHEvmy1aqnucysgy7bkvbJCX2KE+wTA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

seems this patch haven't totally fix the issue. after applying it, thp05.c
still failed on 2 numa  x86_64 system occasionally.

then I looked into the detail and found that the key point is the parameter
which we set to the process is probably too large for some testing systems.

I'm trying to make thp05.c get 'nr_thps' values dynamically, but currently
I don't have any goodidea. :(


------
$ cat ltp/runtest/mm |grep thp05
thp05_1 thp05
thp05_2 thp05 -n 10 -N 20
thp05_3 thp05 -n 1 -N 300    <-------

-------
# cat thp05.c
...
option_t thp_options[] = {
    {"n:", &opt_nr_children, &opt_nr_children_str},
    {"N:", &opt_nr_thps, &opt_nr_thps_str},
    {NULL, NULL, NULL}
};

static int pre_thp_scan_sleep_millisecs;
static int pre_thp_alloc_sleep_millisecs;
static char pre_thp_enabled[BUFSIZ];

int main(int argc, char *argv[])
{
    int lc;
    char *msg;
    int nr_children = 2, nr_thps = 64;   <-------

    tst_parse_opts(argc, argv, thp_options, thp_usage);

    check_thp_options(&nr_children, &nr_thps);


----
cmdline="thp05 -n 1 -N 300"
contacts=""
analysis=exit
<<<test_output>>>
thp05       0  TINFO  :  Start to test transparent hugepage...
thp05       0  TINFO  :  There are 1 children allocating 300 transparent
hugepages
thp05       0  TINFO  :  THP on MPOL_BIND mempolicy...
thp05       0  TINFO  :  The current MemFree is 8286MB
thp05       0  TINFO  :  child[61793] stop here
thp05       0  TINFO  :  Start to test transparent hugepage...
thp05       0  TINFO  :  There are 1 children allocating 300 transparent
hugepages
thp05       0  TINFO  :  THP on MPOL_BIND mempolicy...
thp05       0  TINFO  :  The current MemFree is 8286MB
thp05       0  TINFO  :  Stop all children...
thp05       0  TINFO  :  Start to scan all transparent hugepages...
thp05       0  TINFO  :  khugepaged daemon takes 15s to scan all thp pages
thp05       0  TINFO  :  Start to verify transparent hugepage size...
thp05       1  TFAIL  :  child[61792] got 561152KB thps - expect 614400KB
thps
thp05       0  TINFO  :  Wake up all children...
thp05       0  TINFO  :  THP on MPOL_INTERLEAVE mempolicy...
thp05       0  TINFO  :  The mempolicy need more than 2 numa nodes
thp05       0  TINFO  :  The current MemFree is 8287MB
thp05       0  TINFO  :  child[61914] stop here
thp05       0  TINFO  :  Start to test transparent hugepage...
thp05       0  TINFO  :  There are 1 children allocating 300 transparent
hugepages
thp05       0  TINFO  :  THP on MPOL_BIND mempolicy...
thp05       0  TINFO  :  The current MemFree is 8286MB
thp05       0  TINFO  :  Stop all children...
thp05       0  TINFO  :  Start to scan all transparent hugepages...
thp05       0  TINFO  :  khugepaged daemon takes 15s to scan all thp pages
thp05       0  TINFO  :  Start to verify transparent hugepage size...
thp05       1  TFAIL  :  child[61792] got 561152KB thps - expect 614400KB
thps
thp05       0  TINFO  :  Wake up all children...
thp05       0  TINFO  :  THP on MPOL_INTERLEAVE mempolicy...
thp05       0  TINFO  :  The mempolicy need more than 2 numa nodes
thp05       0  TINFO  :  The current MemFree is 8287MB
thp05       0  TINFO  :  Stop all children...
thp05       0  TINFO  :  Start to scan all transparent hugepages...
thp05       0  TINFO  :  khugepaged daemon takes 10s to scan all thp pages
thp05       0  TINFO  :  Start to verify transparent hugepage size...
thp05       2  TFAIL  :  child[61792] got 612352KB thps - expect 614400KB
thps
thp05       0  TINFO  :  Wake up all children...
thp05       0  TINFO  :  THP on MPOL_PREFERRED mempolicy...
thp05       0  TINFO  :  The mempolicy need more than 2 numa nodes
thp05       0  TINFO  :  The current MemFree is 8292MB
thp05       0  TINFO  :  child[62004] stop here
thp05       0  TINFO  :  Start to test transparent hugepage...
thp05       0  TINFO  :  There are 1 children allocating 300 transparent
hugepages
thp05       0  TINFO  :  THP on MPOL_BIND mempolicy...
thp05       0  TINFO  :  The current MemFree is 8286MB
thp05       0  TINFO  :  Stop all children...
thp05       0  TINFO  :  Start to scan all transparent hugepages...
thp05       0  TINFO  :  khugepaged daemon takes 15s to scan all thp pages
thp05       0  TINFO  :  Start to verify transparent hugepage size...
thp05       1  TFAIL  :  child[61792] got 561152KB thps - expect 614400KB
thps
thp05       0  TINFO  :  Wake up all children...
thp05       0  TINFO  :  THP on MPOL_INTERLEAVE mempolicy...
thp05       0  TINFO  :  The mempolicy need more than 2 numa nodes
thp05       0  TINFO  :  The current MemFree is 8287MB
thp05       0  TINFO  :  Stop all children...
thp05       0  TINFO  :  Start to scan all transparent hugepages...
thp05       0  TINFO  :  khugepaged daemon takes 10s to scan all thp pages
thp05       0  TINFO  :  Start to verify transparent hugepage size...
thp05       2  TFAIL  :  child[61792] got 612352KB thps - expect 614400KB
thps
thp05       0  TINFO  :  Wake up all children...
thp05       0  TINFO  :  THP on MPOL_PREFERRED mempolicy...
thp05       0  TINFO  :  The mempolicy need more than 2 numa nodes
thp05       0  TINFO  :  The current MemFree is 8292MB
thp05       0  TINFO  :  Stop all children...
thp05       0  TINFO  :  Start to scan all transparent hugepages...
thp05       0  TINFO  :  khugepaged daemon takes 10s to scan all thp pages
thp05       0  TINFO  :  Start to verify transparent hugepage size...
thp05       3  TFAIL  :  child[61792] got 610304KB thps - expect 614400KB
thps
thp05       0  TINFO  :  Wake up all children...


On Tue, Jan 26, 2016 at 2:35 PM, Li Wang <liwang@redhat.com> wrote:

> Sometime thp05.c fails like:
> ---
> thp05       0  TINFO  :  Stop all children...
> thp05       0  TINFO  :  Start to scan all transparent hugepages...
> thp05       0  TINFO  :  khugepaged daemon takes 10s to scan all thp pages
> thp05       0  TINFO  :  Start to verify transparent hugepage size...
> thp05       1  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect
> 40960KB thps
> thp05       2  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect
> 40960KB thps
> thp05       3  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect
> 40960KB thps
> thp05       4  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect
> 40960KB thps
> ---
>
> Since the system has done much testing work so far as it comes here, it is
> very easy to
> hit the fails if the memory is fragmented, the following tests should
> better be skiped
> while system dose not have enough memory for THP testing.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/lib/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/mem/lib/mem.c
> b/testcases/kernel/mem/lib/mem.c
> index cee4e91..6715c35 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -773,7 +773,7 @@ void test_transparent_hugepage(int nr_children, int
> nr_thps,
>         memfree = read_meminfo("MemFree:");
>         tst_resm(TINFO, "The current MemFree is %luMB", memfree / KB);
>         if (memfree < MB)
> -               tst_resm(TCONF, "Not enough memory for testing");
> +               tst_brkm(TCONF, NULL, "Not enough memory for testing");
>
>         hugepagesize = read_meminfo("Hugepagesize:");
>         tst_resm(TINFO, "The current Hugepagesize is %luMB", hugepagesize
> / KB);
> --
> 1.8.3.1
>
>
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160126/e7f90c47/attachment-0001.html>
