From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Mar 2019 00:04:22 +0100
Subject: [LTP] [PATCH] syscalls/sendmmsg: add new test
In-Reply-To: <20190320021618.36043-1-smuckle@google.com>
References: <20190320021618.36043-1-smuckle@google.com>
Message-ID: <20190320230422.GA9453@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve,

> Test basic functionality of sendmmsg and recvmmsg.
...

> +	retval = sendmmsg(send_sockfd, msg, 2, 0);
Unfortunately we need to have autotools check for sendmmsg() [1]
to fix failure on old distros
/usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c   -lltp -o sendmmsg01
/usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c: In function 'sender_thread':
/usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c:53: warning: implicit declaration of function 'sendmmsg'
/tmp/ccqXXRS6.o: In function `sender_thread':
/usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c:53: undefined reference to `sendmmsg'

> +	if (retval < 0)
> +		tst_brk(TFAIL|TTERRNO, "sendmmsg failed");
> +
> +	return NULL;
> +}


Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/509170474/log.txt
