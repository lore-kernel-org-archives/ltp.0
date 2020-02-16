From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 16 Feb 2020 14:23:45 +0100
Subject: [LTP] [PATCH v2 1/3] tst_umount: Fail immediately when errno !=
 EBUSY
In-Reply-To: <CAEemH2fvK+d3V8W=sR4YtZpwmE=jq5TmS-g1TNTu+UbW2oU8CQ@mail.gmail.com>
References: <20200210124043.14425-1-pvorel@suse.cz>
 <CAEemH2fvK+d3V8W=sR4YtZpwmE=jq5TmS-g1TNTu+UbW2oU8CQ@mail.gmail.com>
Message-ID: <20200216132345.GA2718765@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Acked-by: Li Wang <liwang@redhat.com>

> Since we have guaranteed there is no other error besides EBUSY, maybe we
> could cancel the 'err == EBUSY' in the next if() sentences.
> Otherweise patch 1/3, 2/3 looks good.

> if (i == 0 && err == EBUSY) {
>     ...
> }
+1 (fixed in prepared code to be merged).
Thanks for your review.

Kind regards,
Petr
