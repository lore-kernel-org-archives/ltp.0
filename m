From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Mar 2016 11:16:26 +0300
Subject: [LTP] [PATCHv2 1/3] lib/test_net.sh: add tst_ping() to check
 icmp connectivity
In-Reply-To: <20160315124131.GC29634@Leo.nay.redhat.com>
References: <1458035439-9143-1-git-send-email-haliu@redhat.com>
 <1458035439-9143-2-git-send-email-haliu@redhat.com>
 <56E7F95E.8030009@oracle.com> <20160315124131.GC29634@Leo.nay.redhat.com>
Message-ID: <56E9165A.3060800@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/15/2016 03:41 PM, Hangbin Liu wrote:
> On Tue, Mar 15, 2016 at 03:00:30PM +0300, Alexey Kodanev wrote:
>> Hi,
>> On 03/15/2016 12:50 PM, Hangbin Liu wrote:
>>> Signed-off-by: Hangbin Liu <haliu@redhat.com>
>>> ---
>>>   testcases/lib/test_net.sh | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
>>> index 418fed3..8517cb9 100644
>>> --- a/testcases/lib/test_net.sh
>>> +++ b/testcases/lib/test_net.sh
>>> @@ -314,3 +314,24 @@ tst_netload()
>>>   	return $ret
>>>   }
>>> +
>>> +# tst_ping [IFACE] [ADDR] [SIZE]
>>> +# Check icmp connectivity
>>> +# IFACE: source interface name
>>> +# ADDR: destination IPv4 or IPv6 address
>>> +# SIZE: message size
>>> +tst_ping()
>>> +{
>>> +	# The max number of ICMP echo request
>>> +	PING_MAX=${PING_MAX:-"10"}
>>> +
>>> +	local src_iface=${1:-"$(tst_iface)"}
>>> +	local dst_addr=${2:-"$(tst_ipaddr rhost)"}
>>> +	# ping cmd use 56 as default message size
>>> +	local msg_size=${3:-"56"}
>>> +
>>> +	echo $dst_addr | grep -q ":" && TST_IPV6=6
>> You shouldn't have this check here because TST_IPV6 should be
>> set before test runs. Either test starts with '-6' parameter (that way
>> it is automatically set in test_net.sh) or manually defined as
>> TST_IPV6=6 in ipv6 specific test.
>>
>> Note, tst_ipaddr function returns IPv4 or IPv6 address depending on
>> TST_IPV6, so it is quite strange to check the returned address by this
>> function and set TST_IPV6.
> Hi Alexey:
>
> icmp4-uni-basic01 use IP_VER to check ip version. So I did this check before
> ping. But as you said, I will remove the check and add TST_IPV6 in uni-basic
> tests.
>
> BTW, Would you like to help apply the patches and check the ROD issue? I
> always got the following error when use ROD to run cmds.

ROD works fine for me. I would remove the old scripts first and cleanup 
the test.
It still includes the old scripts like check_env, check_cmds that I 
wouldn't use
anymore.

Thanks,
Alexey

