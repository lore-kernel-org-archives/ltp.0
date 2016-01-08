From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Fri, 8 Jan 2016 14:59:41 +0800
Subject: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT from
 oom()
In-Reply-To: <423580278.5207145.1452167840798.JavaMail.zimbra@redhat.com>
References: <20151228074919.GA12782@localhost.localdomain>
 <423580278.5207145.1452167840798.JavaMail.zimbra@redhat.com>
Message-ID: <20160108065941.GA2966@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jan 07, 2016 at 06:57:20AM -0500, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> > To: ltp@lists.linux.it
> > Sent: Monday, 28 December, 2015 8:49:19 AM
> > Subject: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT from	oom()
> > 
> > Looks like there is no such a case "OVERCOMMIT" in oom(), so we can just
> > remove it.
> > 
> > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> Looks good to me, regards,
> Jan
> 
Hi Jan,

Thanks for reviewing! I have another question: I think when
"overcommit_memory" being set to 1, mmap() will always succeed. It's
that correct? I read the code of kernel, looks like in
__vm_enough_memory(), if sysctl_overcommit_memory == OVERCOMMIT_ALWAYS,
it will always return 0. So I think in oom01.c, we should call the
testoom() as testoom(0, 0, 0, 1).


Thanks.

