From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 24 Feb 2020 16:32:47 +0100
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <20200224153011.GA24401@dell5510>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
 <20200220170425.GB15699@gacrux.arch.suse.de>
 <20200224031847.4nbao5too3vuyfqx@vireshk-i7>
 <20200224130856.GB30073@rei.lan> <20200224153011.GA24401@dell5510>
Message-ID: <20200224153246.GC2210@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, we should fix library to be able to format the device properly,
> > looks like some kind of bug though:
> 
> > https://github.com/dosfstools/dosfstools/issues/40
> 
> I'm not able to reproduce the problems on fsopen01 and fsmount02.
> Using different tmp directory via TMPDIR fixed that, but it started to work even
> without it and even reboot didn't bring back the failure. On different host
> (different distro) it worked all the time. I wonder what was wrong.

Hmm, that sounds really strange, I doubt that there is something that
would create partitions on a loop device on a background, so it really
smells like a bug.

-- 
Cyril Hrubis
chrubis@suse.cz
