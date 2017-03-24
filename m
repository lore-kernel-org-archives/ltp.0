From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Mar 2017 17:12:40 +0100
Subject: [LTP] pmap_clnt.h not included in rpc.h
Message-ID: <20170324161240.GA20022@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
While compiling a rpc test server[1] we get implicit declaration warning
for pmap_unset(). The question is if the pmap_*.h headers should be
included in rpc.h or not, i.e. if this is a bug in the test or in the
glibc header.

The man pmap_unset redirects to rpc(3) and that manual page explicitly
says 'To take use of these routines, include the header file
<rpc/rpc.h>'. The tirpc version of the rpc.h includes the rpc/pmap_*.h
headers as well. Which both hints that the glibc version of the rpc.h
header should include the portmap headers as well. But I'm not 100% sure
hence asking here.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/network/rpc/basic_tests/rpc01/rpc_server.c

-- 
Cyril Hrubis
chrubis@suse.cz
