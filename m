From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Wed, 15 Aug 2018 14:54:58 +0800
Subject: [LTP] [PATCH ltp] runtest/{ltplite,
 stress.part1}: update commands for gf01-30/rwtest01-05
In-Reply-To: <20180726130439.GA12339@dell5510>
References: <20180706084928.6017-1-yixin.zhang@intel.com>
 <20180726130439.GA12339@dell5510>
Message-ID: <20180815065458.GA19549@yixin-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Sorry for late response. I've merge fs_inod01/iogen01 into the v2 of this patch
as you suggested.
The initial reason I created these patches is that I saw there are duplicated
test cases name in same or different runtest files, some of them even with
same name but different commands! To me this bring some difficulty when I try
to manager all test results in a database (same test name but different cmd).

Example in runtest/stress.part1:
nfs01 export VERSION=2 SOCKET_TYPE=udp; nfs01
nfs01 export VERSION=2 SOCKET_TYPE=tcp; nfs01
nfs01 export VERSION=3 SOCKET_TYPE=udp; nfs01
nfs01 export VERSION=3 SOCKET_TYPE=tcp; nfs01

nfs02 export VERSION=2 SOCKET_TYPE=udp; nfs02
nfs02 export VERSION=2 SOCKET_TYPE=tcp; nfs02
nfs02 export VERSION=3 SOCKET_TYPE=udp; nfs02
nfs02 export VERSION=3 SOCKET_TYPE=tcp; nfs02

So I'm trying to clean all these, starting from fs part. I think that will help
if you decide to remove runtest/stress.part[1-3] and runtest/ltplite. If you
like I can alos provide a full list of such kind of tests.

Yixin

On 2018-07-26 at 15:04:39 +0200, Petr Vorel wrote:
> Hi Yixin,
> 
> > gf01-30/rwtest01-05 are orignal defined in runtest file 'fs', and they
> > are updated multiple times in file 'fs' but missed in 'ltplite'/'stress.part1'.
> > So this patch copy all updates to the tests in 'ltplite'/'stress.part1'.
> 
> > Ref:
> > c9dd96e6b2f811dbad119c3558d90cb7dfc3919b
> > 95e8b61433efcefb83699aaf859e92ad2b576373
> > 606e544932248858f65c7ab3061f77c542c07cfe
> 
> > Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> 
> I wonder if we want to keep these runtest/stress.part[1-3] and runtest/ltplite
> files. ATM we don't have feature to include runtest files (among other problems
> with test runner), but keeping this duplicity doesn't look to me.
> 
> 
> Kind regards,
> Petr
