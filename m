From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Fri, 10 Aug 2018 15:04:51 +0800
Subject: [LTP] [PATCH] ltp: replace the retry loops by new exponential
 backoff macro
In-Reply-To: <CAEemH2cHh94s_DSwN73GoTv0zOeS3xK0AsOFpq6iNKggvzG1Lw@mail.gmail.com>
References: <20180517062943.13178-1-liwang@redhat.com>
 <20180612155652.mhu2sycbwd5gbu5e@dell5510>
 <dbeb13e1-adae-2231-6936-567098ec8867@oracle.com>
 <CAEemH2ebjH3BJwXEhmKgkL+0+im-0eQhrCQFczU3WLKHi9m1dg@mail.gmail.com>
 <5e595b10-1dd4-3866-c284-1ec91b079d1f@oracle.com>
 <CAEemH2cHh94s_DSwN73GoTv0zOeS3xK0AsOFpq6iNKggvzG1Lw@mail.gmail.com>
Message-ID: <59a439e7-74a4-76e7-8372-0579d746f604@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 08/08/2018 03:35 PM, Li Wang wrote:
>
> Shuang Qiu <shuang.qiu@oracle.com <mailto:shuang.qiu@oracle.com>> wrote:
>
>     Oh,yes,Xiao's patch is related to it.
>     ===cut===
>     if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
>     ===
>     But looks like the missing symlink issue is not only related with
>     kernel version or loop devices,but sometimes related with mkswap
>     version or udev rules.
>     The testcase sometimes will also fail with new version of kernels.
>
>
> Hmm, if that is true. We may need to rewrite the judgement according 
> the real situation.
>
> check_symlink_support()
> {
> if support symlink
>         return 0
> else
>         return 1
> }
>
> if ! check_symlink_support ; then
>         tst_res TINFO "Waiting for $dev_file to appear"
>         tst_sleep 100ms
> else
>         TST_RETRY_FUNC "check_for_file $dev_file" 0
> fi
>
> Or, any better idea?
Yes,this is a great solution.
But it is really hard to define the support symlink situation for 
different releases and userspace versions.
The simplest way is revert the patch for mkswap01

Thanks
Shuang
>
> -- 
> Regards,
> Li Wang


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180810/78bf866a/attachment.html>
