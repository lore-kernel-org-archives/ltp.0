From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 Oct 2019 18:43:48 +0200
Subject: [LTP] [RFC PATCH 2/2] doc: Add user-guide.txt
In-Reply-To: <20191003114428.GC1858@rei>
References: <20190930115852.21672-1-pvorel@suse.cz>
 <20190930115852.21672-3-pvorel@suse.cz> <20191003114428.GC1858@rei>
Message-ID: <20191003164347.GA2061@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> >  ```
> > -$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> > +$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/bin:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> >  ```

> This looks like an unrelated change at best and should probably be part
> of a separate patch.

> Also the only thing that seems to be installed in $LTPROOT/bin/ that
> could be potentially used by tests is the ffsb tool, that we are going
> to get rid anyways. So I would have avoided including it in the example
> anyways.

Yep, I'm aware ffsb is needed from $LTPROOT/bin. I haven't forced to send
proposal about ffbs adding into separate repository, that why I included it.
But sure, I'll drop this part.
Ack the rest?

> > +1. Library environment variables
> > +--------------------------------
> > +
> > +|==============================================================================
> > +| 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
> > +                          the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
> > +| 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
> > +| 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
> > +                          'n' or '0': never colorize.
> > +| 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
> > +                          slow machines to avoid unexpected timeout).
> > +                          Variable is also used in shell tests.
> > +| 'PATH'                | It's required to addjust path:
> > +                          `PATH="$PATH:$LTPROOT/bin:$LTPROOT/testcases/bin"`
+ off course to fix it here.
                               `PATH="$PATH:$LTPROOT/testcases/bin"`

> > +| 'TMPDIR'              | Base directory for template directory, which is required by C tests


Kind regards,
Petr
