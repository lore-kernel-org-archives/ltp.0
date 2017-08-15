From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Aug 2017 07:44:52 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <20170815092326.GA20715@rei.lan>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <20170815092326.GA20715@rei.lan>
Message-ID: <420182872.1608763.1502797492172.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> Looks like we went off-topic and the zram01.sh test wasn't fixed in the
> end and it still fails on ppc64le.
> 
> I guess I can prepare a patch that checks if there is enough free RAM
> for a minimal Btrfs fs but I would still like to obtain the minimal size
> from mkfs.btrfs. Does that sound reasonable?

Do you mean these messages from mkfs.btrfs:
  "ERROR: minimum size for each btrfs device is 41943040"
or some other way to find minimal supported size?

Regards,
Jan
