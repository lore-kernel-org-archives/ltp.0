From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Sep 2019 19:02:25 +0200
Subject: [LTP] [PATCH 2/2] Add connection tests for bind()
In-Reply-To: <20190919145911.22278-3-mdoucha@suse.cz>
References: <20190919145911.22278-1-mdoucha@suse.cz>
 <20190919145911.22278-3-mdoucha@suse.cz>
Message-ID: <20190923170225.GA10355@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Add two new test programs to verify that bind() will open sockets for incoming
> connections. Both programs follow the same test scenario:
> - Create and bind() a socket
> - Wait for connection from peer thread
> - Send request to peer thread
> - Receive and verify response from peer thread

> bind04 tests stream-oriented sockets (SOCK_STREAM and SOCK_SEQPACKET).
> bind05 tests datagram-oriented sockets (SOCK_DGRAM).

> Both programs test the following socket types:
> - AF_UNIX (pathname and abstract addresses)
> - AF_INET (loopback)
> - AF_INET6 (loopback)

I'd drop libbind.c and move content into libbind.h, using inline functions.

Both tests also share a lot of code. I understand you don't want to mix TCP and
UDP tests (I would probably do), but could you at least move setup() and constants into libbind.h?

I'd also test:
IPPROTO_SCTP (SOCK_STREAM) for TCP and
IPPROTO_UDPLITE (SOCK_DGRAM) for UDP.

+ test some protocols for other sock types: 
IPPROTO_SCTP (SOCK_STREAM).

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
