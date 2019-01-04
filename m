From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 4 Jan 2019 16:20:44 +0000
Subject: [LTP] [PATCH v2 0/1] memcg_stress newlib porting
In-Reply-To: <20190103121128.17395-1-cristian.marussi@arm.com>
References: <20190103121128.17395-1-cristian.marussi@arm.com>
Message-ID: <3056b183-98be-d73c-7d95-04d0e5b01389@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Superseeded by v3.

Cristian

On 03/01/2019 12:11, Cristian Marussi wrote:
> This converts memcg stress tests and its helper to LTP newlib and
> performs a general cleanup.
> 
> This patch is dependent on [1] since it factors out a common helper
> to cgroup_lib.sh (introduced in [1])
> 
> Changes from v1:
> ----------------
> 
>  - Restored the original usage of SIGKILL to terminate memcg_process_stress
>    helpers preocesses, after having had a look at what said in previous commit:
> 	9b9a6bb10258bc975bd1707b418699264d3bdcef
> 
> Cristian Marussi (1):
> 	[PATCH v2] [LTP] memcg_stress_test.sh: ported to newlib
> 
> [1]: http://lists.linux.it/pipermail/ltp/2018-December/010385.html
> 
> 
> 

