From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Jul 2018 15:04:39 +0200
Subject: [LTP] [PATCH ltp] runtest/{ltplite,
 stress.part1}: update commands for gf01-30/rwtest01-05
In-Reply-To: <20180706084928.6017-1-yixin.zhang@intel.com>
References: <20180706084928.6017-1-yixin.zhang@intel.com>
Message-ID: <20180726130439.GA12339@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,

> gf01-30/rwtest01-05 are orignal defined in runtest file 'fs', and they
> are updated multiple times in file 'fs' but missed in 'ltplite'/'stress.part1'.
> So this patch copy all updates to the tests in 'ltplite'/'stress.part1'.

> Ref:
> c9dd96e6b2f811dbad119c3558d90cb7dfc3919b
> 95e8b61433efcefb83699aaf859e92ad2b576373
> 606e544932248858f65c7ab3061f77c542c07cfe

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>

I wonder if we want to keep these runtest/stress.part[1-3] and runtest/ltplite
files. ATM we don't have feature to include runtest files (among other problems
with test runner), but keeping this duplicity doesn't look to me.


Kind regards,
Petr
