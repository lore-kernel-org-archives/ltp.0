From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Sep 2016 15:51:41 +0200
Subject: [LTP] LTP Release
In-Reply-To: <1752509375.543819.1473857976139.JavaMail.zimbra@redhat.com>
References: <20160914112947.GA7366@rei>
 <1752509375.543819.1473857976139.JavaMail.zimbra@redhat.com>
Message-ID: <20160914135141.GA27979@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we slould fix the lsmod test failing on NFS before the
> > release.
> > 
> > Anything else?
> 
> There was a report about readahead02 using wrong path for "read_ahead_kb",
> when running on raw partitions. Patch seems simple, I just need to test it,
> I'll try to do that today.

Ah that one. I should fix it for Btrfs as well as Btrfs uses anonymous
block devices and the sysfs is not populated for these. We have to get
link to the device from /sys/fs/btrfs/<fsid>/devices.

-- 
Cyril Hrubis
chrubis@suse.cz
