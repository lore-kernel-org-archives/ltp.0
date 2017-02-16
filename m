From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Feb 2017 23:32:47 +0100
Subject: [LTP] [PATCH v2 4/4] network: migrate rpc_test.sh to use
	test_net.sh
In-Reply-To: <0995acb3-33c4-7b3c-2b4a-5c24b024e0bd@oracle.com>
References: <20170208144500.27340-1-pvorel@suse.cz>
 <20170208144500.27340-4-pvorel@suse.cz>
 <0995acb3-33c4-7b3c-2b4a-5c24b024e0bd@oracle.com>
Message-ID: <20170216223247.e6xad5dnjdimcql7@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for you review, I'll post v3 with your changes.

> > Many tests are failing when using netns.

> I tried to run this tests in netns, it seems that rpcbind (listening
> port)not available in netns as a results tests are failing. If we
> make the clientrun in network namespace, tests pass. Actually, I had
> only twofailures:

> rpc_test.sh -c rpc_xprt_register
> [...]
> rpc_xprt_register 1 TBROK : 'rpc_xprt_register 10.0.0.2 536875000 '
> failed on '': 'rpc_xprt_register: svc_fd_create: could not retrieve
> local addr
> rpc_xprt_register: svc.c:96: xprt_register: Assertion `xprt != ((void
> *)0)' failed.
> sh: line 1: 20123 Aborted                 (core dumped)
> rpc_xprt_register 10.0.0.2 536875000'

> and the similar one:
> rpc_test.sh -c rpc_xprt_unregister

I got these errors:
* -c (TI-RPC tests)
rpc_clnt_broadcast 1 TBROK: 'rpc_clnt_broadcast 10.0.0.2 536875000 ' failed on '': 'RPC: Timed out
rpc_svc_destroy 1 TBROK: 'rpc_svc_destroy 10.0.0.2 536875000 ' failed on '': 'rpc_svc_destroy: svc_fd_create: could not retrieve local addr
rpc_svcfd_create 1 TBROK: 'rpc_svcfd_create 10.0.0.2 536875000 ' failed on '': 'rpc_svcfd_create: svc_fd_create: could not retrieve local addr
rpc_xprt_register 1 TBROK: 'rpc_xprt_register 10.0.0.2 536875000 ' failed on '': 'rpc_xprt_register: svc_fd_create: could not retrieve local addr
rpc_xprt_unregister 1 TBROK: 'rpc_xprt_unregister 10.0.0.2 536875000 ' failed on '': 'rpc_xprt_unregister: svc_fd_create: could not retrieve local addr

* -d (TS-RPC tests)
tirpc_authdes_create 1 TBROK: 'tirpc_authdes_create 10.0.0.2 536875000 ' failed on '': '1'
tirpc_authdes_seccreate 1 TBROK: 'tirpc_authdes_seccreate 10.0.0.2 536875000 ' failed on '': '1'

I tested it with libtirpc3 1.0.1-3 from Tumbleweed and with libtirpc1 0.2.5-1.1 on Debian
testing.
I wonder whether 'svc_fd_create: could not retrieve local addr' which comes from libtirpc
[1] is our bug or libtirpc bug or netns bug.
BTW there is also another library called ntirpc, which might be useful to test [2].

[1] http://git.linux-nfs.org/?p=steved/libtirpc.git;a=blob;f=src/svc_vc.c;h=97a76a357c7befcd2fae1a1e836506412abf0ae3;hb=HEAD#l232
[2] https://github.com/linuxbox2/ntirpc


Kind regards,
Petr
