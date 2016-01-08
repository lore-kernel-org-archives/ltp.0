From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Jan 2016 02:42:18 -0500 (EST)
Subject: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT from
 oom()
In-Reply-To: <20160108065941.GA2966@localhost.localdomain>
References: <20151228074919.GA12782@localhost.localdomain>
 <423580278.5207145.1452167840798.JavaMail.zimbra@redhat.com>
 <20160108065941.GA2966@localhost.localdomain>
Message-ID: <494674280.5705346.1452238938120.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, 8 January, 2016 7:59:41 AM
> Subject: Re: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT from oom()
> 
> On Thu, Jan 07, 2016 at 06:57:20AM -0500, Jan Stancek wrote:
> > 
> > 
> > ----- Original Message -----
> > > From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> > > To: ltp@lists.linux.it
> > > Sent: Monday, 28 December, 2015 8:49:19 AM
> > > Subject: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT from
> > > 	oom()
> > > 
> > > Looks like there is no such a case "OVERCOMMIT" in oom(), so we can just
> > > remove it.
> > > 
> > > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > 
> > Reviewed-by: Jan Stancek <jstancek@redhat.com>
> > 
> > Looks good to me, regards,
> > Jan
> > 
> Hi Jan,
> 
> Thanks for reviewing! I have another question: I think when
> "overcommit_memory" being set to 1, mmap() will always succeed. It's
> that correct? I read the code of kernel, looks like in
> __vm_enough_memory(), if sysctl_overcommit_memory == OVERCOMMIT_ALWAYS,
> it will always return 0. So I think in oom01.c, we should call the
> testoom() as testoom(0, 0, 0, 1).

It can also fail if you reach max_map_count (or if map size is too big, but
that shouldn't be the case in this test).

This is current call in oom01:
  testoom(0, 0, ENOMEM, 1);

Third parameter (retcode) does not apply only to mmap().
If you look at testoom(), it makes 3 tests:
  oom(NORMAL, lite, retcode, allow_sigkill);
  oom(MLOCK, lite, retcode, allow_sigkill);
  oom(KSM, lite, retcode, allow_sigkill);

oom() compares that retcode to exit code of alloc_mem(),
which will exit when either of these 3 fails: mmap, mlock or madvise.

Regards,
Jan

> 
> 
> Thanks.
> 
> 
