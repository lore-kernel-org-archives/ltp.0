From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 10 Mar 2016 10:32:06 +0300
Subject: [LTP] [PATCH 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <20160310065045.GM2649@Leo.nay.redhat.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-4-git-send-email-haliu@redhat.com>
 <56E01CDE.9090101@oracle.com> <20160310065045.GM2649@Leo.nay.redhat.com>
Message-ID: <56E122F6.9060504@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/10/2016 09:50 AM, Hangbin Liu wrote:
>>>       # Unset SAD/SPD
>>> -    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
>>> -    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
>>> +    tst_ipsec flush
>>>       # Clean up each interface
>>> -    initialize_if lhost ${LINK_NUM}
>>> -    initialize_if rhost ${LINK_NUM}
>>> +    tst_init_iface lhost ${LINK_NUM}
>>> +    tst_init_iface rhost ${LINK_NUM}
>> Can we remove them instead? Most tests expect that they are already
>> initialized.
> I think we'd better not remove them. uni-basic is still OK. But multi-diffip
> tests will add multi ip addresses. We need clean the env after each test.

OK, let's keep it only in tests which add/remove IP addresses.

By the way, if you are going to fix such tests please use IP range
that is defined with the following env vars:

export IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
export IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}

it's from testscripts/network.sh.


Thanks,
Alexey

