Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NShmk-0007wC-6L
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 02:07:38 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NShmi-0007by-Sy
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 02:07:38 +0000
Message-ID: <4B453A02.90903@web.de>
Date: Thu, 07 Jan 2010 02:33:54 +0100
From: Jiri Palecek <jpalecek@web.de>
MIME-Version: 1.0
References: <4B4204D2.70204@petalogix.com> <4B43E6FD.3020906@web.de>	
	<364299f41001051741v7a2bb1d0p91d28aa25967b93e@mail.gmail.com>
	<364299f41001051831r6a0f4930t6ba61e4273c797e3@mail.gmail.com>
In-Reply-To: <364299f41001051831r6a0f4930t6ba61e4273c797e3@mail.gmail.com>
Subject: Re: [LTP] lchown test case
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Garrett Cooper napsal(a):
> On Tue, Jan 5, 2010 at 5:41 PM, Garrett Cooper<yanegomi@gmail.com>  wrote:
>> On Tue, Jan 5, 2010 at 5:27 PM, Jiri Palecek<jpalecek@web.de>  wrote:
>>> Michal Simek napsal(a):
>>>>
>>>> Hi,
>>>
>>> Hi,
>>>>
>>>> I have some problems with lchown02 test which is caused with this patch.
>>>> What is prep_create_link?
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>>
>>>> http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=ee1a022fc76076d7fc1b6b1797c195244414c038
>>>>
>>>>
>>>>
>>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>>> index fbe8641..34631ed 100644 (file)
>>>> --- a/runtest/syscalls
>>>> +++ b/runtest/syscalls
>>>> @@ -462,10 +462,10 @@ kill12 kill12
>>>>
>>>> lchown01 lchown01
>>>> lchown01_16 lchown01_16
>>>> -lchown02 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02
>>>> -lchown02_16 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02_16
>>>> +lchown02 prep_create_link; lchown02
>>>> +lchown02_16 prep_create_link; lchown02_16
>>>
>>> IMHO it should do the same as the line above. But I think the whole thing
>>> could be deleted without causing any grief:
>>>
>>> http://repo.or.cz/w/ltp-debian.git?a=commit;h=a5499edcf368fa88df924f94ffcbe63c22b46e82
>>
>> The test needs create_link in $TMP; that's why I scripted it as a
>> one-liner (but stupid me probably forgot to add the script to CVS
>> -_-).
>> Let me look and I'll get back to you shortly.
>
> Fixed. The executable needed CAP_CHOWN capability and that's part of
> the point behind that script...

Couldn't the executable just get CAP_CHOWN with cap_set_proc in case it is 
running under root with restricted capabilities?

I'm not sure it wouldn't fail even with the suid-root executable under such 
condition - are you really sure it doesn't (esp. in the face of lchown01, which 
would fail almost surely and doesn't have this hack)?

Regards
     Jiri Palecek

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
