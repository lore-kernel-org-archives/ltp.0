From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 21 Feb 2017 14:36:34 +0300
Subject: [LTP] test_net.sh: Require to redefine less variables
In-Reply-To: <20170221111810.qg6e4q4iykyiathn@dell5510>
References: <20170216230608.yjdkk2ix3ftleud6@dell5510>
 <7cbae912-5295-00d6-14e4-f1a9f1c4d197@oracle.com>
 <20170221080520.gachulbuwoeqva7a@x230>
 <12180579-3f44-e584-cb4a-4871e781f999@oracle.com>
 <e793b0d9-7df2-e57a-5009-060f1704ecdd@oracle.com>
 <20170221111810.qg6e4q4iykyiathn@dell5510>
Message-ID: <74449936-041d-14f0-068d-91030f71ec3c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/21/2017 02:18 PM, Petr Vorel wrote:
> Hi Alexey,
>
>> Ah, I see, we can run them with network.sh which source test_net.sh, OK.
>> Though, the left users of these functions are stress/tcp/udp/route and
>> multicast stress tests...I'll post updates for the first three soon.
> What exactly are you going to do?
>
> I suppose I should wait with this until you do you push your cleanup.

Update to source test_net.sh and ipsec_lib.sh. It's not necessary to wait,
these tests still can be run as is by exporting old-style variables.

Thanks,
Alexey

