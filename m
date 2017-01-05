From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Jan 2017 13:41:01 +0100
Subject: [LTP] [RFC PATCH 1/1] test.sh: colorize the output
In-Reply-To: <20170105092457.GA15400@rei.lan>
References: <20170105085711.8903-1-petr.vorel@gmail.com>
 <20170105092457.GA15400@rei.lan>
Message-ID: <20170105124101.cci4qjjfpvwaartu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for your comments!

> I guess that we can add support for colors.
Thanks! It might take some time as it's my private activity it has lower priority.

> Adding more default options for testcases does not seem to be good idea
> to me, environment variable sounds much better.
Right, I also agree.

> I would expect colorized output enabled by default, but the color output
> would be produced only if we are writing to actual terminal. Utils such
> as grep use stat() on stdout to check if it's char device and isatty()
> as well.
Oh yes, I meant this behaviour. Looking into grep and ls (coreutils) sources, they both
use similar approach - using stat()/fstat() and isatty().

> And we should also have some env variable, something as
> LTP_COLORIZE_OUTPUT to override the decision.
Good point. This comes instead of grep/ls --color= switch.

> > * Allow user to define colors (overwrite with environment variables).
> User defined colors does not sound that useful to me.
I was for that as not sure as everyone uses different terminal settings, has different
opinions about colors. And both ls and grep allow it. Although it has lowest priority
(detecting with isatty() is much more important).


Kind regards,
Petr
