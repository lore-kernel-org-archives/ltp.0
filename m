From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Jan 2017 10:24:59 +0100
Subject: [LTP] [RFC PATCH 1/1] test.sh: colorize the output
In-Reply-To: <20170105085711.8903-1-petr.vorel@gmail.com>
References: <20170105085711.8903-1-petr.vorel@gmail.com>
Message-ID: <20170105092457.GA15400@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi, I know you're busy with release and this is just a toy for interactive
> running. But it you find it useful for upstream, I'll try to polish it and
> implement TODO.

I guess that we can add support for colors.

> TODO:
> * Create environment variable or getopt switch for enabling/disabling
>   colors (instead of macro USE_ANSCI_COLOR), default off. Work in
>   similar way like ls (--color[=WHEN], WHEN can be 'always' (default if
>   omitted), 'auto', or 'never').

Adding more default options for testcases does not seem to be good idea
to me, environment variable sounds much better.

I would expect colorized output enabled by default, but the color output
would be produced only if we are writing to actual terminal. Utils such
as grep use stat() on stdout to check if it's char device and isatty()
as well. And we should also have some env variable, something as
LTP_COLORIZE_OUTPUT to override the decision.

> * DRY: Keep default definition only on one place => generate with make?
> * Allow user to define colors (overwrite with environment variables).

User defined colors does not sound that useful to me.

-- 
Cyril Hrubis
chrubis@suse.cz
