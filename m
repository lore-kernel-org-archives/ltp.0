From: Li Wang <liwang@redhat.com>
Date: Thu, 5 Sep 2019 18:29:58 +0800
Subject: [LTP] [PATCH] madvise09:Change PAGES size to the value more
 than 32
In-Reply-To: <18fd25c6-857f-e049-8c8d-9640f4deba68@oracle.com>
References: <1567576823-10080-1-git-send-email-shuang.qiu@oracle.com>
 <CAEemH2fiJkau0A3yQH+nHVPXMwtTzyV3_weTQRniZFR+EJqN_g@mail.gmail.com>
 <18fd25c6-857f-e049-8c8d-9640f4deba68@oracle.com>
Message-ID: <CAEemH2eLnTQ4obrpSOzoBE4OQ3x47DLNZdAGyE91CnwQ7TOVsw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 5, 2019 at 6:02 PM Shuang Qiu <shuang.qiu@oracle.com> wrote:
>
> On 09/05/2019 04:29 PM, Li Wang wrote:
> > On Wed, Sep 4, 2019 at 2:01 PM <shuang.qiu@oracle.com> wrote:
> >> From: Shuang Qiu <shuang.qiu@oracle.com>
> >>
> >> In upstream patch 1a61ab (mm: memcontrol: replace zone summing with lruvec_page_state()),
> >> it modify the lruvec state in batch,equal and less than 32 MADV_FREE pages will not trigger
> >> the account of lruvec_stat,and will not be free in memory pressure either.
> >> So the testcase may fail with:
> >> ...
> >> madvise09.c:219: INFO: Memory hungry child 6178 started, try 10
> >> madvise09.c:254: INFO: Memory map: pppppppppppppppppppppppppppppppp
> >> madvise09.c:259: FAIL: No MADV_FREE page was freed on low memory
> >> ...
> >> Change the PAGES to the value more than 32 can fix such issue.
> >>
> >> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> >> ---
> >>   testcases/kernel/syscalls/madvise/madvise09.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
> >> index 01075f6..3759053 100644
> >> --- a/testcases/kernel/syscalls/madvise/madvise09.c
> >> +++ b/testcases/kernel/syscalls/madvise/madvise09.c
> >> @@ -57,7 +57,7 @@ static int sleep_between_faults;
> >>
> >>   static int swap_accounting_enabled;
> >>
> >> -#define PAGES 32
> >> +#define PAGES 64
> > I'm not sure why 64 pages is a proper value? Can you explain more?
> I think any value which larger than 32 is ok.
> So I tested 64 and works fine.

I just tried with '42' randomly, but it doesn't work. I guess that
might have a waterline to trigger this memory page reclaiming.

I looked at the code calling path, it seems the 'sc->nr_reclaimed' is
the key value to control that, but still not 100% sure, I will keep
debugging it for a while.

try_to_free_mem_cgroup_pages
  do_try_to_free_pages
    shrink_zone
      shrink_node
        shrink_node_memcg
          get_scan_count
            lruvec_lru_size
              lruvec_page_state

-- 
Regards,
Li Wang
