From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Dec 2017 15:41:01 +0100
Subject: [LTP] [RFC PATCH 3/3] build.sh: Allow to overwrite prefix
In-Reply-To: <20171213135943.GF11493@rei>
References: <20171213131334.26863-1-pvorel@suse.cz>
 <20171213135943.GF11493@rei>
Message-ID: <20171213144101.54egpm2q4nbb5asc@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > I like getopt(s) and the reason I didn't use them is:
> > * I don't like short opts which provides getopts build-in (the one we use in LTP).

> Why so, readability concerns?
Yes. It works well how it is, I just find it quite unusual not to use getopt(s). And
mixing parameters with and without '-' as I did is bad.
Whole point of these changes is to make the script usable also for local development
(sometimes one may want to run two builds, thats why it's good to allow overwrite prefix).

Maybe I should have used getopts short option with values, even I don't like short values:

./build.sh [ -t 32|cross|out ] [ -p PREFIX_DIR ] [ -c CC ]

I decided leave out-of-tree on it's own (native only). But it would be possible to have
e.g. out-of-tree 32-bit compilation, but I don't see much advantages for it.


Kind regards,
Petr
