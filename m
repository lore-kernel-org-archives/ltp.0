From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Dec 2016 17:15:44 +0300
Subject: [LTP] [PATCH 1/3] test_net.sh: fix netns when defined
 LHOST_IFACES or RHOST_IFACES
In-Reply-To: <20161222130148.gn2j3vblabp4n446@dell5510>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <f18cb5f0-e5d9-68e8-45c7-262c987aca28@oracle.com>
 <20161222130148.gn2j3vblabp4n446@dell5510>
Message-ID: <a388a121-3402-e274-7b34-05257c56a98d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 12/22/2016 04:01 PM, Petr Vorel wrote:
> Hi Alexey,
>
>> On 12/22/2016 02:04 AM, Petr Vorel wrote:
>>> Tested with:
>>> TST_USE_NETNS=1 LHOST_IFACES=localpeer RHOST_IFACES=remotepeer \
>>>     ./testscripts/network.sh -6
>> Any good reason to do that?
> Yes. Currently if you define LHOST_IFACES and/or RHOST_IFACES netns is defined for
> ltp_ns_veth2 and ltp_ns_veth1, but then there are used new variables => it's not working.
> Or have I overlooked something?

I understand, but why do you need to re-define these interface names?

Thanks,
Alexey

>
> Kind regards,
> Petr

