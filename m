From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 14 Mar 2016 10:33:45 +0300
Subject: [LTP] [PATCH 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <20160311143327.GT2649@Leo.nay.redhat.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-4-git-send-email-haliu@redhat.com>
 <56E01CDE.9090101@oracle.com> <20160310065045.GM2649@Leo.nay.redhat.com>
 <56E122F6.9060504@oracle.com> <20160311030836.GP2649@Leo.nay.redhat.com>
 <56E2AED0.3050605@oracle.com> <20160311143327.GT2649@Leo.nay.redhat.com>
Message-ID: <56E66959.3030305@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/11/2016 05:33 PM, Hangbin Liu wrote:
>>>> By the way, if you are going to fix such tests please use IP range
>>>> that is defined with the following env vars:
>>>>
>>>> export IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
>>>> export IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
>>>>
>>>> it's from testscripts/network.sh.
>>> Thanks for this tip. multi-diffip and multi-diffnic use multi different subnets.
>>> So I think we still need keep using the previous method.
>>>
>>> while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
>>>      # Add new IP addresses
>>>      x=`expr $ipaddr_pair_num \/ 255 % 255`
>>>      y=`expr $ipaddr_pair_num % 255`
>>>      if [ $x -ge 255 ]; then
>>>          tst_info TINFO "This script cannot add more than $ipaddr_pair_num addresses"
>>>          break
>>>      fi
>>>
>>>      case $IP_VER in
>>>          4)
>>>          network_part="10.${x}.${y}"
>>>          network_broadcast=${network_part}.255
>> Please look at the stress/interface/if-addr-addlarge
>>
>> while [ $cnt -le $IP_TOTAL ]; do
>>      if [ "$TST_IPV6" ]; then
>>          local hex_x=$(printf '%x' $x)
>>          local hex_y=$(printf '%x' $y)
>>          local new_ip=${IPV6_NET32_UNUSED}:1:1:1:$hex_x:$hex_y:1
>>      else
>>          local new_ip=${IPV4_NET16_UNUSED}.$x.$y
>>      fi
>> ...
>>
>> I think 254 * 254 (for IPv4) is more than enough for such tests.
>>
> Hmm, looks multi-diffnic could use this method since it only has ${link_num}
> subnets, but multi-diffip test use two dimension subnets. which looks like
> client: 10.${x}.${y}.1 , server: 10.${x}.${y}.2 . So I think we could not use
> like local new_ip=${IPV4_NET16_UNUSED}.$x.$y

We can create 16K subnets with $IPV4_NET16_UNUSED.$x.$y/30 that each can 
have
two hosts. Is it not enough for the test? I see diffip01 test set only
100 IP pairs (subnets) for default.

Best regards,
Alexey

