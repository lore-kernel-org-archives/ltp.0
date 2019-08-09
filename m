From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 9 Aug 2019 15:57:52 +0200
Subject: [LTP] [PATCH v3 4/4] build: Move
 -Werror-implicit-function-declaration from make to build.sh
In-Reply-To: <20190809103506.GB13178@rei.lan>
References: <20190806164523.557-1-pvorel@suse.cz>
 <20190809093354.GA13178@rei.lan> <20190809100701.GB27030@dell5510>
 <20190809103506.GB13178@rei.lan>
Message-ID: <20190809135752.GB12261@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > Shouldn't this be -Werror=implicit-function-declaration ?
> > Yes, it is. '${CFLAGS:-' part is POSIX shell substitute (${parameter:-[word]}
> > from [1]), the result is '-Werror=implicit-function-declaration' when CFLAGS is
> > empty or not set.
> > I might change it as

> I meant the = after -Werror vs -.
Sure (I'm blind today). Changed to more common
-Werror=implicit-function-declaration and merged.

Kind regards,
Petr
