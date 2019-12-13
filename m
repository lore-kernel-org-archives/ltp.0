From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Dec 2019 09:55:21 +0100
Subject: [LTP] [Libtirpc-devel] Validity of RPC tests in LTP
In-Reply-To: <9566e015-27d1-8baf-e1c6-7b914923714c@RedHat.com>
References: <20191117131151.GA20302@x230> <20191210215304.GA473173@x230>
 <9566e015-27d1-8baf-e1c6-7b914923714c@RedHat.com>
Message-ID: <20191213085521.GA29513@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve,

[Cc: Cyril, LTP mailing list, and some people connected to RPC libraries]

> Sorry... I was on PTO...
Not a problem, I know you're busy anyway.

> The tests look fine to me... Should be included in the libtirpc git tree?
Hm, IMHO this is better to be part of LTP, so other RPC implementations can be
tested with it.

According to README [1] [2] [3] LTP rpc tests contains:

* basic client-server RPC tests (testcases/network/rpc/basic_tests)
Looking at the code testing rpcinfo, rup, rusers, rusersd, requiring .rhosts
setup => quite outdated but some might still useful to test.
I'd appreciate some feedback to know whether this code is worth of cleanup.
IMHO this code is not interesting for libtirpc at all.

* SUN RPC and TI-RPC tests (testcases/network/rpc/rpc-tirpc)
Code originally written by Cyril Lacabanne in 2007 and later adopted for LTP.
IMHO it can be used to test any SUN RPC implementation. Although not sure if
there is nowadays any other implementation than libtirpc widely used, it still
can be used with:
  * glibc (it has deprecated it's implementation in 2.26, the
--enable-obsolete-rpc switch existed in 2.16, which is kind of deprecation,
but older glibc could be used or new one with RPC still enabled).
  * rpcsvc-proto [4] (Thorsten's rpcsvc-proto also recommends
libtirpc, but maybe somebody still uses it)
  * ntirpc [5] (libtirpc fork ntirpc has been packaged for some major distros
(at least Debian/Ubuntu, Fedora, Gentoo). LTP code doesn't support ntirpc, but
it'd be trivial to to allow to use it [6].
  * Maybe there are other SUN RPC implementations I'm not aware of

If there ever is just a libtirpc as SUN RPC implementation for Linux distros
I'd be for moving this code to LTP. But code quality is bad, it for sure
requires some cleanup in either case.

ATM it uses LTP legacy shell API in rpc_test.sh [7] wrapper and no LTP API in C
code (which contains a lot of duplicity). For the case of moving code into
libtirpc LTP dependencies would be easily removed. In case of staying in LTP
(again, IMHO better, but I might be wrong) I'd be for using new LTP API,
which would cleanup C code a lot [8].

Besides that libtirpc itself might deserve some unit testing code.

Any comments are welcome.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc
[2] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/basic_tests
[3] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc
[4] https://github.com/thkukuk/rpcsvc-proto
[5] https://github.com/nfs-ganesha/ntirpc
[6] https://github.com/linux-test-project/ltp/blob/master/include/lapi/rpc.h
[7] https://github.com/linux-test-project/ltp/blob/master/testcases/network/rpc/rpc-tirpc/rpc_test.sh
[8] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c
