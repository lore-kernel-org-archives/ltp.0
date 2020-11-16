From: Li Wang <liwang@redhat.com>
Date: Mon, 16 Nov 2020 16:41:02 +0800
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <20201113202828.GA2229@pevik>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
 <20201113202828.GA2229@pevik>
Message-ID: <CAEemH2fXD-gFF_7PogAPB1txUrgQmmzeK8p=MaMSn1zam0YeVg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Nov 14, 2020 at 4:28 AM Petr Vorel <pvorel@suse.cz> wrote:

> > In order to simplify common return value checks.
>
> Great improvement, thanks!
>
> The only concern I have is for tests which does not end 0
> as it's not obvious from the output (without looking into the test source)
> that everything it's working, but not a big deal.
>

+1
I agree to add an expected value check for TEST_PASS(), e.g

#define TEST_PASS(SCALL, EXPECTED, ...)


> FYI I plan to send a patchset which runs tests in lib/newlib_tests/.
> First I thought simple check for 0 would be ok, but with non-zero results
> it
> might be good to not only check expected return value but maybe for whole
> output (the same approach we have unfinished in patchset from Christian
> Lanig).
>
> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201116/957aa64f/attachment.htm>
