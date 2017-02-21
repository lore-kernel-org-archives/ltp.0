From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Feb 2017 12:18:10 +0100
Subject: [LTP] test_net.sh: Require to redefine less variables
In-Reply-To: <e793b0d9-7df2-e57a-5009-060f1704ecdd@oracle.com>
References: <20170216230608.yjdkk2ix3ftleud6@dell5510>
 <7cbae912-5295-00d6-14e4-f1a9f1c4d197@oracle.com>
 <20170221080520.gachulbuwoeqva7a@x230>
 <12180579-3f44-e584-cb4a-4871e781f999@oracle.com>
 <e793b0d9-7df2-e57a-5009-060f1704ecdd@oracle.com>
Message-ID: <20170221111810.qg6e4q4iykyiathn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Ah, I see, we can run them with network.sh which source test_net.sh, OK.

> Though, the left users of these functions are stress/tcp/udp/route and
> multicast stress tests...I'll post updates for the first three soon.
What exactly are you going to do?

I suppose I should wait with this until you do you push your cleanup.
> > So I'd keep all of these variables, just to calculate these with shell
> > script or C binary:
> > IPV{4,6}_NETWORK
> > {L,R}HOST_IPV{4,6}_HOST
> > IPV{4,6}_NET_REV


Kind regards,
Petr
