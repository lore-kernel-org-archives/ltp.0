From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Sep 2019 20:38:02 +0200
Subject: [LTP] [PATCH v3 2/3] shell: Introduce TST_TIMEOUT variable,
 add checks
In-Reply-To: <20190924140757.GA787@rei>
References: <20190919135043.14359-1-pvorel@suse.cz>
 <20190919135043.14359-3-pvorel@suse.cz> <20190924140757.GA787@rei>
Message-ID: <20190924183802.GA6492@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +2.2.4 Test temporary directory
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> Can we please avoid this renumbering, also after this patch this
> variable applies to both shell and C. So this should probably go
> somewhere else, and I'm pretty sure that we have a few more at least
> LTPROOT, TMPDIR, KCONFIG_PATH, LTP_COLORIZE_OUTPUT.

Just a note about renumbering. I don't like it either, but with this format
requiring to specify number section we might end up with important changes being
at the bottom.

It'd help a bit if we had automatic TOC, but I haven't figured out how to do it
properly for AsciiDoc implementation in github.

Kind regards,
Petr
