From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 5 Sep 2017 07:52:17 +0530
Subject: [LTP] [PATCH 0/2] mem: ksm: race condition fixes
In-Reply-To: <20170825083427.25745-1-aarcange@redhat.com>
References: <20170825083427.25745-1-aarcange@redhat.com>
Message-ID: <CACi5LpNv0-ajX5k99gqXnVO6tKF5ceFqSHJEXxaP7nUFN1jVYQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Andrea,

On Fri, Aug 25, 2017 at 2:04 PM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> Hello,
>
> some false positives triggered the LTP ksm?? tests on some arch with
> slower CPU. The volatile pages weren't zero during the checks, as they
> should have been.
>
> Volatile pages left around means there are orphaned rmap_items, that
> can happen if the KSM scans aren't complete.
>
> I believe the problem is with the waiting that wasn't waiting two full
> passes, but it only waited until the values stopped changing after 10
> seconds of wait time. Plus the ksm?? children were still running by
> the time the wait time started.
>
> The first patch takes care of waiting two scans (more efficiently,
> with a polling of 1 sec). That change then exposes the problem with
> the ksm?? children not being stopped before we start waiting, and the
> second patch fixes that.
>
> After applying these two fixes, we had hundred of successful runs on
> the same system that showed volatile pages not zero, without any
> further failures.
>
> Try #2, first submit bounced because I thought I subscribed, but I was
> still one click away.
>
> Thanks,
> Andrea
>
> Andrea Arcangeli (2):
>   mem: ksm: fix volatile page false positive
>   mem: ksm: fixes for race conditions
>
>  testcases/kernel/mem/lib/mem.c | 93 ++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 44 deletions(-)

Thanks for the patchset. I have tested the same on both  x86_64 and
aarch64 host machine and also reviewed the same:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
