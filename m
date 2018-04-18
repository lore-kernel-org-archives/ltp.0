From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Apr 2018 17:56:38 +0300
Subject: [LTP] [PATCH 2/2] network/in6_02: Don't use default value for
 LHOST_IFACES
In-Reply-To: <20180418141356.fuqueijmwjf2mvew@dell5510>
References: <20180417124207.4561-1-pvorel@suse.cz>
 <20180417124207.4561-2-pvorel@suse.cz>
 <f28265d1-10a0-f7d0-248d-e0b8b709eea8@oracle.com>
 <20180418141356.fuqueijmwjf2mvew@dell5510>
Message-ID: <34e6a4c1-4a2f-dda1-3b83-03d4930a08ec@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/18/2018 05:13 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> On 04/17/2018 03:42 PM, Petr Vorel wrote:
>>> in6_02 can be test without help of network.sh. In that case LHOST_IFACES
>>> is not defined and "eth0" is used as default value. This can cause
>>> failures.
> 
>> I think the fix should be before the conversion to the new API, otherwise
>> it unnecessary depends on it.
> Agree, I'll fix it.
> 
> ...
>>>  	for (i = 0; i < ARRAY_SIZE(test_case); ++i) {
>>> +		if (test_case[i].name == NULL)
>>> +			continue;
> 
>> What about using TCONF if it skips the test-case because
>> LHOST_IFACE is not defined?
> I wanted to keep at least testing of if_nametoindex("lo").
> Would be overkill in case of TCONF to create in6_02.sh which would just load tst_net.sh?
> I don't like the fact, that network C tests depend on being run via network.sh (unlike
> shell network tests).

Why it depends on network.sh? LHOST_IFACE is just an environment variable.
It can be defined on the test machine already before the test is started,
or with tst_net.sh.

I mean, using TCONF for the LHOST_IFACE test-case, when the test in6_02,
doesn't find the variable and skips it, then proceeds with the rest of
test-cases.
