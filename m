From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 21 Feb 2017 13:43:43 +0300
Subject: [LTP] test_net.sh: Require to redefine less variables
In-Reply-To: <12180579-3f44-e584-cb4a-4871e781f999@oracle.com>
References: <20170216230608.yjdkk2ix3ftleud6@dell5510>
 <7cbae912-5295-00d6-14e4-f1a9f1c4d197@oracle.com>
 <20170221080520.gachulbuwoeqva7a@x230>
 <12180579-3f44-e584-cb4a-4871e781f999@oracle.com>
Message-ID: <e793b0d9-7df2-e57a-5009-060f1704ecdd@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/21/2017 01:19 PM, Alexey Kodanev wrote:
> On 02/21/2017 11:05 AM, Petr Vorel wrote:
>> Obviously IPV{4,6}_NET_REV are used only in dns-stress test only. A 
>> lot of scripts in
>> network stress tests pass other variables from test_net.sh to 
>> set_ipv4addr, add_ipv6addr,
>> check_icmpv{4,6}_connectivity, ns-icmpv6_sender and probably some 
>> other tests mentioned in
>> testcases/network/stress/ns-tools/00_Descriptions.txt.
>>
>> So I'd keep all of these variables, just to calculate these with 
>> shell script or C binary:
>> IPV{4,6}_NETWORK
>> {L,R}HOST_IPV{4,6}_HOST
>> IPV{4,6}_NET_REV
>
> You are describing some outdated scripts and they don't actually use 
> test_net.sh, or have I missed something?

Ah, I see, we can run them with network.sh which source test_net.sh, OK.

Though, the left users of these functions are stress/tcp/udp/route and
multicast stress tests...I'll post updates for the first three soon.

Thanks,
Alexey

