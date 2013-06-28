Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UsSR3-0001rd-1j
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 06:45:33 +0000
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UsSQy-0005Ub-Rh
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 06:45:33 +0000
Received: by mail-pa0-f46.google.com with SMTP id fa11so2055036pad.19
	for <ltp-list@lists.sourceforge.net>;
	Thu, 27 Jun 2013 23:45:23 -0700 (PDT)
Message-ID: <51CD3113.7010802@casparzhang.com>
Date: Fri, 28 Jun 2013 14:45:39 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1372142262-4654-1-git-send-email-liuhangbin@gmail.com>
	<51CCFF42.6060703@casparzhang.com>
	<CAPwn2JSrnMeANv6Reh=Z1sGZEpr5aGD1SMKtffjwdxnuh+cv=w@mail.gmail.com>
In-Reply-To: <CAPwn2JSrnMeANv6Reh=Z1sGZEpr5aGD1SMKtffjwdxnuh+cv=w@mail.gmail.com>
Subject: Re: [LTP] [PATCH] testscripts/networkstress.sh: update for two
 interfaces support
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 06/28/2013 01:59 PM, Hangbin Liu wrote:
> No, the INTERFACE and LHOST_HWADDRS are both used to make sure we have
> enough NIC for some network testing.
>
> We can know the networking test topology from testcases/network/stress/README
>
> Physical Topology
> =================
>
> These tests require two machines. And each machine needs to have 2 or more
> interfaces. These tests assume that they run on the following topology.
>
>                                Control Link
>                  +------------------------------------+
>                  |                                    |
>          +-------+-------+                    +-------+-------+
>          |               +---- Test Link 0 ---+               |
>          |  Local Host   +          :         +  Remote Host  |
>          |               +---- Test Link n ---+               |
>          +---------------+                    +---------------+
>
> Control Link is used by the local host to control the remote host.
> `control' means, for example, changing the setting of the interfaces that are
> connected to the test links. The setting of the interfaces connected to the
> control link is never changed.
>
> Test Links are the place where the stress tests run. For example, test packets
> flow those links. The number of test links must be at least 1. The setting of
> the interfaces connectted to the test links would be changed by the tests.
> Therefore, each test link should not belong to any external network. It is
> recommended to connect each pair of interfaces with the ether cross cables.
>
> Currently, different NIC testcases for ICMP/UDP/TCP/Multicast require plural
> test links.  Other testcases uses only 1 test link. (Test Link 0)
>
>
> So some tests, such as
> testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
> testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
> testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic01
>
> they all need more than one NIC for testing.
>
> When we get INTERFACE="eth0|eth1", then we can get
> LHOST_HWADDRS="aa:bb:cc:dd:ee:fe aa:bb:cc:dd:ee:ff" from networkstress.sh.
>
> And for example, in test
> testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
>
> We will check the total link num by
> link_total=`echo $LHOST_HWADDRS | wc -w`
>
> Then in "while [ $link_num -lt $link_total ]; do" loop, we will assign
> different IP address
> for each link with network_part="10.0.${link_num}".
>
> What I want to say is that we need to get two MAC addresses for LHOST_HWADDRS,
> so we have to make sure networkstress.sh can get two interface for INTERFACE

OK, I was a bit naive :-) thanks for the detailed explanation. I grepped 
a bit in testcases/network and did find the two variables are widely 
used. I think before we can prove all affected cases work with this 
change, we should hold on the patch. Do you have a running result 
against all affected cases?

Thanks,
Caspar


>
> 2013/6/28 Caspar Zhang <caspar@casparzhang.com>:
>> On 06/25/2013 02:37 PM, Hangbin Liu wrote:
>>>
>>> As some networking tests need two interfaces at the same time. Use grep -P
>>> to
>>> get two interfaces' mac addresses.
>>>
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>>    testscripts/networkstress.sh | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
>>> index b40af72..499b40c 100755
>>> --- a/testscripts/networkstress.sh
>>> +++ b/testscripts/networkstress.sh
>>> @@ -15,6 +15,8 @@ fi
>>>    export TMPDIR=/tmp/netst-$$
>>>    mkdir $TMPDIR
>>>    VERBOSE="no"
>>> +# Default interface is "eth0".
>>> +# For some test cases that need two interfaces, give parameter like
>>> "eth0|eth1"
>>>    INTERFACE="eth0"
>>>
>>>
>>> #===========================================================================
>>> @@ -71,6 +73,7 @@ usage () {
>>>        echo " -W|w: Run whole network stress tests"
>>>        echo " -D|d: Test duration (default ${NS_DURATION} sec)"
>>>        echo " -N|n: Select the network interface (default: $INTERFACE)"
>>> +    echo "       Two interfaces' format: \"eth0|eth1\""
>>>        echo " -V|v: Enable verbose"
>>>        echo " -H|h: This Usage"
>>>        echo ""
>>> @@ -102,7 +105,7 @@ if [ -z ${TEST_CASE} ]; then
>>>          usage
>>>    fi
>>>
>>> -export LHOST_HWADDRS=`ifconfig | grep ${INTERFACE} | grep HWaddr |awk
>>> '{print $5}'`
>>> +export LHOST_HWADDRS=`ifconfig | grep -P ${INTERFACE} | grep HWaddr |awk
>>> '{print $5}'`
>>
>>
>>
>> As my understanding, the INTERFACE & LHOST_HWADDRS variables only used for
>> verbose printing, right?
>>
>> If yes, I'll give my ack here.
>>
>> BTW, I'd to add quotations around ${INTERFACE}, to make sure 100% safety.
>>
>> Caspar.
>>
>>
>>>
>>>    if [ -z ${RHOST} ]; then
>>>          ## Just a silly check
>>>
>>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
