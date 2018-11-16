From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Nov 2018 14:59:47 +0100
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
	config
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF88A40F97@USCULXMSG01.am.sony.com>
References: <20181115134441.27359-1-chrubis@suse.cz>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A40F97@USCULXMSG01.am.sony.com>
Message-ID: <20181116135947.GF29013@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It would be nice to use a variable name here that was not project-specific.
> 
> In Fuego, we automatically check a few different places, but we don't
> check a location specified by an environment variable.  However, I've wanted to
> add one.  I'd prefer to use the same one as other projects, if possible.
> 
> I'm shooting from the hip here, but how about something like:
> KCONFIG_PATH
> ?

Fine with me, should I switch to this one in v2?

-- 
Cyril Hrubis
chrubis@suse.cz
