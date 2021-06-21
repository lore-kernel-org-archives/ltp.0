From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Jun 2021 22:04:44 +0800
Subject: [LTP] [PATCH 1/2] mem: child memory alloc should larger than
 memory.max+memory.swap.max if lite==1
In-Reply-To: <20210621111509.358656-1-liwang@redhat.com>
References: <20210621111509.358656-1-liwang@redhat.com>
Message-ID: <CAEemH2f+eC9kJdy4NcWPfOq8gGTGWfQ=6vaOyYX9-UWQ4+LJuQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Forget to mention, this is debugging/analysis under Cgroup V2. Since
Cgroup V1 has a unified memory+swap counter that tracks a data page
regardless whether it's in-core or swapped out.  But Cgroup V2 tracks
memory and swap in separate, so it splits memory and swap counter.

That's the main reason why oom03 got PASS in Cgroup v1 but FAIL in V2.

So, int ret = alloc_mem(TESTMEM + TESTMEM + MB, testcase);
is tend to make Cgroup V2 happy, but also works for v1, because
it allocates more memory larger than previous.

Or, we could test separately for V1 and V2, and that should not be very
hard.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210621/c254d8ef/attachment.htm>
