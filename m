From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jul 2020 12:11:42 +0200
Subject: [LTP] [PATCH V2 2/3] syscalls: sigwaitinfo: Remove
 SUCCEED_OR_DIE() macro
In-Reply-To: <20200722100914.GC2319@yuki.lan>
References: <cover.1595321086.git.viresh.kumar@linaro.org>
 <8fbd46e33184029f89829af3cd471c05ee6ce496.1595321086.git.viresh.kumar@linaro.org>
 <20200722100914.GC2319@yuki.lan>
Message-ID: <20200722101142.GD2319@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The macro makes it less readable and there isn't a great deal of code it
> > is trying to remove. Get rid of it.
> 
> Looking at the code we may as well add SAFE_SIGEMPTYSET() and
> SAFE_SIGADDSET() instead, what do you think?

Looking at the patch that separates the files, it may be easier to apply
that and do this on the top of that...

-- 
Cyril Hrubis
chrubis@suse.cz
