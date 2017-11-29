From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 20:07:58 +0100
Subject: [LTP] [RFC PATCH 0/4] Travis enhancements
In-Reply-To: <20171129154413.GC15160@rei>
References: <20171128232130.4843-1-pvorel@suse.cz> <20171129154413.GC15160@rei>
Message-ID: <20171129190758.GC3573@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > I've added several travis enhancements, most notably added 32bit cross-compile
> > build and added more compilers (add gcc-7, clang-4.0, clang-5.0, remove clang-3.9).
> > Now there is 12 builds instead of 9, speed increased from ~13 min [1] to ~26 min [2],
> > which is maybe to much.  If we don't like it, we can decide which compilers to have.

> Well we can cut a few compiler versions, perhaps just keep the latest
> for each major number, that should catch most of the problems I guess.
Thanks for an input! OK, I'll drop gcc 4.6, 4.7, 4.8 and clang 3.5, 3.8.
So we'll have gcc 4.9, 5.x, 6.x, 7.x and clang 3.9, 4.0 and 5.0
Unfortunately I haven't manage to add gcc 8.

Kind regards,
Petr
