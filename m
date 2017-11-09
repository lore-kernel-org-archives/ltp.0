From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Nov 2017 00:12:07 +0100
Subject: [LTP] network/stress/ltp_net_stress_ipsec_tcp: problems with IP
 Payload Compression (comp) transform protocol on VTI
In-Reply-To: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
References: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
Message-ID: <20171109231207.x6xaqt6pdl4b6676@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi Alexey,

> I'm trying to debug problems with IP Payload Compression (comp) transform protocol on VTI.
> I.e. tcp4_ipsec_vti03 and tcp6_ipsec_vti03 tests:
> tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
> tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
Using netns, running on various distros (behaving the same).

Kind regards,
Petr
