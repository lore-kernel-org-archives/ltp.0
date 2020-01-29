From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Jan 2020 17:10:01 +0100
Subject: [LTP] [PATCH v2] Add a regression test for cve-2017-15649
In-Reply-To: <20200129120231.17375-1-mmoese@suse.de>
References: <20200129120231.17375-1-mmoese@suse.de>
Message-ID: <20200129161001.GA23969@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Michie,

> net/packet/af_packet.c in the Linux kernel before 4.13.6 allows local
> users to gain privileges via crafted system calls that trigger
> mishandling of packet_fanout data structures, because of a race
> condition (involving fanout_add and packet_do_bind) that leads to a
> use-after-free.
> 
> See https://ssd-disclosure.com/archives/3484 for more detail.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks for your work!

Fuzzy sync library changes now LGTM, but I'd Richie or somebody else to double
check.

What a shame it requires Kasan for reproducing.

> +++ b/testcases/cve/Makefile
> @@ -46,5 +46,6 @@ cve-2017-17052:	CFLAGS += -pthread
>  cve-2017-17053:	CFLAGS += -pthread
>  
>  cve-2015-3290:	CFLAGS += -pthread
> +cve-2017-15649: CFLAGS += -pthread

testcases/cve/../../include/tst_fuzzy_sync.h:342: undefined reference to `clock_gettime'

You also need link with -lrt, otherwise it fails to build on very old distros:
cve-2017-15649: LDLIBS += -lrt

Kind regards,
Petr
