From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 29 Jun 2020 03:56:30 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/2] tst_device: Add new api
 tst_find_backing_dev(path, dev)
In-Reply-To: <1593330123-19631-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200624113217.GC30917@yuki.lan>
 <1593330123-19631-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1418968619.19068649.1593417390787.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +This function finds the block dev that this path belongs to, it compares
> path buf
> +with the fifth column of each row in "/proc/self/mountinfo" and list 10th
> column
> +as its block dev.

Why not match major/minor numbers?

You said "But stat function has problem when filsystem uses virtual block
(such as btrfs,fuse, then major numer is 0)." - Why is that a problem
for comparison against /proc/self/mountinfo?

