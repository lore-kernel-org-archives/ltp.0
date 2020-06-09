From: Shuah Khan <skhan@linuxfoundation.org>
Date: Tue, 9 Jun 2020 11:20:04 -0600
Subject: [LTP] [PATCH v3] Wrapper for Syzkaller reproducers
In-Reply-To: <CACT4Y+bYdmD7vdNUayT86oiW8yVLUBdFLOZRJ1nTi9AE99KzSg@mail.gmail.com>
References: <20200609113421.10936-1-rpalethorpe@suse.com>
 <20200609165921.GA28805@dell5510>
 <fa3b9d86-84f7-be61-f06f-c32f3ab60d3a@linuxfoundation.org>
 <CACT4Y+bYdmD7vdNUayT86oiW8yVLUBdFLOZRJ1nTi9AE99KzSg@mail.gmail.com>
Message-ID: <ce8bd6c0-0abb-e09e-b21f-5e769ffd3ab3@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 6/9/20 11:15 AM, Dmitry Vyukov wrote:
> On Tue, Jun 9, 2020 at 7:10 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/9/20 10:59 AM, Petr Vorel wrote:
>>> Hi Richard,
>>>
>>>> So this has now being floating in limbo for some time. My preference is to
>>>> merge it to make it easy for users to try out with plenty of time before the
>>>> next LTP release. It shouldn't break anything because it is hidden behind a
>>>> configure switch.
>>> +1
>>>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>>
>>> I plan to test it a bit and appreciate if somebody else also test it,
>>> but I see no problem to include this patchset.
>>>>> V3:
>>>> + Updated linux-arts commit (thanks Dmitry and Shuah for updating those!)
>>>> + Fixed AC macro
>>>
>>
>> You can send patch to me against linux-arts for this and I will pull
>> it in.
>>
>> Dmitry, is that okay with you. This could make it easier for you and
>> reduce your work.
> 
> Hi,
> 
> I don't have any particular comments.
> I assume Richard tested it and it works. if so, it's fine with me :)
> I don't have any concrete plans to use this at the moment. We have a
> corpus of reproducers in syzkaller format and we can run these. This
> should be more useful for kernel continuous integration systems and
> distro testing.
> 

Right. That is what I was thinking that this is more relevant for kernel
developers, CI and distros.

Richard, Please send the patch for linux-arts to me once Petr gives it a
try and I will apply it.

thanks,
-- Shuah


thanks,
-- Shuah
