From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 6 Jun 2017 15:05:23 +0300
Subject: [LTP] [RFC PATCH v6 00/11] Simplify network setup + fix some
 network stress tests
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <a3f5cc71-bd91-3de2-4951-ac853e1106e4@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/03/2017 03:00 PM, Petr Vorel wrote:
> Hi,
>
> as it might be uncomfortable to see patches on mailing list, you can also see
> them on github: https://github.com/pevik/ltp/tree/tst_net_vars.v6
>
> changes v5->v6:
>
> Changes in network setup (testcases/lib/tst_net_vars.c):
> * Simplify parsing network and host part of IP. Now it calculate just network
>   part and set host as the rest of what is left from IP.
> * Try to lookup local iface name and prefix in rtnetlink data if prefix not
>   provided in setup (in form of IP/PREFIX). Don't look up for remote prefix and
>   iface name as we would need to setup connection first, but this requires to
>   know them (remote prefix and iface name) for remote connection (or am I
>   missing something?).
Hi Petr,

tst_rhost_run() with "two hosts" setup is using just RHOST
variable (management link) for rsh/ssh, it can have the same
route as IP_RHOST or better something different that won't be
affected by the tests.

Thanks,
Alexey

