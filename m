From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 6 Jul 2020 08:09:41 +0530
Subject: [LTP] [PATCH V7 09/19] syscalls/sigwaitinfo: Migrate to new
 test framework
In-Reply-To: <20200703135812.GC2308@yuki.lan>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <18d8603306f51f243faca04cf63bcaf2c7168d56.1593152309.git.viresh.kumar@linaro.org>
 <20200703135812.GC2308@yuki.lan>
Message-ID: <20200706023941.ievw6vsdp6gvr3g7@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03-07-20, 15:58, Cyril Hrubis wrote:
> Hi!
> Honestly I'm not sure what we should do about this test. Obviously this
> is a step into right direction but it still keeps the SUCCEED_OR_DIE()
> macro that produces many warnings.
> 
> I'm also not happy about the fact that we compile different test based
> on ifdefs and that there are empty directories where binaries are
> magically appear during the build. I would be much happier if we had a
> real test sources there and share the large enough common bits in a
> different way.

What about merging this patch as is (so I don't to keep sending it)
and then I fix all the issues you want to get fixed in this test
separately ?

I agree with the issues you raised. It took me a while to understand
how it tests different syscalls and how things magically work in
multiple directories :)

-- 
viresh
