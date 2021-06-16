From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Jun 2021 15:48:38 +0800
Subject: [LTP] [PATCH v4 1/3] Add Coccinelle helper scripts for reference
In-Reply-To: <CAEemH2fgVnh4w9Vgezvu7-YmLXLJiKEkLyz5puTjgo=9=neidg@mail.gmail.com>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <CAEemH2fgVnh4w9Vgezvu7-YmLXLJiKEkLyz5puTjgo=9=neidg@mail.gmail.com>
Message-ID: <CAEemH2eq-ZpjD-zw_NND76em9CEdQE-tLE_WFaPAMqN+sjpmyg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> wrote:

> > +for spatch_file in $*; do
> > +    case $spatch_file in
> > +       libltp-test-macro)
> > +           libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro.cocci;;
> > +       libltp-test-macro-vars)
> > +           libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro-vars.cocci \
> > +                         --ignore lib/tst_test.c;;
> > +       *)
> > +           tests_spatch --sp-file scripts/coccinelle/$spatch_file.cocci;;
>
> Why here use the coccinelle/ path and add suffix with the spatch_file?

Ah, it seems to preserve for more self define spatch files, I misread
the usage just now.
Sorry for making noise, I'm definitely a newbie on coccinelle.

-- 
Regards,
Li Wang

