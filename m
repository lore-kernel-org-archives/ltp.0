From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Aug 2018 15:35:37 +0800
Subject: [LTP] [PATCH] ltp: replace the retry loops by new exponential
 backoff macro
In-Reply-To: <5e595b10-1dd4-3866-c284-1ec91b079d1f@oracle.com>
References: <20180517062943.13178-1-liwang@redhat.com>
 <20180612155652.mhu2sycbwd5gbu5e@dell5510>
 <dbeb13e1-adae-2231-6936-567098ec8867@oracle.com>
 <CAEemH2ebjH3BJwXEhmKgkL+0+im-0eQhrCQFczU3WLKHi9m1dg@mail.gmail.com>
 <5e595b10-1dd4-3866-c284-1ec91b079d1f@oracle.com>
Message-ID: <CAEemH2cHh94s_DSwN73GoTv0zOeS3xK0AsOFpq6iNKggvzG1Lw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Shuang Qiu <shuang.qiu@oracle.com> wrote:

> Oh,yes,Xiao's patch is related to it.
> ===cut===
> if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
> ===
> But looks like the missing symlink issue is not only related with kernel
> version or loop devices,but sometimes related with mkswap version or udev
> rules.
> The testcase sometimes will also fail with new version of kernels.
>

Hmm, if that is true. We may need to rewrite the judgement according the
real situation.

check_symlink_support()
{
        if support symlink
                return 0
        else
                return 1
}

if ! check_symlink_support ; then
        tst_res TINFO "Waiting for $dev_file to appear"
        tst_sleep 100ms
else
        TST_RETRY_FUNC "check_for_file $dev_file" 0
fi

Or, any better idea?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180808/52f395c7/attachment.html>
