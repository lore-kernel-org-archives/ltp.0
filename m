From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Sep 2021 14:32:45 +0200
Subject: [LTP] [PATCH] memcg_subgroup_charge: Remove limiting of parent
In-Reply-To: <20210914083444.23848-1-rpalethorpe@suse.com>
References: <a47ecbd7-ba4a-ff2c-ead9-e731040cb845@jv-coder.de>
 <20210914083444.23848-1-rpalethorpe@suse.com>
Message-ID: <YUCWbfn/cm2Cr2U5@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It is not important how much memory is assigned to the parent
> group. The stated purpose of the test is to check no memory is
> assigned to the child group.
> 
> Also add the usage stats for the memcg_process because it appears
> the test will fail because the starting memory counter already
> includes some buffer/cache on linux-next. I'm not sure this
> is exactly what happens, but displaying the stats might help.

Uff just found that there is a similar patch from Joerg as well:

http://patchwork.ozlabs.org/project/ltp/patch/20191106061808.67330-1-lkml@jv-coder.de/

Either way we should merge one of them to get this finally fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
