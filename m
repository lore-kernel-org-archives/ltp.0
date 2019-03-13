From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Mar 2019 10:42:28 +0100
Subject: [LTP] [PATCH v1] rt_sigpending02: reuse code from sigpending02
In-Reply-To: <64d5553d-ac2d-fd8a-03d1-7cd05d1deeeb@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <64d5553d-ac2d-fd8a-03d1-7cd05d1deeeb@google.com>
Message-ID: <20190313094228.GA24870@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> One downside with this multiplexed approach is that we then don't have 
> an entry in the testcases/kernel/syscalls/ directory for all syscalls 
> which can cause some confusion, but that could perhaps be addressed by 
> adding symlinks for the missing ones.

Actually my long term plan is to include metadata in the testcases which
would, among other things, describe which syscalls/libcalls the tests is
excercising and I want this information to be propagated to the test
runner as well, so instead of relying on one binary file per syscall we
would have proper metadata describing the tests.

And the biggest problem here is that it looks that there is very little
interest in investing time into this approach. I've send a (quick and
dirty) RFC patch that tried to show a direction for such work, but
nearly nobody replied to it, so I postponed the work a bit.

See:

http://patchwork.ozlabs.org/project/ltp/list/?series=78493

-- 
Cyril Hrubis
chrubis@suse.cz
