From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 29 Jun 2020 07:08:14 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/2] tst_device: Add new api
 tst_find_backing_dev(path, dev)
In-Reply-To: <c11e8d9b-bd16-da32-e9eb-490226f4f4c1@cn.fujitsu.com>
References: <20200624113217.GC30917@yuki.lan>
 <1593330123-19631-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1418968619.19068649.1593417390787.JavaMail.zimbra@redhat.com>
 <c11e8d9b-bd16-da32-e9eb-490226f4f4c1@cn.fujitsu.com>
Message-ID: <1904309747.19085433.1593428894028.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > You said "But stat function has problem when filsystem uses virtual block
> > (such as btrfs,fuse, then major numer is 0)." - Why is that a problem
> > for comparison against /proc/self/mountinfo?
> > 
> Yes, you are right. I wrongly think btrfs filesystem affects the 10th
> columu value in /proc/self/mountinfo. In actually, it can show the
> correct backing block dev.

I haven't tested your pasted version, but that approach seems better,
since that should work for any path, not just the mount point.

