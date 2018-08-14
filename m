From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Aug 2018 12:14:04 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] [WORK-IN-PROGRESS] syscalls: Add
 set_mempolicy numa tests.
In-Reply-To: <20180814131007.GB22915@rei.lan>
References: <20180809152308.18982-1-chrubis@suse.cz>
 <531762042.40419801.1534248925760.JavaMail.zimbra@redhat.com>
 <20180814131007.GB22915@rei.lan>
Message-ID: <2044013404.40481857.1534263244336.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > Why not use get_mempolicy(.., MPOL_F_NODE | MPOL_F_ADDR) to get node id,
> > for the page we just allocated?
> 
> Good point, I will try to look into that.
> 
> > This kinda overlaps with numa_helper in some aspects. Which reminds me
> > of some issues we had to address there:
> > - memory-less nodes
> > - nodes with little to no free memory
> 
> I'm aware of the overlap and we should definitely merge these two into a
> single library later on.
> 
> As far as I can tell the library I wrote covers the case of memory-less
> nodes, these should the the ones that does not have the membind flag set
> in the default mask that is returned by numa_get_membind().

Confirmed.

# ./a.out 
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 0 size: 0 MB
node 0 free: 0 MB
node 1 cpus:
node 1 size: 12288 MB
node 1 free: 11018 MB
node distances:
node   0   1 
  0:  10  40 
  1:  40  10 

membind[0] = 0
membind[1] = 1

If this has support in older releases, it looks simpler than what
numa_helper is doing (iterating over sysfs).

Regards,
Jan
