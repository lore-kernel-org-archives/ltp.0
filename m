From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Feb 2016 12:53:53 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz>
 <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
Message-ID: <20160218115353.GD19157@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I think that disabling the possibility just to make writing the test
> > library a bit easier is pretty bad idea. Most of the testcases we have
> > can run in parallel just fine. There are only a few that stress the
> > system to the limit or use global resources (devices, IPC, change system
> > time, ...) and if we anotate these tests we can easily speed up the test
> > run five times just by running most of the testcases in parallel.
> 
> I wasn't suggesting we do that. I was thinking about making ipc filename
> more unique for each instance, in case we wouldn't have /proc and test
> cleanup doesn't run for whatever reason. That of course would make
> ipc file names less predictable.

If we decide to pass the filename around we can just add arbitrarily
large random string to the name. But the more I think about it the more
it looks like classical chicken egg problem. We cannot pass it without
IPC but we cannot do that easily before IPC is initialized and the
environment variable is probably the best bet.

-- 
Cyril Hrubis
chrubis@suse.cz
