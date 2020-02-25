From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 25 Feb 2020 16:18:49 +0530
Subject: [LTP] [PATCH V3 00/10] Add new LTP tests related to fsmount
 family of syscalls
In-Reply-To: <CAEemH2dogCkDHtZzwWCx-ahg-CebGYLNyew6F2AkJVPC_yivBA@mail.gmail.com>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <CAEemH2dogCkDHtZzwWCx-ahg-CebGYLNyew6F2AkJVPC_yivBA@mail.gmail.com>
Message-ID: <20200225104849.jqkzsy5kf6a76ypc@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25-02-20, 18:00, Li Wang wrote:
> Hi Viresh,
> 
> These new tests look good, only a few comments/questions below:
> 
> Patch 1/10:
> 1. The git summary should be updated too (someone who push patch can help
> do that:).
> 2. Maybe better to replace the TWARN by TINFO? Since tst_is_mounted() as a
> general function to check if mount success, sometimes we just need the
> return status then do next work(I tend to leave the waring or break operate
> to LTP users:).

Done and sent an update as well.

> Patch 5/10, 9/10:
> May I ask why we use "sync" as the key value in fsconfig()? I ask this
> because it can get rid of the errors we found in XFS test before.

I wasn't able to test it earlier during V2 on my ARM platform and so
just added "foo" there.

This time, I tried running it on my x86 machine and so was able to run
xfs tests and so I figured out what needs to be passed by looking out
the Linux source.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fs_context.c#n41

The first two arrays have the valid options that can be passed.

> Patch 9/10, 10/10:
> I guess that'd be better if we put the 'ismounted = 1' at the behind of
> tst_is_mounted(), do you feel the code sequence looks strange which we set
> 'ismounted' to 1 then do mount checking?

I understand the weirdness you are talking about, but I think the code
does what the right thing to do at this point is.

The question is, what are we supposed to do when move_mount() passes,
but we aren't able to see the mount in /proc/mounts ? I think, we
should call umount() anyway as move_mount() passed. And that's why I
have kept the ismounted = 1, line before the tst_is_mounted() call.

> Ack for the whole patchset v3 (+ follow some modification for above
> comments):
>     Acked-by: Li Wang <liwang@redhat.com>

Thanks for your reviews Li.

-- 
viresh
