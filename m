From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 21 Dec 2018 18:23:07 +0000
Subject: [LTP] [PATCH v2 1/4] cgroup_regression_test.sh ported to newlib
In-Reply-To: <b664fcee-17b8-dea2-313a-0b73e11651c8@arm.com>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
 <20181220182149.48326-2-cristian.marussi@arm.com>
 <20181221142538.GB22257@dell5510>
 <b664fcee-17b8-dea2-313a-0b73e11651c8@arm.com>
Message-ID: <b994dfda-39a9-4107-fe8f-e36e9317ab9a@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 21/12/2018 15:20, Cristian Marussi wrote:
> Hi
> 
> On 21/12/2018 14:25, Petr Vorel wrote:
>> Hi Cristian,
>>
>> ...
>>> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>>>  {
>>>  	grep -q -w "ns" /proc/cgroups
>>>  	if [ $? -ne 0 ]; then
>>> -		tst_resm TCONF "CONFIG_CGROUP_NS"
>>> +		tst_res TCONF "CONFIG_CGROUP_NS"
>>>  		return
>>>  	fi
>>
>> This could be just
>>
>> grep -q -w "ns" /proc/cgroups || tst_res TCONF "CONFIG_CGROUP_NS is not enabled"
>>
>> But CONFIG_CGROUP_NS was removed in a77aea92010a ("cgroup: remove the ns_cgroup")
>> in v3.0. We don't have TST_MAX_KVER, so we cannot use TST_MAX_KVER="3.0", but
>> maybe compare kernel version with tst_kvcmp (see doc) and adjust warning for new kernels.
> 
> Fine I'll do. In fact I could see it working properly only when testing on QEMU
> 2.6.39.

Done with test_kvcmp BUT regarding the grep --q ... || tst_res, it turns out it
needs anyway a return afterwards to end the testcase function ...so I've left
the if block (even if I could have appended the return after the || tst_res)

Regards

Cristian
> 
> Regards
> 
> Cristian
>>
>> Kind regards,
>> Petr
>>
> 
> 

