From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 13 May 2020 12:09:22 +0530
Subject: [LTP] [PATCH v2 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <5EBB944F.5010303@cn.fujitsu.com>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
 <20200513012626.1571-2-yangx.jy@cn.fujitsu.com>
 <20200513055533.ipmghf2oacc22mzy@vireshk-i7>
 <5EBB8DAA.5080509@cn.fujitsu.com>
 <20200513061343.mjhmciatmx4sw2ub@vireshk-i7>
 <5EBB944F.5010303@cn.fujitsu.com>
Message-ID: <20200513063922.vetbmhn35cbrdydk@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13-05-20, 14:31, Xiao Yang wrote:
> ? 2020/5/13 14:13, Viresh Kumar ??:
> > On 13-05-20, 14:03, Xiao Yang wrote:
> > > Could you tell which issue happen? Thanks a lot.
> > > The other two don't need the extra check because the implementation of
> > > pidfd_open() can do it well.  For 3rd test, I want to check the support of
> > > pidfs_open() before doing fork().
> > 
> > What I meant was that the solution needs to be consistent across
> Hi Viresh,
> 
> Current change can do correct check for pidfd_open[1-3] so don't need to add
> redundant check.

How will a check from file 03.c check it for 01.c or 02.c ?

> > tests. For example, with the current change the run() function will
> > run for all tests in pidfd_open02.c and print the message that syscall
> > isn't supported, while it would be better to run it only once in setup
> > and get done with it. i.e. 1 message instead of 3 similar ones.
> > 
> 
> Are you sure?
> 
> Triggering first tst_brk(TCONF, ...) will break the whole test instead of a
> subtest.

Ahh, yes. I missed the tst_brk part :(

But I will still like it to be consistent across files. But anyway,
whatever you and Cyril decide is fine :)

Thanks.

-- 
viresh
