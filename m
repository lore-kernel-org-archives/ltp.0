From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Aug 2020 11:21:58 +0200
Subject: [LTP] [PATCH V8] syscalls: clock_settime: Add test around y2038
 vulnerability
In-Reply-To: <20200806043644.n7ea7wxeklix65oq@vireshk-mac-ubuntu>
References: <96ce72a605e365a040b258db9323d3962ab80e29.1596545279.git.viresh.kumar@linaro.org>
 <20200805151145.GA631@yuki.lan>
 <20200806043644.n7ea7wxeklix65oq@vireshk-mac-ubuntu>
Message-ID: <20200806092158.GA3315@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Other than that these the code looks good. I can fix these two before
> > applying if you agree.
> 
> Sure. Thanks.

In the end I've also added safe macros for sigprocmask() and sigwait()
mainly because sigwait() is one of these funcitons that return error
instead of setting errno. Now the error handling that nobody gets right
is handled in the library...

-- 
Cyril Hrubis
chrubis@suse.cz
