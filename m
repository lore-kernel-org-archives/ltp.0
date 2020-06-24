From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Jun 2020 09:06:12 -0400 (EDT)
Subject: [LTP] [PATCH v3] syscalls/ioctl_loop05: Use correct blockdev to
 get logical_block_size
In-Reply-To: <20200624113217.GC30917@yuki.lan>
References: <660069492.15476972.1591794243308.JavaMail.zimbra@redhat.com>
 <1591853524-17011-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200624113217.GC30917@yuki.lan>
Message-ID: <1699837077.18529566.1593003972656.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Looking at what that command does it's not that complex. It does
> statfs() to get minor and major number, then scans /proc/self/mountinfo
> for these, since these are on third column and then just prints whatever
> it's in the 10th column. This isn't more complex that what we have here
> and avoids needs to execute binaries and parse the output.

Thanks for mountinfo pointer. We went down the stat() route already,
but hit issues with some filesystems. I tried it now with mountinfo
approach and that does seem to fix btrfs case too, so I agree that
parsing /proc/self/mountinfo rather than df output is nicer.

