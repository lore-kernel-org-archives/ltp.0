From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Aug 2017 08:48:31 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <20170815123801.GD20715@rei.lan>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <20170815092326.GA20715@rei.lan>
 <420182872.1608763.1502797492172.JavaMail.zimbra@redhat.com>
 <20170815123801.GD20715@rei.lan>
Message-ID: <226751203.1704912.1502801311592.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > Looks like we went off-topic and the zram01.sh test wasn't fixed in the
> > > end and it still fails on ppc64le.
> > > 
> > > I guess I can prepare a patch that checks if there is enough free RAM
> > > for a minimal Btrfs fs but I would still like to obtain the minimal size
> > > from mkfs.btrfs. Does that sound reasonable?
> > 
> > Do you mean these messages from mkfs.btrfs:
> >   "ERROR: minimum size for each btrfs device is 41943040"
> > or some other way to find minimal supported size?
> 
> Do do not know other way that the one used in the original patch, i.e.
> running mkfs.btrfs on /dev/null and parsing the output.
> 
> Or is there something better than that?

Other than picking a number by ourselves, nothing comes to mind.
Numbers from mkfs.btrfs error message seem too low, even 2.5x
larger number still fails:

# modprobe brd rd_nr=1 rd_size=100000
# mkfs.btrfs /dev/ram0 
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

ERROR: not enough free space to allocate chunk

Regards,
Jan
