From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 25 Jul 2017 13:48:00 +0300
Subject: [LTP] [RFC PATCH v7 02/11] network/stress: Add library
 test_net_stress.sh
In-Reply-To: <20170725095735.nhde7e6nezqeo3nn@dell5510>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-3-pvorel@suse.cz>
 <fddf6fa1-3a12-5035-482f-08fe83fcb47e@oracle.com>
 <20170725095735.nhde7e6nezqeo3nn@dell5510>
Message-ID: <4b453a16-1e16-c7e3-3b03-20b0d065fe2a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/25/2017 12:57 PM, Petr Vorel wrote:
> Hi Alexey,
>
>>> +export OCTET_3_IPV4_UNUSED=${OCTET_3_IPV4_UNUSED:-23} # x.x.N.x
>>> +export OCTET_4_LHOST_IPV4_HOST_UNUSED=${OCTET_4_LHOST_IPV4_HOST_UNUSED:-2} # x.x.x.N
>>> +export OCTET_4_RHOST_IPV4_HOST_UNUSED=${OCTET_4_RHOST_IPV4_HOST_UNUSED:-1} # x.x.x.N
>>> +export LHOST_IPV4_HOST_UNUSED="${OCTET_3_IPV4_UNUSED}.${OCTET_4_LHOST_IPV4_HOST_UNUSED}"
>>> +export RHOST_IPV4_HOST_UNUSED="${OCTET_3_IPV4_UNUSED}.${OCTET_4_RHOST_IPV4_HOST_UNUSED}"
>>> +export LHOST_IPV4_UNUSED="${IPV4_NET16_UNUSED}.$LHOST_IPV4_HOST_UNUSED"
>>> +export RHOST_IPV4_UNUSED="${IPV4_NET16_UNUSED}.$RHOST_IPV4_HOST_UNUSED"
>>> +
>>> +export OCTET_3_IPV6_UNUSED="${OCTET_3_IPV6_UNUSED:-:0}"
>>> +export OCTET_4_LHOST_IPV6_HOST_UNUSED=${OCTET_4_LHOST_IPV6_HOST_UNUSED:-2}
>>> +export OCTET_4_RHOST_IPV6_HOST_UNUSED=${OCTET_4_RHOST_IPV6_HOST_UNUSED:-1}
>>> +export LHOST_IPV6_HOST_UNUSED="${OCTET_3_IPV6_UNUSED}:${OCTET_4_LHOST_IPV6_HOST_UNUSED}"
>>> +export RHOST_IPV6_HOST_UNUSED="${OCTET_3_IPV6_UNUSED}:${OCTET_4_RHOST_IPV6_HOST_UNUSED}"
>>> +export LHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$LHOST_IPV6_HOST_UNUSED"
>>> +export RHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$RHOST_IPV6_HOST_UNUSED"
>> Hmm, what is the purpose of adding these variables to the library?
>> Why someone would need to redefine any of them?
> I thought someone might appreciate ability to full control of IP
> addresses, but you're right it's probably useless.
> If you don't mind, I'll keep {L,R}HOST_IPV{4,6}_UNUSED variables as they are used in many scripts
> (DRY approach) and delete the rest of variables.


What about adding a new function similar to tst_ipaddr()?

tst_ipaddr_un(), tst_ipaddr_new(), etc.? Probably we would need to add
some optional counter parameter along with lhost/rhost...

Best regards,
Alexey

