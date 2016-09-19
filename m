From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Sep 2016 08:46:13 -0400 (EDT)
Subject: [LTP] [PATCH] readahead02: fix path for read_ahead_kb on raw
 partitions
In-Reply-To: <20160919093755.GA6220@rei.lan>
References: <dcf8a988ac73c339e05a9f3e326c596065ce5d02.1473860921.git.jstancek@redhat.com>
 <20160919093755.GA6220@rei.lan>
Message-ID: <1254607053.319678.1474289173812.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 19 September, 2016 11:37:55 AM
> Subject: Re: [LTP] [PATCH] readahead02: fix path for read_ahead_kb on raw partitions
> 
> Hi!
> > Path to read_ahead_kb is not consistent for all block devices,
> > for example for LVM it's:
> >   /sys/dev/block/$maj:$min/queue/read_ahead_kb
> > but for raw partitions "queue" is only in "parent" device:
> >   /sys/dev/block/$maj:$min/../queue/read_ahead_kb
> > 
> > This patch checks both types and reads first one it can find.
> > Tested on LVM and raw partitions with 4.7.3.
> 
> Fixes the problem for me as well (minus the Btrfs anonymous block
> devices that has to be fixed).
> 
> Acked.

Pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
