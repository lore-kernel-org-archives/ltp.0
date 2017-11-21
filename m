From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Nov 2017 20:13:31 +0100
Subject: [LTP] network/stress/ltp_net_stress_ipsec_tcp: problems with IP
 Payload Compression (comp) transform protocol on VTI
In-Reply-To: <2a2ec01b-f374-835f-ba32-a65c370c4cd5@oracle.com>
References: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
 <760c45ad-6802-400d-c527-818d599ffa12@oracle.com>
 <20171110193109.jpsy3w47ffh4y5fs@x230>
 <2a2ec01b-f374-835f-ba32-a65c370c4cd5@oracle.com>
Message-ID: <20171121191330.nagcpuxwv2mmglwz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for investigation!

> ipcomp actually works with vti, what doesn't work is the packets that
> are not compressed/transformed (small packets skipped onthreshold)
> and sent as is... and vti doesn't register any hooksfor handling them
> (only ah, esp, comp) + xfrm stats XfrmInNoPols increased.

> As a workaround we could add to ipcomp setup:
> ROD sysctl net.ipv4.conf.$(tst_iface).disable_policy=1

> Though I think the packet should be handled by vti device and the
> proper hook registered... I'll try to prepare the patch for netdev
> and we can continue discussion there about this problem.
Please, CC me.

> Also we could change/add the test-case with a more real-life scenario
> where the packet compressed, then encrypted.
Good idea! Are you planning to do it yourself?


Kind regards,
Petr
