From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Feb 2020 16:30:11 +0100
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <20200224130856.GB30073@rei.lan>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
 <20200220170425.GB15699@gacrux.arch.suse.de>
 <20200224031847.4nbao5too3vuyfqx@vireshk-i7>
 <20200224130856.GB30073@rei.lan>
Message-ID: <20200224153011.GA24401@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > @Cyril ?

> Hmm, we should fix library to be able to format the device properly,
> looks like some kind of bug though:

> https://github.com/dosfstools/dosfstools/issues/40

I'm not able to reproduce the problems on fsopen01 and fsmount02.
Using different tmp directory via TMPDIR fixed that, but it started to work even
without it and even reboot didn't bring back the failure. On different host
(different distro) it worked all the time. I wonder what was wrong.

Kind regards,
Petr
