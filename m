From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 4 Dec 2020 06:35:56 +0100
Subject: [LTP] [PATCH v3] overcommit_memory: Fix unstable subtest
In-Reply-To: <20201203153030.GE5809@yuki.lan>
References: <20201127071419.20370-1-lkml@jv-coder.de>
 <20201203153030.GE5809@yuki.lan>
Message-ID: <f17f7936-5fd2-b217-e945-1409d9d40eeb@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
> This version looks better. However two (minor) comments for this
> function still apply.
I'll respond to the comments here:
> Why don't we put the first argument on the same line as the MAX( or MIN(
> here? That would be much more compact but still nicely readable.
Will change that
> I do wonder, are the counters flushed if task is migrated between CPUs?
> If so we wouldn't need the multiplication by bcpus.
IIRC, no they are not flushed and there wouldn't be any reason for that. 
These counters are not supposed to account per cpu statistics, they are 
just used to prevent lock contention. If a task is migrated to another 
cpu and it's memory is freed there, the counter may become negative, 
which is perfectly fine.
Additionally this total batch size is the maximum amount, the global 
counter can deviate from the real value. This takes into account all 
processes running on all cpus, because the overcommit limit is a global 
limit, not a per task one.
> Can we please call the get_total_back_size_bytes() in the test setup and
> store the value.
I think I left this in the test function, because there is a slight 
chance, that the value changes over time due to hotplug. If cpus are 
added (really plugged into the system, not only enabled) or if there is 
memory added, the value changes. In vms with memory ballooning, I think 
this is more likely to happen. The cost is not very high, so why add the 
possiblity to break this?

If you are ok with me only changing the formatting of the MIN/MAX stuff, 
I'll send a v4.

J?rg
