From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Nov 2019 09:23:23 +0100
Subject: [LTP] [PATCH 1/1] Fix compression ratio calculation in zram01
In-Reply-To: <7c68a69d-8edd-d4d5-de1d-39d2cb8e4f03@suse.cz>
References: <20191104125228.17173-1-mdoucha@suse.cz>
 <20191104125228.17173-2-mdoucha@suse.cz>
 <20191104151647.GA15477@dell5510>
 <7c68a69d-8edd-d4d5-de1d-39d2cb8e4f03@suse.cz>
Message-ID: <20191105082322.GA16218@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> On 11/4/19 4:16 PM, Petr Vorel wrote:
> > I wonder if /sys/block/zram0/mm_stat is missing whether it can be on any other
> > zram<id>. Is it it's presence file system specific? Shouldn't we just quit whole
> > test wit tst_brk TCONF.

> If /sys/block/zram0/mm_stat is missing then all /sys/block/zram*/mm_stat
> files should be missing. But I don't want to terminate the test there
> because the remaining 3 write tests could still find a regression. So
> print a TCONF message on the first pass and silently skip the remaining
> compression ratio checks.
Do you mean that dd filling zram could find a regression?

I'm asking because it's a bit strange to have test,
which doesn't lead to any result (TPASS/TFAIL/TBROK/TCONF), which will be

If this part is also a test, maybe following TINFO should be changed to TPASS.
+ Also new shell API allows to use loop in API (code simplify), but that
requires for each run to produce a result.


> I was also thinking about checking whether the write test filled the
> test file at least up to 50% of memory limit if mm_stat doesn't exist.
> But it'd mostly add unnecessary complexity.
Agree.

Kind regards,
Petr
