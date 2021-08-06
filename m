From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 6 Aug 2021 01:50:16 +0000
Subject: [LTP] [PATCH v1 1/3] libs/libnewipc: Alter get_used_queues api
In-Reply-To: <CAEemH2cf2b+xhrfD+BGVhZ59T4wOm=N+KxhYdVKhhQ9aF441YQ@mail.gmail.com>
References: <1628135323-3722-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2cf2b+xhrfD+BGVhZ59T4wOm=N+KxhYdVKhhQ9aF441YQ@mail.gmail.com>
Message-ID: <610C9567.8050302@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi Xu,
>
> I have just gone through all of the discussions on this topic
> and am feeling this method is not quite perfect but currently
> I have no better idea.
I guess a better idea should be using .sysvipc flag. But here, we  use 
the easiest way to slove this problem. In the future, we can add this 
feature.
>
> So, I agree to apply the method and see how it performs in
> real test executing.
Thanks. Let's listen whether have user complains about these two cases
after this fix.
>
> Reviewed-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>
Thanks for your review. I have pushed this patchset.

Best Regards
Yang Xu
>
> --
> Regards,
> Li Wang
