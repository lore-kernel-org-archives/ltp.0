From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Sep 2017 14:54:35 +0200
Subject: [LTP] [PATCH v3 3/7] fzsync: Add long running thread support
 and deviation stats
In-Reply-To: <87mv5wyvjj.fsf@our.domain.is.not.set>
References: <20170901130121.22821-1-rpalethorpe@suse.com>
 <20170901130121.22821-3-rpalethorpe@suse.com>
 <20170912144325.GE29720@rei> <87o9qcz37r.fsf@our.domain.is.not.set>
 <87mv5wyvjj.fsf@our.domain.is.not.set>
Message-ID: <20170915125435.GD1168@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Actually this has a race condition if one thread is interrupted after
> setting other_cntr to zero, but before it enters the while loop.

Can't we simply reset these counters between test iterations?

-- 
Cyril Hrubis
chrubis@suse.cz
