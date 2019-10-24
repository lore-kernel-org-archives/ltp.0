From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Oct 2019 09:49:08 +0200
Subject: [LTP] [PATCH] lsmod01.sh: retry test couple times to lower
 false positives
In-Reply-To: <CAEemH2dGc-y4yfduw4N=ecwRydXqmEGmG8-eKBxmAxCxL2iEHQ@mail.gmail.com>
References: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
 <20191023121901.GA25868@dell5510>
 <463301336.8732968.1571837306503.JavaMail.zimbra@redhat.com>
 <20191023182845.GA2863@x230>
 <CAEemH2dGc-y4yfduw4N=ecwRydXqmEGmG8-eKBxmAxCxL2iEHQ@mail.gmail.com>
Message-ID: <20191024074907.GA10174@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Jan,

...
> > > I wonder if we need to TBROK in TST_RETRY_FUNC(). We could just return
> > > what the FUNC returns and let the test decide.
> > > TST_RETRY_FUNC_BRK() could be a wrapper that TBROKs on timeout.
> > That could work (apart from the fact it diverges the functionality from C).
> > + there could be the third one, which TPASS/TFAIL (instead of
> > nothing/TBROK).

> > But this should be based on TST_RETRY_FN_EXP_BACKOFF (TST_RETRY_FUNC is
> > reusing
> > TST_RETRY_FN_EXP_BACKOFF) + add also TST_RETRY_FUNC wrappers.

> > Do we need similar functionality in C?


> Not sure, but we could collect the requirement for the EXP_BACKOFF series
> macro. I'm also thinking about to extend the functionality for more
> situations.

> e.g http://lists.linux.it/pipermail/ltp/2019-October/013896.html
+1 for @INFI - 1: retry infinitely, 0: retry in limit times

Combining with TPASS/TFAIL vs. nothing/TBROK it might make sense to either use
enum flags for C implementation, which would save one parameter and allow
further extension. Shell could have getopts instead of more parameters.
And it's a question whether cover all variants with wrappers like
TST_RETRY_FUNC* or not.

Kind regards,
Petr
