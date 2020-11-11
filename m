From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Nov 2020 10:55:53 +0100
Subject: [LTP] [PATCH 1/1] m4: Remove workaround for old pkg-config
In-Reply-To: <CAEemH2cyoSpQhTH5S=EWWoD7DaLz6WKFFadLFHMxkW8LHYM5CA@mail.gmail.com>
References: <20201110120923.21759-1-pvorel@suse.cz>
 <20201111093934.GA5870@yuki.lan>
 <CAEemH2cyoSpQhTH5S=EWWoD7DaLz6WKFFadLFHMxkW8LHYM5CA@mail.gmail.com>
Message-ID: <20201111095553.GA8524@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On Wed, Nov 11, 2020 at 5:38 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> > Hi!
> > Looks good to me, let's apply this unless anybody complains.


> Hold on, please.

> Seems we have to replace TIRPC_LIBS/TIRPC_CFLAGS with LIBTIRPC_* in all
> respective Makefiles? Otherwise, it will fail like the Travis CI job I
> guess.

Correct, currently would fail without it.
https://travis-ci.org/github/pevik/ltp/builds/742685737

I'll send v2 where I implement this.

Kind regards,
Petr
