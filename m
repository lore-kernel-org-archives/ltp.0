From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Nov 2019 07:02:23 -0500 (EST)
Subject: [LTP] [xfs] 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
In-Reply-To: <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
References: <20191111010022.GH29418@shao2-debian>
 <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
Message-ID: <1108442397.11662343.1573560143066.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > [  135.976643] LTP: starting fs_fill
> > [  135.993912] /dev/zero: Can't open blockdev
> 
> I've looked at the github source but I don't see how to find out what
> command was used when this error occurred so I don't know even how to
> start to work out what might have caused this.
> 
> Can you help me to find the test script source please.

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/fs_fill/fs_fill.c

Setup of that test is trying different file system types, and it looks
at errno code of "mount -t $fs /dev/zero /mnt/$fs".

Test still PASSes. This report appears to be only about extra message in dmesg,
which wasn't there before:

# mount -t xfs /dev/zero /mnt/xfs
# dmesg -c
[  897.177168] /dev/zero: Can't open blockdev

Regards,
Jan

