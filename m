From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Dec 2017 20:19:42 +0100
Subject: [LTP] [RFC PATCH 3/3] build.sh: Allow to overwrite prefix
In-Reply-To: <20171213161159.GB22116@rei>
References: <20171213131334.26863-1-pvorel@suse.cz>
 <20171213135943.GF11493@rei>
 <20171213144101.54egpm2q4nbb5asc@dell5510>
 <20171213161159.GB22116@rei>
Message-ID: <20171214191942.nd7iqrwbbofcrxdc@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

> > Maybe I should have used getopts short option with values, even I don't like short values:

> > ./build.sh [ -t 32|cross|out ] [ -p PREFIX_DIR ] [ -c CC ]

> This does not seem that bad to me.

> I would like to avoid passing half of the parameters via argv and half
> via env variables if possible.
Right. I rewrote the script and clean it a bit (see master). Everything now uses
getopts (shell built-in).
IMHO script is now suitable for local development as well.

I also added that 2 ARM cross-compile builds.

Kind regards,
Petr
