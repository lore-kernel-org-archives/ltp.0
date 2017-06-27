From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Jun 2017 08:04:04 +0200
Subject: [LTP] [RFC PATCH v6 09/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <bf219efe-a926-aa08-c24c-376fc4676556@oracle.com>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-10-pvorel@suse.cz>
 <bf219efe-a926-aa08-c24c-376fc4676556@oracle.com>
Message-ID: <20170627060404.mcj3jzq6mq3bfuja@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thank you for your review, all will be in v7. Just one comment to initialize_if:

> On 06/03/2017 03:00 PM, Petr Vorel wrote:
...
> > -# Initialize the specified interface
> > -command="ifconfig $ifname down mtu 1500 ; ip route flush dev $ifname ; ip addr flush dev $ifname ; ifconfig $ifname up"
> > -
> >  if [ $host_type = lhost ]; then
> >      ( ifconfig $ifname down && \
> >      ip link set mtu 1500 dev $ifname && \

> There are no changes in route IPv6 tests, why do we need this for route
> IPv4?
testcases/network/stress/ns-tools/initialize_if is a legacy script. Instead of fixing it
should it's usage should be replaced by functions from test_net.sh or test_stress_net.sh
and the file deleted.


Kind regards,
Petr
