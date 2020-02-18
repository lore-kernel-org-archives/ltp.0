From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 18 Feb 2020 12:28:25 +0530
Subject: [LTP] [PATCH 0/7] Add new LTP tests related to fsmount family
 of syscalls
In-Reply-To: <20200218061906.GB14282@dhcp-12-102.nay.redhat.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <20200218061906.GB14282@dhcp-12-102.nay.redhat.com>
Message-ID: <20200218065825.wtjjnt66jczsycej@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zorro,

Thanks for taking time and providing your feedback :)

On 18-02-20, 14:19, Zorro Lang wrote:
> On Fri, Feb 14, 2020 at 05:05:49PM +0530, Viresh Kumar wrote:
> Thanks for all these cases, that's really helpful.
> 
> Although you write cases for each new mount API, each xxxxx01.c case looks
> nearly do same things.

I agree, just that they are all slightly different, and perhaps they can be
improved to test different parameters for the success case as well.

I think all the *02.c files are quite different that way, and perhaps *01.c
tests should do the same.

> That's why I only wrote one case for new-mount currently, due to basic mount
> test already can through most of new APIs(except open_tree and fspick). I don't
> know if we should write nearly same things in different directories.
> Actually I prepared open_tree and fspick test cases(planned to name as newmount02
> and newmount03. but the newmount01 has been changed to fsmount01 :), but didn't
> sent out, due to I hope to the first case(which does basic changes) can be merged
> at first.

Heh. I had no clue that anyone else is working on this stuff else I won't have
touched it at all (and saved some time) :)

> All of your xxxxx02.c cases are great! I planned to test more different
> parameters of fsconfig() later too. Your invalid parameters test are nice.
> As you've sent these cases, I think these should be reviewed at first, avoid
> we do same things:) I'll try to help to review V2 patchset too, if I can:-P

Thanks for suggesting this way out, and I agree 100% with you.

FWIW, I am working on V2 which I should be able to send by tomorrow max (if
everything goes as planned). Lets see how it looks after that and I would love
to review any improvement patches you may have after these are merged (Please cc
me directly, I haven't opted for receiving emails from ltp list).

-- 
viresh
