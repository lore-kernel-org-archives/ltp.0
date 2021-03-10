From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Mar 2021 21:32:15 +0800
Subject: [LTP] [PATCh v2] clock_gettime04: print more info to help
 debugging
In-Reply-To: <YEjFeGrGsYrr/n3U@pevik>
References: <20210309080028.16284-1-liwang@redhat.com>
 <20210309094525.4ggmppfpvavsvjzl@vireshk-i7>
 <YEdhgvXg/mYkppz6@pevik> <20210309115623.ze5c7li7vuf65gvg@vireshk-i7>
 <CAEemH2esvVfy0YeCL2nXgj441XeBY7F+Y8MVEJ31nKRNPvjC+g@mail.gmail.com>
 <20210310084304.d6b626clzj5rafvh@vireshk-i7> <YEibPvXnSpGceN/e@pevik>
 <CAEemH2c0LQPc1dY=ErruKHOGU3OXeKXQgh3VMaYveZN+qVnCKA@mail.gmail.com>
 <YEjFeGrGsYrr/n3U@pevik>
Message-ID: <CAEemH2f2pSseGq5zakd7EVieKSCOOPHCSh+ZCFqppfWF_bA41A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel <pvorel@suse.cz> wrote:

...
>
> > So, would you mind if I merge this V2 patch first?
>
> > (Since we're encountering a sporadical(we can't reproduce it manually)
> > failure. Hope this can print more useful info to locate the issue.)
>
> Although I'd slightly prefer if it printed everything once in the setup,
> it's
> not important and we've already spent quite a lot of time with it, so sure,
> go ahead :)
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>

Thank you so much, Petr!  Merged.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210310/55890a8b/attachment.htm>
