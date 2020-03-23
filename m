From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Mar 2020 08:44:40 +0530
Subject: [LTP] [PATCH] syscalls/fspick: Call fsconfig with
 FSCONFIG_CMD_RECONFIGURE
In-Reply-To: <20200320120429.GA31021@dell5510>
References: <b392569b582f264927f2fea65bf14a89c03faaa5.1584679961.git.viresh.kumar@linaro.org>
 <20200320120429.GA31021@dell5510>
Message-ID: <20200323031440.lfqovmbecidd6u7a@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-03-20, 13:04, Petr Vorel wrote:
> Hi Viresh,
> 
> > Make sure mountpoint is reconfigured after all the recent changes by
> > calling fsconfig() with FSCONFIG_CMD_RECONFIGURE.
> 
> Thanks, merged.
> 
> BTW how about print flag on failure? (just to improve readability, although
> there are line numbers so not required).

Yeah, I have been relying on line numbers mostly for this. Though I
can add more descriptive messages if you want :)

-- 
viresh
