From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 18 Jul 2017 15:14:16 +0300
Subject: [LTP] [RFC PATCH v6 09/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <20170627060404.mcj3jzq6mq3bfuja@dell5510>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-10-pvorel@suse.cz>
 <bf219efe-a926-aa08-c24c-376fc4676556@oracle.com>
 <20170627060404.mcj3jzq6mq3bfuja@dell5510>
Message-ID: <fa66bd09-d7a3-d609-7213-c3adb7e08218@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/27/2017 09:04 AM, Petr Vorel wrote:
> Hi Alexey,
>
> thank you for your review, all will be in v7. Just one comment to initialize_if:
>
>> On 06/03/2017 03:00 PM, Petr Vorel wrote:
> ...
>>> -# Initialize the specified interface
>>> -command="ifconfig $ifname down mtu 1500 ; ip route flush dev $ifname ; ip addr flush dev $ifname ; ifconfig $ifname up"
>>> -
>>>  if [ $host_type = lhost ]; then
>>>      ( ifconfig $ifname down && \
>>>      ip link set mtu 1500 dev $ifname && \
>> There are no changes in route IPv6 tests, why do we need this for route
>> IPv4?
> testcases/network/stress/ns-tools/initialize_if is a legacy script. Instead of fixing it
> should it's usage should be replaced by functions from test_net.sh or test_stress_net.sh
> and the file deleted.

Hi Petr,

Right, the usage of 'initialize_if' is replaced in route4 patch, so
the question was why we need this change in 'initialize_if' here?

Thanks,
Alexey

