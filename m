From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Nov 2018 14:57:47 +0100
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
	config
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF88A40FCE@USCULXMSG01.am.sony.com>
References: <20181115134441.27359-1-chrubis@suse.cz>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A40FCE@USCULXMSG01.am.sony.com>
Message-ID: <20181116135747.GE29013@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is good.  Just a comment on the proposed syntax and options.
> Fuego uses NEED_KCONFIG (upper-case because it's a shell global variable),
> and 0-day uses need_kconfig.
> 
> There are a few slight differences in syntax between different systems.
> (I'm making no judgements, just noting the differences).
> 
> Fuego and 0day also support a string including the option value, such
> as:
>  CONFIG_PRINTK=y
>  CONFIG_LOCKDEP_SUPPORT=n
>  CONFIG_CAN=m

I guess that it makes sense to support this as well.

I can easily switch to verbatim match if the option I'm looking for
contains '='.

> See https://elinux.org/Test_Dependencies
> 
> where I've started collecting some of these different syntaxes.

Thanks for the pointer, I will look into that.

-- 
Cyril Hrubis
chrubis@suse.cz
