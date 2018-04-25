From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Apr 2018 15:16:20 +0200
Subject: [LTP] [RFC PATCH v3 10/10] ima: Print /proc/cmdline and IMA
 kernel config
In-Reply-To: <20180425074116.hic5a3nfunyxamcd@g206.suse.de>
References: <20180424183556.2368-1-pvorel@suse.cz>
 <20180425074116.hic5a3nfunyxamcd@g206.suse.de>
Message-ID: <20180425131620.GA27526@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Michael,

thank you for your comment.

> On Tue, Apr 24, 2018 at 08:35:56PM +0200, Petr Vorel wrote:  
> > +print_ima_config()
> > +{
> > +	local config="/boot/config-$(uname -r)"
> Just a small remark here: not all distributions have /boot/config-* files
> in place. I don't remember which ones this were.
> Wouldn't it make sense to check this file, if it does not exist check
> if /proc/config.gz is available? 
I haven't found any normal distro not having config in place (openSUSE/SLE, Debian/Ubuntu,
CentOS/Red Hat), but there might be some. I guess most of embedded devices don't have
that (it's a question if they have IKCONFIG_PROC=y) but why not to try it.

I wonder if we'd benefit from having these functions in shell API:
is_enabled(CONFIG_FOO)
is_module(CONFIG_FOO)
is_builtin(CONFIG_FOO)

which would do simple grep of either /boot/config-$(uname -r) or /proc/config.gz.

The first three are inspired with kernel macros from include/linux/kconfig.h


> Kind regards,
> Michael

Kind regards,
Petr
