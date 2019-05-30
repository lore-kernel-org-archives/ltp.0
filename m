From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 May 2019 21:00:13 +0200
Subject: [LTP] TST_GET_UNUSED_PORT returns ports < 1024
In-Reply-To: <7b0b763f-0b6b-fb18-7916-d25afdcb5c68@suse.com>
References: <7b0b763f-0b6b-fb18-7916-d25afdcb5c68@suse.com>
Message-ID: <20190530190012.GA32123@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Christian,

> Hi,

> when using the TST_GET_UNUSED_PORT macro you sometimes get ports lower
> than 1024 which would require a testcase to have the
> CAP_NET_BIND_SERVICE capability (or simply run as root).
That surprised me. I thought using bind() with non-root user doesn't do that,
but need to check the implementation in the kernel.

> Of course you could write a wrapper like the following to avoid that
> issue, but in my opinion it would be nice to have the option to get
> non-root ports directly from the library.

> /* Wrapper to to get a non-root port if necessary */
> static int get_port(uid_t uid)
> {
>         static int count = 10;
>         int port;

>         port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
>         if (port < 1000 && uid != 0) {
>                 if (!count)
>                         tst_brk(TBROK, "Could not get fitting port");
>                 count--;
>                 return get_port(uid);
>         }
>         return port;
> }

> Kind regards,

> Christian


Kind regards,
Petr
