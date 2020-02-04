From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 Feb 2020 16:52:54 +0100
Subject: [LTP] [RFC PATCH 1/1] autotools: Move simple definitions out of
 m4/* to configure.ac
In-Reply-To: <20200204154432.GB2255@rei>
References: <20200130110753.20459-1-pvorel@suse.cz>
 <20200204132152.GC16090@rei> <20200204142918.GB18759@dell5510>
 <20200204154432.GB2255@rei>
Message-ID: <20200204155254.GA15212@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Maybe we could use ac_cv_header_sys_xattr_h=yes to set HAVE_FTS_H for Makefile.

> > So it works with following diff applied work as well.
> > I have no strong opinion which one is better.

> That looks like even more black magic, let's go with the first version.
Thanks, merged original.

Kind regards,
Petr
