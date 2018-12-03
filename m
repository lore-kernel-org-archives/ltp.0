From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Dec 2018 17:37:02 +0100
Subject: [LTP] with-numa/without-numa option not working ?
In-Reply-To: <9a9b8890-5bc0-1123-1ceb-68dedb6e7a5c@linaro.org>
References: <9a9b8890-5bc0-1123-1ceb-68dedb6e7a5c@linaro.org>
Message-ID: <20181203163701.GA19576@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Rafael,

> Hello,

> Daniel has discovered that --with-numa and --without-numa practically
> have the same effect, disabling NUMA support. This can be seen when
> executing test "migrate_pages03", for example.

> In both situations it will display:

> tst_test.c:771: CONF: require libnuma >= 2 and it's development packages

> config.log shows:

> when --with-numa AND when --without-numa are set (or --with-numa=yes or
> --with-numa=no):
Thanks for your report. I'm the author of numa configure option, I'm aware of
it (39a85a1f1 and 4ace68a6b).
It was never meant that --with-numa would be working.  There was only
--without-numa as workaround for systems without numa libraries and devel files.
Before it was a dependency for LTP compilation.
But I know it's confusing, as it's expected both --with-PACKAGE
and--without-PACKAGE are implemented, so I'll fix it => with --with-numa
(which will be the default) it will fail to compile.

Kind regards,
Petr
