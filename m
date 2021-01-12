From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jan 2021 11:29:58 +0100
Subject: [LTP] Holidays and LTP release
In-Reply-To: <X/xi2iBZZFixnCQo@yuki.lan>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <X/b1tUeAVrTpVQBJ@yuki.lan> <X/xi2iBZZFixnCQo@yuki.lan>
Message-ID: <X/16JnZ4MmA6PINI@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> As I anounced last week please consider git frozen for anything but
> important fixes now.

I was thinking about speedup if-mtu-change.sh [1], but unless Alexey ack that it
might be better to wait after the release.

I planned to merge two rewrites to new API (v2 get_mempolicy [2] and v3
multicast packed flood [3]), which are ready, but as there is a git freeze it
can wait after the release.

I'd also like to add some docs to ima_tpm.sh setup when running with
ima_policy=tcb on real HW, if I figure out what's needed.

I might have look into sigwaitinfo01 problems on MUSL.
There is a patch which needs to be rebased [4] (tests and libsigwait were
rewritten to new API). But simply remove all testcases because they does not
work on MUSL is probably no-go. I guess the problem is with using (void *)1 in
in various sigwaitinfo tests in test_bad_address{,2,3}()
(libs/libltpsigwait/sigwait.c).
Maybe use tst_get_bad_addr(NULL) here?

> Also if you haven't done so yet, please test latest git head now and
> report any problems you find.
Going to.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210107120247.31465-1-pvorel@suse.cz/
[2] https://patchwork.ozlabs.org/project/ltp/patch/20210106181735.1588-1-pvorel@suse.cz/
[3] https://patchwork.ozlabs.org/project/ltp/list/?series=216562&state=*
[4] https://patchwork.ozlabs.org/project/ltp/patch/20200529014448.3815022-1-raj.khem@gmail.com/
