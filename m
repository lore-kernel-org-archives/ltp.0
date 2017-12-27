From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Dec 2017 16:01:20 +0100
Subject: [LTP] [RFC] mce-test
Message-ID: <20171227150120.GA8632@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

we have submodule mce-test [1], cloned into testcases/kernel/mce-test.
This project has been added in 2010, later transformed into git submodule, but never
fully integrated into LTP.

I've played with it to update it and integrate it into our build system.
But to be fully working (e.g. have runtest file) we'd need to include mcelog as well.

While this is feasible and both projects looks healthy the question is whether it make
sense to have it in our source tree. I'd delete it.


Kind regards,
Petr

[1] http://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git
[2] http://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git
