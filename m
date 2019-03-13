From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Mar 2019 12:07:11 +0100
Subject: [LTP] [PATCH] verify_caps_exec: Respect TMP environment variable
In-Reply-To: <93480014.31836255.1531299278505.JavaMail.zimbra@redhat.com>
References: <20180622232353.151563-1-astrachan@google.com>
 <93480014.31836255.1531299278505.JavaMail.zimbra@redhat.com>
Message-ID: <20190313110711.GA2606@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alistair, Jan,

> ----- Original Message -----
> > The filecapstest.sh wrapper script already allows the /tmp directory to
> > be overridden with the TMP environment variable, however doing so has
> > no effect on verify_caps_exec because it creates its own version of this
> > fifo at a hardcoded location under /tmp.

> > To ensure the fifo is correctly removed by the wrapper script, alter
> > verify_caps_exec to respect the TMP environment variable and create a
> > fifo at the same location.

> Hi,

> this doesn't seem to be enough, print_caps.c is also hardcoding /tmp.
> Other than rewriting the test, I'm thinking simplest way to fix this is:

> 1. export FIFOFILE in wrapper script and then use that env. variable
> in all *.c tests.

> 2. change wrapper script to use $TMPDIR if available
> (that is the value exported by runltp)

> What do you think?
I guess this issue has been solved by 
cf8bd0327 ("filecaps: Respect TMPDIR environment variable"), thus closing it in
patchwork [1]

> Regards,
> Jan

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/934131/
