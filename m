From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2021 13:03:56 +0100
Subject: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge
 systems
In-Reply-To: <20210127115606.28985-1-mdoucha@suse.cz>
References: <20210127115606.28985-1-mdoucha@suse.cz>
Message-ID: <YBFWrJoS1tVmWGFx@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Actually I've been thinking about this one and since this is a strictly
best effort action I think we should be more aggressive about the safety
margin.

I also started to talk to kernel developers about this and generally
about tests that try to allocate maximal amount of memory without
triggering OOM since we have a few in the tree. I will send the results
of this discussion once I have any here as well.

-- 
Cyril Hrubis
chrubis@suse.cz
