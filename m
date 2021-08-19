From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Aug 2021 08:09:06 +0200
Subject: [LTP] [PATCH 1/3] tst_test.sh: Simplify tst_cmd_available()
In-Reply-To: <CAEemH2es_CzWugkyOworVLFe+ZbtFxpYXK5HjdE_g_w4wHvzVQ@mail.gmail.com>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-2-pvorel@suse.cz>
 <7ac7a1d6-2d97-f8f5-8d60-040eb0753681@jv-coder.de>
 <YRzVpQT1zYOvxlWe@pevik>
 <CAEemH2es_CzWugkyOworVLFe+ZbtFxpYXK5HjdE_g_w4wHvzVQ@mail.gmail.com>
Message-ID: <YR31gii1hVnYNbX5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> Another reason, I guess, is `command -v ` looks to match the function name
> more:).

> But it depends on you, I'm OK with any of them.

Sure, no problem to keep "command -v".
Thanks for your review.

Kind regards,
Petr

> Reviewed-by: Li Wang <liwang@redhat.com>
