From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Sep 2019 14:34:44 +0200
Subject: [LTP] [PATCH] syscalls/shmat03: Remove it from runtest/cve
In-Reply-To: <20190814121328.22999-1-chrubis@suse.cz>
References: <20190814121328.22999-1-chrubis@suse.cz>
Message-ID: <20190927123444.GA28245@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> The original POC[1] and CVE-2017-5669 are not tested by this test
> anymore as it turned out that the CVE was bogus.
Could you put the link, please? Is it this one?
https://marc.info/?l=linux-mm&m=152510978123755&w=2

> And the test became regression test for:

> commit 8f89c007b6dec16a1793cb88de88fcc02117bbbc
> Author: Davidlohr Bueso <dave@stgolabs.net>
> Date:   Fri May 25 14:47:30 2018 -0700

>     ipc/shm: fix shmat() nil address after round-down when remapping

> Hence we will keep the test but remove it from the CVE runtest file and adjust
> the top level comment in the test code.

> [1] https://bugzilla.kernel.org/attachment.cgi?id=252511
>     from https://bugzilla.kernel.org/show_bug.cgi?id=192931

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Petr Vorel <pvorel@suse.cz>
(based on https://marc.info/?l=linux-mm&m=152510978123755&w=2)

Kind regards,
Petr
