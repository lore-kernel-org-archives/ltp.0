From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 22 Jul 2021 08:37:23 +0200
Subject: [LTP] [PATCH v4,
 2/2] cgroup/cgroup_regression_test: Fix umount failure
In-Reply-To: <20210722063232.GA28553@andestech.com>
References: <20210719092239.GA1475@atcfdc88> <YPgxJwx795fhXgLa@pevik>
 <62262681-222f-8d09-a100-0d7be0c7526f@jv-coder.de>
 <20210722063232.GA28553@andestech.com>
Message-ID: <3d17ca93-3c93-894c-77d2-0b588fce3dad@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Leo,


On 7/22/2021 8:32 AM, Leo Liang wrote:
> Hi Joerg,
> On Thu, Jul 22, 2021 at 12:35:59PM +0800, Joerg Vehlow wrote:
>> Hi,
>>
>> On 7/21/2021 4:37 PM, Petr Vorel wrote:
>>> Hi Leo,
>>>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>>
>>>>    	rmdir cgroup/0 cgroup/1
>>>> -	umount cgroup/
>>>> +	tst_umount cgroup/	# Avoid possible EBUSY error
>>>>    }
>>>>    #---------------------------------------------------------------------------
>>>> @@ -193,7 +193,7 @@ test3()
>>>>    	wait $pid2 2>/dev/null
>>>>    	rmdir $cpu_subsys_path/0 2> /dev/null
>>>> -	umount cgroup/ 2> /dev/null
>>>> +	tst_umount cgroup/ 2> /dev/null		# Avoid possible EBUSY error
>>> I'd prefer: # keep "/" to avoid possible EBUSY error
>>> But that can be changed before merge.
>>>
>>> More I'm interested if other maintainers agree with me about this approach.
>>> (keep / here instead of in tst_umount())
>> I had a first look at this patches and was curious, what the reasoning
>> behind the "/" is.
>> The comment you suggest is wrong. The / was introduced to prevent
>> unmounting some other mountpoint,
>> where the device was cgroup.
>> Imho the approach of adding a / to the end was wrong and intransparent.
>> I would rather use "./cgroup" or "$PWD/cgroup".
>> If possible, I'd actually change tst_umount, to always unmount the
>> mountpoint and not the device, i.e. if the given path is not an absolute
>> path, make it absolute (e.g. by prepending $PWD").
>> This way the check if the mountpoint exist wouldn't be the fuzzy thing
>> it is right now.
>>
>> As for the comment ("# Avoid possible EBUSY error"): Honestly I'd drop
>> it and like in the c-api make using tst_umount instead of plain umount
>> the default, for the same reasons.
> Got it!
> Thanks for the detailed explanation!
> I will send a v5 patch for this modification.
> (making the path absolute inside tst_umount)
This was just my opinon. I am not in the place to say how it should be done.
Maybe wait for replies from the maintainers.
Additionally, all usages of tst_umount have to be checked, to ensure 
they are passing a mountpoint and not a device, otherwise my proposal 
cannot be implemented in tst_umount.

Joerg
