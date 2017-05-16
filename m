From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 May 2017 16:15:23 +0200
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
References: <20170516100759.10355-1-chrubis@suse.cz>
 <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
 <20170516133233.GB2897@rei.lan>
 <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
Message-ID: <20170516141523.GD2897@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Do you have a ppc64 numa machine with more than two nodes at hand? Since
> 
> Yes, I have access to couple with 4 numa nodes.
> 
> > that is the only one where the current code may fail. Both x86_64 and
> > aarch64 seems to have 2MB huge pages.
> 
> Default huge page for aarch64 is 512M.
> 
> # cat /proc/meminfo | grep Hugepagesize
> Hugepagesize:     524288 kB
> 
> # uname -r
> 4.11.0-2.el7.aarch64
> 
> I think in 4.11 you can't even switch with default_hugepagesz=2M at the moment:
>  6ae979ab39a3 "Revert "Revert "arm64: hugetlb: partial revert of 66b3923a1a0f"""

Hmm, my SLES12 SP2 aarch64 with kernel 4.4 has 2MB so it's not even
consistent among architectures.

> > 
> > I would just go with this patch now, and possibly fix more complicated
> > corner cases after the release, since this patch is the last problem
> > that holds the release from my side.
> 
> Can't we squeeze it in? All we need is to use "hpsz" we already have:
> 
>   snprintf(path_hugepages_node1, sizeof(path_hugepages_node1),
>           "/sys/devices/system/node/node%u/hugepages/hugepages-%dkB/nr_hugepages",
>           node1, hpsz);

Okay, let's go with that one. Presumbly if there is not enough RAM the
size of the poll will be truncated silently here and we will produce
TCONF once we try to allocate these in case that the default hugepage
size is too big.

-- 
Cyril Hrubis
chrubis@suse.cz
