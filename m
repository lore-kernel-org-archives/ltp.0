From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 16 May 2017 10:05:41 -0400 (EDT)
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <20170516133233.GB2897@rei.lan>
References: <20170516100759.10355-1-chrubis@suse.cz>
 <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
 <20170516133233.GB2897@rei.lan>
Message-ID: <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > "hugepages-2048kB" in path above will work only on systems with 2M huge
> > pages.
> 
> Do you have a ppc64 numa machine with more than two nodes at hand? Since

Yes, I have access to couple with 4 numa nodes.

> that is the only one where the current code may fail. Both x86_64 and
> aarch64 seems to have 2MB huge pages.

Default huge page for aarch64 is 512M.

# cat /proc/meminfo | grep Hugepagesize
Hugepagesize:     524288 kB

# uname -r
4.11.0-2.el7.aarch64

I think in 4.11 you can't even switch with default_hugepagesz=2M at the moment:
 6ae979ab39a3 "Revert "Revert "arm64: hugetlb: partial revert of 66b3923a1a0f"""

> 
> I would just go with this patch now, and possibly fix more complicated
> corner cases after the release, since this patch is the last problem
> that holds the release from my side.

Can't we squeeze it in? All we need is to use "hpsz" we already have:

  snprintf(path_hugepages_node1, sizeof(path_hugepages_node1),
          "/sys/devices/system/node/node%u/hugepages/hugepages-%dkB/nr_hugepages",
          node1, hpsz);

> 
> Anything else that should be taken care of before the release?

No, this should be last pending patch.

> 
> > > +
> > > +	if (!access(path_hugepages_node1, F_OK)) {
> > > +		SAFE_FILE_SCANF(path_hugepages_node1,
> > > +				"%ld", &orig_hugepages_node1);
> > > +		tst_res(TINFO, "Increasing hugepages pool on node %u to %ld",
> > > +			node1, orig_hugepages_node1 + 4);
> > > +		SAFE_FILE_PRINTF(path_hugepages_node1,
> > > +				 "%ld", orig_hugepages_node1 + 4);
> > 
> > There doesn't seem to be any error if you ask for more:
> > 
> > # echo 20000 >
> > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
> > # cat
> > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
> > 11650
> > 
> > So, maybe we can just read it back and if it doesn't match what we
> > requested,
> > we can TCONF.
> 
> Or we may try to allocate 4 huge pages on both nodes even in a case that
> we set the per-node limits that should catch the problem as well. Is
> that OK with you?

Yes, that should work too.

Regards,
Jan
