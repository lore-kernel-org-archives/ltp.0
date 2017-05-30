From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 May 2017 15:48:25 +0200
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <555141962.23713496.1496149870415.JavaMail.zimbra@redhat.com>
References: <20170516100759.10355-1-chrubis@suse.cz>
 <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
 <20170516133233.GB2897@rei.lan>
 <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
 <364825081.12577806.1494944124022.JavaMail.zimbra@redhat.com>
 <20170516142924.GE2897@rei.lan>
 <877971945.23275711.1496063572967.JavaMail.zimbra@redhat.com>
 <20170530115032.GB24720@rei.lan>
 <555141962.23713496.1496149870415.JavaMail.zimbra@redhat.com>
Message-ID: <20170530134825.GB25921@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > I'm sporadically running into SIGBUS in this testcase, not sure if it's
> > > because of low memory or something else. Do you see it too?
> > 
> > None so far, but I haven't been running the test on anything else than
> > machines with just two numa nodes so far.
> > 
> > > I wonder if we should replace memset with MAP_POPULATE.
> > 
> > Isn't MAP_POPULATE best effort only?
> 
> It's a readahead for file mappings, not sure about anonymous.

See:

http://www.serverphorums.com/read.php?12,1204538,1204539#msg-1204539

As far as I remember the discussion MAP_POPULATE does not work in low
memory condition and mmap() returns without any error.

> As alternative commit [1] gave me idea to try mlock, and that seems
> to work too. If a node doesn't have enough memory I get ENOMEM.
> 
> diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
> index e1d956dba67e..4c7d5c2c01b0 100644
> --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> @@ -165,9 +165,15 @@ static void alloc_free_huge_on_node(unsigned int node, size_t size)
>                 tst_brk(TBROK | TERRNO, "mbind() failed");
>         }
>  
> -       numa_bitmask_free(bm);
> +       TEST(mlock(mem, size));
> +       if (TEST_RETURN) {
> +               SAFE_MUNMAP(mem, size);
> +               if (TEST_ERRNO == ENOMEM || TEST_ERRNO == EAGAIN)
> +                       tst_brk(TCONF, "Cannot lock huge pages");
> +               tst_brk(TBROK | TTERRNO, "mlock failed");
> +       }
>  
> -       memset(mem, 0, size);
> +       numa_bitmask_free(bm);
>  
>         SAFE_MUNMAP(mem, size);
>  }

LGTM.

-- 
Cyril Hrubis
chrubis@suse.cz
