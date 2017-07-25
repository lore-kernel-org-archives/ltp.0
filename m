From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 25 Jul 2017 14:22:15 +0200
Subject: [LTP] [PATCH v3 1/9] Add fuzzy synchronisation library for
	triggering races
In-Reply-To: <20170623122211.29575-2-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-2-rpalethorpe@suse.com>
Message-ID: <87fudkg0zs.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


So, I have had some feedback on the synchronisation library from Nicolai
Stange and there are few things which can be fixed or improved. I can't
necessarily do them straight away so I will list some of them here.

* Make the target (offset) time a range instead of a scalar value.
* Make target offset relative to CPU speed.
* Take tv_sec into account for when we are close to rolling from one
  second to the next.
* Use two long running threads instead of starting the second thread
  each iteration.

The target offset would be better as a range which we can slide over
until the right timing is found. However the appropriate time range will
be different for one system to the next, so this range should be
normalised or we could generate it based on the time a relevant syscall
takes to execute.

Just using the nano seconds from the timespec will result in occasional
errors when the two timestamps are taken on either side of the boundary
between two seconds e.g. a = 0.9999 and b = 1.0001.

Finally, we currently spin up a new child thread every
iteration. However we could have two long running threads, or processes,
which we synchronise every iteration using a second synchronisation
primitive (The fork synchronisation library in LTP may already be
suitable for this). This may reduce the variability between iterations.

--
Thank you,
Richard.
