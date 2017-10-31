From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Oct 2017 13:50:55 +0100
Subject: [LTP] [PATCH v5 08/12] hotplug/memory_hotplug: Exit with TCONF
 when NUMA headers not available
In-Reply-To: <20171028164720.utteq22aykmzhe4x@x230>
References: <20171018111106.17215-1-pvorel@suse.cz>
 <20171018111106.17215-9-pvorel@suse.cz> <20171026110440.GE7806@rei>
 <20171028164720.utteq22aykmzhe4x@x230>
Message-ID: <20171031125055.GN14550@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> How about deleting whole testcases/kernel/hotplug/memory_hotplug directory?
> The only binary from that directory is memtoy, which is indeed not used in
> any runtest file nor any script called by a runtest file.
> 
> It was taken from an upstream project from
> http://devresources.linux-foundation.org/dev/hotplug/, which is now available
> in https://github.com/kosaki/memtoy.

That one seems to be last updated 9 years ago, so it's dead as well. So
the real question is if it's useful or not. We may as well raise the
question on LTP ML and possibly on LMKL as well. Maybe there is someone
using it and can explain if it's useful and how.

-- 
Cyril Hrubis
chrubis@suse.cz
