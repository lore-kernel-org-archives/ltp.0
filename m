From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 24 Feb 2020 14:08:56 +0100
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <20200224031847.4nbao5too3vuyfqx@vireshk-i7>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
 <20200220170425.GB15699@gacrux.arch.suse.de>
 <20200224031847.4nbao5too3vuyfqx@vireshk-i7>
Message-ID: <20200224130856.GB30073@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am not sure what should be done here.
> 
> @Cyril ?

Hmm, we should fix library to be able to format the device properly,
looks like some kind of bug though:

https://github.com/dosfstools/dosfstools/issues/40

-- 
Cyril Hrubis
chrubis@suse.cz
