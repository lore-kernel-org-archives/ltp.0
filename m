From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Thu, 15 Nov 2018 20:16:29 +0000
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
 config
In-Reply-To: <20181115134441.27359-1-chrubis@suse.cz>
References: <20181115134441.27359-1-chrubis@suse.cz>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF88A40F97@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -----Original Message-----
> From: Cyril Hrubis on Thursday, November 15, 2018 5:45 AM
> 
> This is meant as last resort action for disabling tests if certain
> kernel funcitonality was not present, in general case runtime checks are
> prefered.
> 
> For functionality that can be build as a module tst_check_driver() is
> most likely better fit since it will also insert requested kernel module
> into kernel if needed.
> 
> For newly added syscalls kernel version comparsion and/or checking errno
> is prefered.
> 
> However in rare cases certain core kernel functionality cannot be
> detected in any other way than checking the kernel config, which is
> where this API gets into the play.
> 
> The path to the kernel config could be specified by LTP_KCONFIG
> environment variable, which also takes precedence before the
> autodetection that attempts to read the config from known locations.

It would be nice to use a variable name here that was not project-specific.

In Fuego, we automatically check a few different places, but we don't
check a location specified by an environment variable.  However, I've wanted to
add one.  I'd prefer to use the same one as other projects, if possible.

I'm shooting from the hip here, but how about something like:
KCONFIG_PATH
?

Is this something that kernel-producing projects, such as Yocto Project
or Buildroot, (or Debian or Fedora, or the kernel Makefile, for that matter)
already have, or would be willing to support?

To others on the automated-testing list, does anyone else have a
variable used to specify the location of the kernel config file?  If so,
what's its name?

 -- Tim


