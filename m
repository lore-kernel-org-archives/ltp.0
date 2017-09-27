From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Sep 2017 15:17:59 +0200
Subject: [LTP] LTP release and code freeze
In-Reply-To: <20170919084849.GA14328@rei>
References: <20170919084849.GA14328@rei>
Message-ID: <20170927131758.GC25847@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Here is a status update for the release:

o the cve patchset will not make it

o I tested the utimensat patch I've done and it seems to work fine
  - it would be nice if anybody else could have a look before it gets
    commited

o the cpuset should be considered for merge as well

Other than that I do not see any blockers.

I would like to release LTP on Friday once the two outstanding issues
are fixed. Is that OK with everyone?

-- 
Cyril Hrubis
chrubis@suse.cz
