From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 19 Nov 2020 13:05:36 +0100
Subject: [LTP] [PATCH v2 1/3] network/stress/multicast/packet-flood:
 Update to new API
In-Reply-To: <5f17f668-87c3-cd89-fdd9-7d6835b8ba65@oracle.com>
References: <20201117124320.783802-1-lkml@jv-coder.de>
 <057bc703-d3b6-5d8a-4831-609e332fdc36@oracle.com>
 <98732a50-84e4-97b2-5124-757d91eba7a4@jv-coder.de>
 <5f17f668-87c3-cd89-fdd9-7d6835b8ba65@oracle.com>
Message-ID: <062b0766-3d8c-e907-29f2-eeef7ce5b7cf@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> I see, find_portbundle is just a wrapper for netstat and it's not setting
> any address family, so netstat list all.
That's what I was talking about. It lists all used ports and selects 
only ports, that are free on ipv4 and ipv6. For that reason it was "good 
enough". But I already changed it for the next version of the patch.

>> I think the "thing-under-test" here is the receiver, not the sender. I
>> don't see any benefit swapping this, it will only move the test to the
>> wrong machine, if network namespaces are not in us
>>
>> Both machines are under test.
According to the test description, the test is about testing, if the 
kernel crashes, if a huge number of udp packets is RECEIVED. To me this 
sounds like the receiver should be under test and the sender is just 
some dummy. Of course both is tested here if it runs on the same system 
with namespaces. What I still don't see is the benefit of changing 
sender and receiver.

J?rg

