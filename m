From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Nov 2017 18:14:58 +0300
Subject: [LTP] network/stress/ltp_net_stress_ipsec_tcp: problems with IP
 Payload Compression (comp) transform protocol on VTI
In-Reply-To: <20171110193109.jpsy3w47ffh4y5fs@x230>
References: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
 <760c45ad-6802-400d-c527-818d599ffa12@oracle.com>
 <20171110193109.jpsy3w47ffh4y5fs@x230>
Message-ID: <2a2ec01b-f374-835f-ba32-a65c370c4cd5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/10/2017 10:31 PM, Petr Vorel wrote:
> Hi Alexey,
>
>>> Any idea what can cause it? Tests tcp{4,6}_ipsec_vti02 running with esp protocol on VTI
>>> work well.
>> Server killed by LTP timeout in this case, looks like there
>> is no incoming connections... I'll take a look.
> If it helps you I can send you strace logs from both client and server.
>
> Client cannot connect and it also fails with timeout:
> safe_net.c:216: BROK: netstress.c:272: connect(5, 10.23.1.2:7108, 16) failed: ETIMEDOUT

ipcomp actually works with vti, what doesn't work is the packets that
are not compressed/transformed (small packets skipped onthreshold)
and sent as is... and vti doesn't register any hooksfor handling them
(only ah, esp, comp) + xfrm stats XfrmInNoPols increased.

As a workaround we could add to ipcomp setup:
ROD sysctl net.ipv4.conf.$(tst_iface).disable_policy=1

Though I think the packet should be handled by vti device and the
proper hook registered... I'll try to prepare the patch for netdev
and we can continue discussion there about this problem.

Also we could change/add the test-case with a more real-life scenario
where the packet compressed, then encrypted.

Thanks,
Alexey

