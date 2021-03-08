From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Mar 2021 20:45:40 +0800
Subject: [LTP] [PATCH] clock_gettime04: print more info to help debugging
In-Reply-To: <20210308114859.tskerybpt6xtyffa@vireshk-i7>
References: <20210308065329.25824-1-liwang@redhat.com>
 <20210308101732.lzkjql3t7aoscruk@vireshk-i7>
 <CAEemH2d45hFqhB-++xgswYoOh4HGFtFZxXCKGhLhDdt9oXFbfA@mail.gmail.com>
 <20210308111447.h3l2a5yep3n4n5qs@vireshk-i7>
 <CAEemH2eKkGokVY2ZBs=U9eqDrDZVB5qKBVUApULrdL65tfnmLQ@mail.gmail.com>
 <20210308114859.tskerybpt6xtyffa@vireshk-i7>
Message-ID: <CAEemH2cKX4Gh1tO2WL27WrnF7KLFu33rksFf+LWRZz6ZNExAOQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Viresh Kumar <viresh.kumar@linaro.org> wrote:

...
>
> Option 3: Same as option 2 but different formatting
>
> clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between
> successive readings is reasonable for following variants:
>         - vDSO or syscall with libc spec
>         - syscall with old kernel spec
>         - vDSO with old kernel spec
>         - gettimeofday

Any other option here ?
>

I think no.

>
> For the FAIL messages, I think just adding tv->desc is good enough.
>

+1, I prefer to go with Option3 + 'tv->desc for FAIL'.

Would you mind formatting a patch, or I can do that?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210308/45e21897/attachment.htm>
