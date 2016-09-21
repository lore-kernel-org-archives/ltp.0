From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 21 Sep 2016 02:49:53 -0400 (EDT)
Subject: [LTP] Fwd: writev01/03/04 failures with 4.8-rc7 / was: [bug]
 pwritev02 hang on s390x with 4.8.0-rc7
In-Reply-To: <20160920173033.GO2356@ZenIV.linux.org.uk>
References: <57E131E6.1090507@redhat.com>
 <20160920150657.GN2356@ZenIV.linux.org.uk>
 <570490469.234828.1474391501934.JavaMail.zimbra@redhat.com>
 <20160920173033.GO2356@ZenIV.linux.org.uk>
Message-ID: <495415296.315445.1474440593653.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fyi

----- Forwarded Message -----
From: "Al Viro" <viro@ZenIV.linux.org.uk>
To: "Jan Stancek" <jstancek@redhat.com>
Cc: linux-kernel@vger.kernel.org
Sent: Tuesday, 20 September, 2016 7:30:33 PM
Subject: Re: [bug] pwritev02 hang on s390x with 4.8.0-rc7

On Tue, Sep 20, 2016 at 01:11:41PM -0400, Jan Stancek wrote:

> I ran all syscalls tests from LTP, and I see a change in behaviour
> of couple other tests (writev01, writev03 and writev04 [1]) in 4.8.0-rc7.
> 
> These call writev() with partially invalid iovecs, and now fail with
> EFAULT, while with previous -rc6 kernel they returned number of bytes
> written before they encountered invalid iovec record.
> This should be reproducible also on x86.

Known, discussed and considered legitimate.  It's not so much EFAULT vs short
write, it's how far do we shorten the write.  Change consists of removing
an accidental (and undocumented) property of iovec boundaries wrt write
shortening.  Usually an invalid address anywhere in the data we are asked to
write leads to write shortened to the last pagecache boundary (i.e file
position multiple of page size) entirely covered by valid data.  It is
filesystem-dependent and already deep in nasal demon territory.  writev,
pretty much by accident, never shortened past an iovec boundary.  That's
what got changed - now the rules are same as they are for all writes.

Having an LTP test (as opposed to actual real-world code) deliberately
stepping into that and checking how far does the shortening go means just
one thing: update the test.
