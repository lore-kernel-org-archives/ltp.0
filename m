From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Nov 2015 18:55:55 +0100
Subject: [LTP] controllers/memcg_stress: Does not work correctly?
In-Reply-To: <20151118153443.GH19145@dhcp22.suse.cz>
References: <330BE2030BD7834286495D8B7FCF1FB71D30473D@mbx02.itr.canon-is.co.jp>
 <20151116115729.GB17888@rei.suse.cz>
 <20151118153443.GH19145@dhcp22.suse.cz>
Message-ID: <20151118175554.GB15346@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am not sure I understand what is the actual problem. Swap off system
> will not have any swap available. Or did you mean that the swap off will
> happen during the test? If yes then the test case is clearly not
> prepared for that and it would get killed by the OOM killer.

As far as I understand this the problem is that the test may cause OOM
unexpectedly on systems without swap.

> I am not entirely sure I understand the purpose of the test case but it
> seems it just wants to generate the global memory pressure via memcg
> loads. Whether that is a useful test is hard to judge. What is the
> pass/fail metric? If the failure is the OOM killer then this is
> extremely fragile because of what Cyril mentions below:

These testcases were added to LTP way back in 2009 and there is no
reasonable description what the stress test is trying to achieve. All it
does, as you said, is to create global memory pressure via processes in
memcg subroups, excersizes the memory for a while by writing it and then
if the main process manages to kill all the worker processes it's a
pass. So it looks like the only pass/fail metric is whether the system
(i.e. the main script) outlives the memory pressure for one hour.

So this test doesn't really do anything smart enough to stress the memcg
cgroups. If you have better ideas how to stress memcg I would love to
hear them.

-- 
Cyril Hrubis
chrubis@suse.cz
