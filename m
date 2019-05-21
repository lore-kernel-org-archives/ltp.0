From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 16:47:33 +0200
Subject: [LTP] [RFC PATCH v2] syscalls/sendmmsg: add new test
In-Reply-To: <20190419210637.88522-1-smuckle@google.com>
References: <20190419210637.88522-1-smuckle@google.com>
Message-ID: <20190521144733.GD19326@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Known issues/questions:
>  - This test occasionally gets stuck when the two messages get sent by
>    separate sendmmsg calls. The two sendmmsg calls complete successfully
>    but recvmmsg blocks indefinitely. I am not yet sure what would cause
>    this.

There is a race between the sender and receiver thread, if the sender
thread finishes before the receiver thread binds the socket the packets
are simply dropped since this is SOCK_DGRAM and nobody is listening at
the other side of the socket yet.

You have to synchronize the threads with checkpoints so that the sender
thread does not send anything until the receiver binds the socket.

>  - I have not used tst_get_unused_port() because I'm unsure of how that
>    function should be made available for both the new and old test API?
>    I can just create a duplicate function but is there a cleaner way?

Peter just merged patch that adds this functionality to new library.

You are also missing the SPDX licence identifier and other than this
there are minor coding style violation (hint use checkpatch.pl).

Apart from these the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
