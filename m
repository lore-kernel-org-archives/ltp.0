From: Eryu Guan <eguan@redhat.com>
Date: Fri, 21 Apr 2017 19:19:39 +0800
Subject: [LTP] [PATCH v3] diotest6: test readv/writev not read/write
In-Reply-To: <20170421130809.19664890@linux-v3j5>
References: <20170316085141.16354-1-eguan@redhat.com>
 <20170421130809.19664890@linux-v3j5>
Message-ID: <20170421111939.GD26397@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Apr 21, 2017 at 01:08:09PM +0200, Richard Palethorpe wrote:
> Hello Eryu,
> 
> On Thu, 16 Mar 2017 16:51:41 +0800
> "Eryu Guan" <eguan@redhat.com> wrote:
> 
> > According to the comments in diotest6, it's supposed to test
> > readv/writev syscalls not read/write, which are tested by diotest3.
> > 
> > Update the case to test readv/writev.
> 
> It seems that since this change, the test now takes a lot longer to complete
> on SUSE Enterprise and OpenSUSE. Before the change it took a few minutes at
> most, now it takes over an hour.
> 
> Have you observed this on RHEL and is it expected?

No, I didn't see a longer run time of diotest6 itself on RHEL6/7.

But I enabled dio30, which runs "diotest6 -b 65536 -n 100 -i 1000 -o
1024000" and takes longer time (from 10 minutes to 1 hour, depends on
your host configuration), see commit 71f253f7d74d ("runtest/dio: enable
dio29/30"). Is this your case?

Thanks,
Eryu
