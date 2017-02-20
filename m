From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Feb 2017 13:31:00 +0300
Subject: [LTP] test_net.sh: Require to redefine less variables
In-Reply-To: <20170216230608.yjdkk2ix3ftleud6@dell5510>
References: <20170216230608.yjdkk2ix3ftleud6@dell5510>
Message-ID: <7cbae912-5295-00d6-14e4-f1a9f1c4d197@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17.02.2017 2:06, Petr Vorel wrote:
> Hi Alexey,
>
> I wonder, if we could reduce number of variables required user to define, if uses ssh
> as transport in testcases/lib/test_net.sh and he's not happy with default ones.
>
> IMHO at least {L,R}HOST_IPV{4,6}_REV, IPV{4,6}_NET_REV could be calculated.
>
> We also expect mask 24 (resp 64), is there a reason for it?I wonder if it wouldn't be
> better using client and host addresses with prefix as input and calculating even more
> variables from them: IPV{4,6}_NETWORK, {L,R}HOST_IPV{4,6}_HOST, IPV{4,6}_NET_REV,
> IPV{4,6}_NET_REV.
Hi Petr,

That would be a nice feature to have of cause, regarding this variables:

IPV{4,6}_NETWORK
{L,R}HOST_IPV{4,6}_HOST

and afaik they only used in test_net.sh to make up host addresses, so we can easily get rid of them and use only two variables with non-default subnets (optional).

Thanks,
Alexey

