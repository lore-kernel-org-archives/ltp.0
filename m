From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 23 Mar 2020 17:52:37 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
 <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
Message-ID: <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li


> Hi Petr,
> 
> On Fri, Mar 20, 2020 at 9:50 PM Petr Vorel <pvorel@suse.cz
> <mailto:pvorel@suse.cz>> wrote:
> 
>     Signed-off-by: Petr Vorel <pvorel@suse.cz <mailto:pvorel@suse.cz>>
>     ---
>      ?testcases/kernel/syscalls/add_key/add_key05.c? ?| 15 ++-------------
>      ?testcases/kernel/syscalls/quotactl/quotactl01.c | 14 ++------------
>      ?testcases/kernel/syscalls/quotactl/quotactl06.c | 12 +-----------
> 
> 
> Apart from the three, do you consider converting to SAFE_RUNCMD for the 
> rest testcases?
> (it seems not too much work remaining since only a few test case uses 
> tst_run_cmd)
At the beginning, I have the same idea. But after seeing code, I think 
we should not because these cases have many sub tests(only few test 
deponds on the result of the cmd execution.
> 
> kernel/syscalls/setpriority/setpriority01.c
One year ago has a commit db82b596(setpriority01: Skip only PRIO_USER 
when unable to add test user). It only affects PRIO_USER sub test.
> kernel/syscalls/copy_file_range/copy_file_range02.c
only affect test6 and test7
  6) Try to copy contents to a file chattred with +i
  *    flag -> EPERM
  * 7) Try to copy contents to a swapfile ->ETXTBSY


Best Regards
Yang Xu

> ...
> 
> 
> -- 
> Regards,
> Li Wang
> 
> 


