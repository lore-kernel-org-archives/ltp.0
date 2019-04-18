From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Apr 2019 19:52:41 +0200
Subject: [LTP] Logical Volume Snapshot testcase available
In-Reply-To: <OFD68E2318.9DE59F3A-ON002583E0.00609C96-652583E0.006159E5@notes.na.collabserv.com>
References: <OFD68E2318.9DE59F3A-ON002583E0.00609C96-652583E0.006159E5@notes.na.collabserv.com>
Message-ID: <20190418175241.GC8766@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Is there any test case available for Logical Volume Snapshot (snapshot
> create, snapshot extend,snapshot merge, snapshot restore) ?

There are none in LTP.

There seems to be some tests exercising lvcreate in xfstests:

https://github.com/kdave/xfstests

And I would say that their mailing list is probably better place for
asking this question.

-- 
Cyril Hrubis
chrubis@suse.cz
