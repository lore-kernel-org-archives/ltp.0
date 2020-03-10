From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Mar 2020 21:45:14 +0100
Subject: [LTP] [PATCH] travis: Temporarily disable fedora:lastest
In-Reply-To: <20200310161001.GA29541@dell5510>
References: <1583834577-21695-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <7c240f66-a65b-4444-b4a2-7569f52e5496@cn.fujitsu.com>
 <20200310161001.GA29541@dell5510>
Message-ID: <20200310204514.GA4381@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > I also test fedora:32 fedora:33 in my ltp fork[1], they are all pass.
> > fedora:31 and fedora:latest are failed.

> > @Petr, You often modify travis code, if you have some advise, please let me
> > know.
> Thank you for taking care.

> I hoped it'd get fixed soon, but it haven't so far :(
> Generally I'd prefer to use rawhide (which is 33, see [2]), but until it's fixed
> let's use 32 (upcomming release).

> Please send patch today, or I'll commit it myself tonight.
FYI I pushed 34f225892 travis: Temporarily use fedora:33.

When [1] is fixed, we 1) revert this 2) restart these failed jobs, which use
rawhide.

Thanks a lot for taking care and reporting [1].

Kind regards,
Petr

[1] https://github.com/fedora-cloud/docker-brew-fedora/issues/73
