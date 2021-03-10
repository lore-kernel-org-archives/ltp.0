From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Mar 2021 20:12:32 +0800
Subject: [LTP] [PATCh v2] clock_gettime04: print more info to help
 debugging
In-Reply-To: <YEibPvXnSpGceN/e@pevik>
References: <20210309080028.16284-1-liwang@redhat.com>
 <20210309094525.4ggmppfpvavsvjzl@vireshk-i7>
 <YEdhgvXg/mYkppz6@pevik> <20210309115623.ze5c7li7vuf65gvg@vireshk-i7>
 <CAEemH2esvVfy0YeCL2nXgj441XeBY7F+Y8MVEJ31nKRNPvjC+g@mail.gmail.com>
 <20210310084304.d6b626clzj5rafvh@vireshk-i7> <YEibPvXnSpGceN/e@pevik>
Message-ID: <CAEemH2c0LQPc1dY=ErruKHOGU3OXeKXQgh3VMaYveZN+qVnCKA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

...
>
> > I think it would be worth keeping it simple then and just print all
> > variants only once from setup(). Leave the special case of REALTIME
> > clock.
> +1.
>
> From a long term, I'd like some easy solution when printing would be
> handled in
> the library. Some time ago I posted a patch which turned .test_variants
> from int
> into array of string description [1]. Cyril didn't see much value at it and
>

I look back at patch[1], IMHO, splitting the test variant struct is not a
good idea.
I'd rather go print variants[i].desc in the library directly but not split
it to make
struct here and there :).


> didn't like that it introduced more ifdefs (together with Viresh).
> But now we have docparse, could we reconsider this approach? Maybe we
> could keep
> .test_variants and introduce .test_variants_desc for tests which are
> simple enough.
> Or, maybe there is a cleaner solution for clock_adjtime0* tests which I
> don't
> see.
>

Maybe there is.  We can have more time to thinking/discussing this.

So, would you mind if I merge this V2 patch first?

(Since we're encountering a sporadical(we can't reproduce it manually)
failure. Hope this can print more useful info to locate the issue.)


>
> Kind regards,
> Petr
>
> [1]
> https://patchwork.ozlabs.org/project/ltp/patch/20200519120725.25750-1-pvorel@suse.cz/
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210310/57019987/attachment.htm>
