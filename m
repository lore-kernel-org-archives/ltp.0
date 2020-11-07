From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 7 Nov 2020 17:55:18 +0100
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <f99d3484-f86d-dd8a-e64e-7d9d94533de4@163.com>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
 <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
 <20201106164742.GA6449@rei.lan>
 <f99d3484-f86d-dd8a-e64e-7d9d94533de4@163.com>
Message-ID: <20201107165518.GB10159@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On 11/7/20 12:47 AM, Cyril Hrubis wrote:
> > Hi!
> > > I have a doubt after reading Xu's patch[1] and Martin's patch[2]:

> > > 1) Xu removed sync01 because sync() always return 0.
> > Actually sync() is defined as void function, so the tests were bogusly
> > checking the TST_RET value which haven't been set at all.

> Hi Cyril,

> Oops, I gave a wrong example. :-(

> On error, I just wonder if we need to check all return value(i.e. negative
> value except -1).

> IOW, Is it possible for syscall to get a error value which is not -1?
There are probably other examples, but I've found only these:

man malloc_get_state(3)

	If the implementation detects that state does not point to a correctly
	formed data structure, malloc_set_state() returns -1.
	If the implementation detects that the version of the data structure
	referred to by state is a more recent version than this implementation knows
	about, malloc_set_state() returns -2.

man mmap(2)
	On error, the value MAP_FAILED (that is, (void *) -1) is returned.

> Best Regards,

> Xiao Yang


Kind regards,
Petr
