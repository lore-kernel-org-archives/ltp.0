From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Mar 2019 18:24:54 +0100
Subject: [LTP] [PATCH v3 2/2] sigpending/rt_sigpending: add basic test
In-Reply-To: <20190319113153.13436-3-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <20190319113153.13436-1-maennich@google.com>
 <20190319113153.13436-3-maennich@google.com>
Message-ID: <20190319172454.GA1283@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Matthias,

> +	for (int i = 1; i < SIGMAX; ++i)
Please define i before.
Old distros using old C standards (probably -std=gnu89) by default, which breaks
build [1]:

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -DTEST_RT_SIGPENDING -I../../../../include -I../../../../include -I../../../../include/old/   -L../../../../lib  /usr/src/ltp/testcases/kernel/syscalls/rt_sigpending/../sigpending/sigpending02.c   -lltp -o rt_sigpending02
/usr/src/ltp/testcases/kernel/syscalls/rt_sigpending/../sigpending/sigpending02.c: In function 'test_sigpending':
/usr/src/ltp/testcases/kernel/syscalls/rt_sigpending/../sigpending/sigpending02.c:67:2: error: 'for' loop initial declarations are only allowed in C99 or C11 mode
  for (int i = 1; i < SIGMAX; ++i)
  ^
/usr/src/ltp/testcases/kernel/syscalls/rt_sigpending/../sigpending/sigpending02.c:67:2: note: use option -std=c99, -std=gnu99, -std=c11 or -std=gnu11 to compile your code
/usr/src/ltp/testcases/kernel/syscalls/rt_sigpending/../sigpending/sigpending02.c:82:11: error: redefinition of 'i'

...
> +	/* now we should have exactly one pending signal (SIGUSR1) */
> +	sigemptyset(&pending);
> +	tested_sigpending(&pending);
> +	for (int i = 1; i < SIGMAX; ++i)
> +		if ((i == SIGUSR1) != sigismember(&pending, i))
> +			tst_brk(TFAIL, "only SIGUSR1 should be pending by now");


Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/508433905/log.txt
