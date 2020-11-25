From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2020 12:54:06 +0100
Subject: [LTP] [PATCH] fzsync: skip test when avaliable CPUs less than 2
In-Reply-To: <87eekhof3i.fsf@suse.de>
References: <20201125101633.30154-1-liwang@redhat.com> <87eekhof3i.fsf@suse.de>
Message-ID: <20201125115406.GD2297@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Perhaps this test would pass with more loops and a big enough delay
> range, but this is also wasting time on a single vCPU. I'm not sure
> whether we should filter this test at the LTP level; it may trigger the
> bug on some single CPU configs.
> 
> Why not print a warning instead of refusing to run?

That's not a solution either, warning would end up in a test results as
well.

I guess that we can add something as .min_cpus to the tst_test structure
and set it for this test?

-- 
Cyril Hrubis
chrubis@suse.cz
