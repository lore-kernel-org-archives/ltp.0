From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Oct 2020 14:45:46 +0100
Subject: [LTP] [PATCH 4/5] network/virt: add wireguard01
In-Reply-To: <34dfc67f-5234-a06b-c824-066bc70ecc8a@oracle.com>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
 <20201015122056.20715-4-alexey.kodanev@oracle.com>
 <20201026084939.GE21306@dell5510>
 <34dfc67f-5234-a06b-c824-066bc70ecc8a@oracle.com>
Message-ID: <20201026134546.GA9542@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> >> +	tst_net_run -s "ip route add 128.0.0.0/1 dev ltp_v0"
> > Out of curiosity: why is IPv4 enough? (we test also IPv6)

> Hi Petr,

> Looks like no need for additional route table setup, and overriding
> default route... tst_netload() uses addresses of wireguard device.
> Will remove it.
ack.

> >> +}
> >> +
> >> +wireguard_lib_cleanup()
> >> +{
> >> +	virt_cleanup
> >> +}

> > Why not use just virt_cleanup() ?

> Yes, it's just a wrapper, but it is used in wirguard01/02 tests.
> In case we need additional setup/cleanup we would have to change
> both tests too.

Sure, no problem. Looking forward this patchset to be merged :).
Thanks for your work!

Kind regards,
Petr
