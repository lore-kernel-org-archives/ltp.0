From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 12 Aug 2019 14:37:31 -0700
Subject: [LTP] [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
In-Reply-To: <20190812153326.GB17747@sasha-vm>
References: <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
 <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
 <20190809064633.GK18351@dhcp22.suse.cz>
 <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
 <20190811234614.GZ17747@sasha-vm>
 <20190812084524.GC5117@dhcp22.suse.cz>
 <39b59001-55c1-a98b-75df-3a5dcec74504@suse.cz>
 <20190812132226.GI5117@dhcp22.suse.cz>
 <20190812153326.GB17747@sasha-vm>
Message-ID: <20190812143731.3f46b952e53ff3434e04bcf9@linux-foundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 12 Aug 2019 11:33:26 -0400 Sasha Levin <sashal@kernel.org> wrote:

> >I thought that absence of the Cc is the indication :P. Anyway, I really
> >do not understand why should we bother, really. I have tried to explain
> >that stable maintainers should follow Cc: stable because we bother to
> >consider that part and we are quite good at not forgetting (Thanks
> >Andrew for persistence). Sasha has told me that MM will be blacklisted
> >from automagic selection procedure.
> 
> I'll add mm/ to the ignore list for AUTOSEL patches.

Thanks, I'm OK with that.  I'll undo Fixes-no-stable.

Although I'd prefer that "akpm" was ignored, rather than "./mm/". 
Plenty of "mm" patches don't touch mm/, such as drivers/base/memory.c,
include/linux/blah, fs/, etc.  And I am diligent about considering
-stable for all the other code I look after.

This doesn't mean that I'm correct all the time, by any means - I'd
like to hear about patches which autosel thinks should be backported
but which don't include the c:stable tag.

