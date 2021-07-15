From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 14:07:42 +0200
Subject: [LTP] [PATCH 2/2] broken_ip: TCONF when test run on unsupported
 protocol
In-Reply-To: <57d4c109-d01a-2c7f-39c7-41013e70abf9@bell-sw.com>
References: <20210714140716.1568-1-pvorel@suse.cz>
 <20210714140716.1568-3-pvorel@suse.cz>
 <57d4c109-d01a-2c7f-39c7-41013e70abf9@bell-sw.com>
Message-ID: <YPAlDpkrCoxt5o0q@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> >  TST_TESTFUNC="do_test"
> > +TST_NET_IPV6_ONLY=1

> +TST_IPV6=6 won't work to fix #843?
Sure, it'd fix it. And TST_IPV6= for broken_ip-ihl. That's a simple way to fix
it. But I thought having TST_NET_IPV{4,6}_ONLY=1 would be self descriptive + it
could be later processed with docparse metadata documentation (I plan to
implement docparse for shell).

So it's more a question whether we want to manifest this info.

Kind regards,
Petr

...
> >  TST_TESTFUNC="do_test"
> > +TST_NET_IPV4_ONLY=1
> >  . tst_net.sh

> >  do_test()

> The generic version looks fine:

> Reviewed-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
