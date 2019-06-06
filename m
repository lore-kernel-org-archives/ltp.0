From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Jun 2019 15:43:21 +0200
Subject: [LTP] TST_GET_UNUSED_PORT returns ports < 1024
In-Reply-To: <7b0b763f-0b6b-fb18-7916-d25afdcb5c68@suse.com>
References: <7b0b763f-0b6b-fb18-7916-d25afdcb5c68@suse.com>
Message-ID: <20190606134321.GA30964@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> when using the TST_GET_UNUSED_PORT macro you sometimes get ports lower
> than 1024 which would require a testcase to have the
> CAP_NET_BIND_SERVICE capability (or simply run as root).

Looking at the code as far as I can tell the function returns the port
in the network endianity, which is big endian. Intel CPUs are little
endian, so if you want to print the port you actually have to use
ntohs() function to convert it to the host endianity. And if you are
passing that value in the sockaddr_in structure you must not use the
htons() since the value is already in the correct byte order. And yes
this is horribly confusing, but that's how it is.

I guess that we should write down this piece of information in the
documentation, because it looks like the tst_get_unused_port shell
helper does this incorrectly and prints the raw value instead of
converting it with ntohs().

-- 
Cyril Hrubis
chrubis@suse.cz
