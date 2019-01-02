From: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 2 Jan 2019 09:37:00 +0000
Subject: [LTP] [PATCH 0/2] memcg_stress newlib porting and fixes
In-Reply-To: <20181228183213.36339-1-cristian.marussi@arm.com>
References: <20181228183213.36339-1-cristian.marussi@arm.com>
Message-ID: <de60b79c-f3eb-1464-29f6-03e7db674125@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

reconsidering my own patch series I spotted a change in the porting patch [1/2]
which should not be there since was meant to be part of the fix in [2/2]. At the
same time I think now that the fix itself, beside working fine in my scenario,
it is probably too much of a change of the test setup itself and not the proper
way to address the issue exposed by a swap-less system.
So I'd drop this series and provide a new version as a whole with both patches
rectified.

Thanks

Cristian

On 28/12/2018 18:32, Cristian Marussi wrote:
> This series at first converts memcg stress tests to LTP newlib and
> performs a general cleanup, and then fixes the maximum quantity of
> memory used for allocation on a swap-less system.
> 
> This patch is dependent on [1] since it factors out a common helper
> to cgroup_lib.sh (introduced in [1])
> 
> Cristian Marussi (2):
> 	[LTP] memcg_stress_test.sh: ported to newlib
> 	[LTP] memcg_stress_test.sh: fix memory usage
> 
> [1]: http://lists.linux.it/pipermail/ltp/2018-December/010385.html
> 
> 
> 

