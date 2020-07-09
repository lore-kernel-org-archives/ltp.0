From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 9 Jul 2020 16:16:35 +0530
Subject: [LTP] [PATCH V7 09/19] syscalls/sigwaitinfo: Migrate to new
 test framework
In-Reply-To: <20200707151631.GA5197@rei.lan>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <18d8603306f51f243faca04cf63bcaf2c7168d56.1593152309.git.viresh.kumar@linaro.org>
 <20200703135812.GC2308@yuki.lan>
 <20200706023941.ievw6vsdp6gvr3g7@vireshk-i7>
 <20200707151631.GA5197@rei.lan>
Message-ID: <20200709104635.ce3ehbfggpd32lqc@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07-07-20, 17:16, Cyril Hrubis wrote:
> Hi!
> > > Honestly I'm not sure what we should do about this test. Obviously this
> > > is a step into right direction but it still keeps the SUCCEED_OR_DIE()
> > > macro that produces many warnings.
> > > 
> > > I'm also not happy about the fact that we compile different test based
> > > on ifdefs and that there are empty directories where binaries are
> > > magically appear during the build. I would be much happier if we had a
> > > real test sources there and share the large enough common bits in a
> > > different way.
> > 
> > What about merging this patch as is (so I don't to keep sending it)
> > and then I fix all the issues you want to get fixed in this test
> > separately ?
> 
> Fair enough, merged.

I believe you will apply the next patch (10/19) as well, which touches
this file and so I am starting to work on top of that now.

-- 
viresh
