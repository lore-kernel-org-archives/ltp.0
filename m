From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 21 Apr 2017 13:08:09 +0200
Subject: [LTP] [PATCH v3] diotest6: test readv/writev not read/write
In-Reply-To: <20170316085141.16354-1-eguan@redhat.com>
References: <20170316085141.16354-1-eguan@redhat.com>
Message-ID: <20170421130809.19664890@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Eryu,

On Thu, 16 Mar 2017 16:51:41 +0800
"Eryu Guan" <eguan@redhat.com> wrote:

> According to the comments in diotest6, it's supposed to test
> readv/writev syscalls not read/write, which are tested by diotest3.
> 
> Update the case to test readv/writev.

It seems that since this change, the test now takes a lot longer to complete
on SUSE Enterprise and OpenSUSE. Before the change it took a few minutes at
most, now it takes over an hour.

Have you observed this on RHEL and is it expected?

Thank you,
Richard.
