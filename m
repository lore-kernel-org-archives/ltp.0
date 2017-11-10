From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Nov 2017 20:31:09 +0100
Subject: [LTP] network/stress/ltp_net_stress_ipsec_tcp: problems with IP
 Payload Compression (comp) transform protocol on VTI
In-Reply-To: <760c45ad-6802-400d-c527-818d599ffa12@oracle.com>
References: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
 <760c45ad-6802-400d-c527-818d599ffa12@oracle.com>
Message-ID: <20171110193109.jpsy3w47ffh4y5fs@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Any idea what can cause it? Tests tcp{4,6}_ipsec_vti02 running with esp protocol on VTI
> > work well.

> Server killed by LTP timeout in this case, looks like there
> is no incoming connections... I'll take a look.
If it helps you I can send you strace logs from both client and server.

Client cannot connect and it also fails with timeout:
safe_net.c:216: BROK: netstress.c:272: connect(5, 10.23.1.2:7108, 16) failed: ETIMEDOUT

I have no clue what prevents it connecting.

Kind regards,
Petr
