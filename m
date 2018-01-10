From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Jan 2018 12:17:57 +0100
Subject: [LTP] [RFC PATCH 0/2] Allow to compile on archs without atomic
 support
In-Reply-To: <20180110110946.GC18314@rei>
References: <20180104204250.7032-1-pvorel@suse.cz>
 <754978231.4598218.1515424172751.JavaMail.zimbra@redhat.com>
 <20180110110946.GC18314@rei>
Message-ID: <20180110111756.dylkic3zrmjpqcut@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > What if we made general implementation with some locking? It would be
> > slower, but I think we don't use atomics that much for it to matter.

> Atomic increment was easiest way how to make the test library thread
> safe I wasn't concerned with speed at all. But that is not true for the
> CVE tests which use atomic operation to synchronize threads to trigger
> races.
That's why I implemented it in v1 as simple exit(). So are we ok that CVE tests will
probably be failing / taking so long?

Thank you both, for considering it, as I know it's only corner case.


Kind regards,
Petr
