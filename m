From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Jan 2018 13:54:44 +0100
Subject: [LTP] [RFC] mce-test
In-Reply-To: <20171227150120.GA8632@x230>
References: <20171227150120.GA8632@x230>
Message-ID: <20180103125443.GB23817@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> we have submodule mce-test [1], cloned into testcases/kernel/mce-test.
> This project has been added in 2010, later transformed into git submodule, but never
> fully integrated into LTP.
> 
> I've played with it to update it and integrate it into our build system.
> But to be fully working (e.g. have runtest file) we'd need to include mcelog as well.

Well mcelog is supposedly part of most of the distributions these days
and even pre-installed at least on machines with x86* processors.

The bigger problem with the testsuite is, that as far as I remeber, at
least half of the testcases were injecting hardware faults to the kernel
and required crashdump to be set up correctly and also the framework
that is supposed to run these tests outliving kernel crashes.

> While this is feasible and both projects looks healthy the question is whether it make
> sense to have it in our source tree. I'd delete it.

That's a good question. Maybe we should just replace the test with a
README that contains an URL pointing to the project.

-- 
Cyril Hrubis
chrubis@suse.cz
