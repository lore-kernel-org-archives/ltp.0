From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Mar 2017 15:03:13 +0100
Subject: [LTP] [PATCH 2/2] color: Fix backslash-escape sequences for
 some non-bash shells
In-Reply-To: <20170301133654.ijl4lqrd3s26vdfq@dell5510>
References: <20170217000345.18704-1-pvorel@suse.cz>
 <20170217000345.18704-2-pvorel@suse.cz>
 <20170301131323.GC32207@rei.lan>
 <20170301133654.ijl4lqrd3s26vdfq@dell5510>
Message-ID: <20170301140313.GE32207@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > >  	# NOTE: these colors should match colors defined in include/tst_ansi_color.h
> > > -	local ansi_color_blue='\e[1;34m'
> > > -	local ansi_color_green='\e[1;32m'
> > > -	local ansi_color_magenta='\e[1;35m'
> > > -	local ansi_color_red='\e[1;31m'
> > > -	local ansi_color_yellow='\e[1;33m'
> > > +	local ansi_color_blue='\033[34;1m'
> > > +	local ansi_color_green='\033[32;1m'
> > > +	local ansi_color_magenta='\033[35;1m'
> > > +	local ansi_color_red='\033[31;1m'
> > > +	local ansi_color_yellow='\033[33;1m'
> 
> > I'm a bit puzzled by the change of the position of color and bold in the
> > escape sequence. As far as I can tell it does not matter at all, or does
> > it?
> Sorry, my inattention, I'll generate v2.

I'm not saying that it's wrong. Just that there is no mention of the
change in the commit description and without it it looks meaningless.

-- 
Cyril Hrubis
chrubis@suse.cz
