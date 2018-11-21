From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Wed, 21 Nov 2018 19:53:21 +0000
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
 config
In-Reply-To: <20181116135947.GF29013@rei.lan>
References: <20181115134441.27359-1-chrubis@suse.cz>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A40F97@USCULXMSG01.am.sony.com>
 <20181116135947.GF29013@rei.lan>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF8E0BE529@USCULXMSG03.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry for the slow response.  Some personal issues interfered with
my work in the last week.

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Hi!
> > It would be nice to use a variable name here that was not project-specific.
> >
> > In Fuego, we automatically check a few different places, but we don't
> > check a location specified by an environment variable.  However, I've
> wanted to
> > add one.  I'd prefer to use the same one as other projects, if possible.
> >
> > I'm shooting from the hip here, but how about something like:
> > KCONFIG_PATH
> > ?
> 
> Fine with me, should I switch to this one in v2?

I didn't hear back from anyone with an alternative, so I would say yes.

That variable name is something I can try to promote to other groups
and frameworks.  IMHO, this would be a nice bit of info to get from the
kernel build, or from the build system or distribution.

Thanks,
 -- Tim
