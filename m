From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Aug 2020 15:27:13 +0200
Subject: [LTP] [PATCH 1/3] build system: Add explicit make rules
In-Reply-To: <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
References: <20200731121508.12805-2-chrubis@suse.cz>
 <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
Message-ID: <20200803132713.GA8810@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> ----- Original Message -----
> > This commit adds explicit build rules, the main motivation are recent
> > build failures caused by library orderings. To fix that this commit
> > introduces LTPLDLIBS special variable that is passed to linker before
> > the LDLIBS which avoids the need for tricks as
> > "LDLIBS := -lltpfoo $(LDLIBS)" in the Makefiles.

> > This commit also silences the output by default a bit, the verbose
> > output could be enabled by VERBOSE=1 env variable, which is probably
> > what most of the build systems will do if this gets commited. I guess
> > that we can as well silence a bit the "make entering/leaving directory"
> > if this the right way to go.

> alias for V=0 / V=1 would be nice

> LTPLDLIBS should probably be mentioned in doc/build-system-guide.txt

...

> What if we wouldn't print "DIR" (for non-clean targets) and printed relative paths instead?

+1 to all suggestions (including Li's to avoid printing DIR in 3rd commit).

Kind regards,
Petr
