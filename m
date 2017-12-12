From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Dec 2017 10:56:13 +0100
Subject: [LTP] [PATCH v2 2/2] pthread_create-14-1: avoid threads sharing
 stack
In-Reply-To: <1721839199.53982933.1513070765015.JavaMail.zimbra@redhat.com>
References: <a79545c7338fa1e9df27b43dd37d5538360f20c5.1512568550.git.jstancek@redhat.com>
 <3e635415d2f7fd5e79ade01df9214e083a28bc6b.1512568550.git.jstancek@redhat.com>
 <20171211143850.GA12716@rei>
 <1721839199.53982933.1513070765015.JavaMail.zimbra@redhat.com>
Message-ID: <20171212095613.GA12279@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Pushed with long long. I did same change to pthread_detach-4-3,
> where I made the same mistake years ago.
> 
> I'm thinking if we could re-use include/tst_timer.h in open_posix tests.

The timespec/timeval conversions are pretty much portable so it would
make sense to export this interface for open_posix_testsuite as well.

I guess that we may create a header
open_posix_testsuite/include/timerconv.h or something that would be used
as proxy header and would include the tst_timer.h from top level
include. This would make the open posix testsuite dependant on the rest
of the LTP, which hasn't been the case so far, but I have no idea if
someone actually cares.


-- 
Cyril Hrubis
chrubis@suse.cz
