From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Feb 2017 00:06:09 +0100
Subject: [LTP] test_net.sh: Require to redefine less variables
Message-ID: <20170216230608.yjdkk2ix3ftleud6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

I wonder, if we could reduce number of variables required user to define, if uses ssh
as transport in testcases/lib/test_net.sh and he's not happy with default ones.

IMHO at least {L,R}HOST_IPV{4,6}_REV, IPV{4,6}_NET_REV could be calculated.

We also expect mask 24 (resp 64), is there a reason for it? I wonder if it wouldn't be
better using client and host addresses with prefix as input and calculating even more
variables from them: IPV{4,6}_NETWORK, {L,R}HOST_IPV{4,6}_HOST, IPV{4,6}_NET_REV,
IPV{4,6}_NET_REV.


Kind regards,
Petr
