From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Apr 2020 09:55:06 +0200
Subject: [LTP] [PATCH v1 03/10] syscalls/ioctl_loop01: Add
 LO_FLAGS_AUTOCLEAR and LO_FLAGS_PARTSCAN test
In-Reply-To: <07295721-7256-d6f1-872e-e29de2ecea4f@cn.fujitsu.com>
References: <1585839990-19923-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1585839990-19923-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200403115502.GC26355@yuki.lan>
 <16dd8088-e485-8e7b-8e99-2b755e889041@163.com>
 <07295721-7256-d6f1-872e-e29de2ecea4f@cn.fujitsu.com>
Message-ID: <20200409075506.GA2828@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> I wonder if we can avoid dependency on parted by having a look at the
> >> changes in the image after the call to parted and writing a few bytes
> >> ourselves instead.
> > I will see kernel code to figure out this, if no other good way, we can 
> > split this check into a new single test. it can make this case less 
> > couping.
> Sorry for misunderstanding,.  I prefer to add a parted test.img(10K is 
> ok on my environment) into ltp or add a flag to skip this 
> check(/dev/loop0p1) when parted command is not available.  What do you 
> think about the two ways?

I it couldn't be easily done without parted then it's fine if the test
depends on it.

-- 
Cyril Hrubis
chrubis@suse.cz
