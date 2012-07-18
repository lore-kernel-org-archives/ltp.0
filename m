Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <marios.makris@gmail.com>) id 1SrVSx-0007jg-I8
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 14:43:03 +0000
Received: from mail-wg0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SrVSs-0004sd-7a
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 14:43:03 +0000
Received: by wgbfm10 with SMTP id fm10so1198428wgb.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Jul 2012 07:42:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5006BF53.2080607@casparzhang.com>
References: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
	<500671C4.5020609@cn.fujitsu.com>
	<CAMYrgfTJbK+HmzZ2bRssQSuE2Bz_V5RzFY2ZL8Auy-LQWfYBOQ@mail.gmail.com>
	<5006BF53.2080607@casparzhang.com>
Date: Wed, 18 Jul 2012 17:42:51 +0300
Message-ID: <CAMYrgfTnXvjm2ynCGZS8aa+O1LM0k55=CprUcXTBAviQAZEXkA@mail.gmail.com>
From: "marios.makris" <marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 1/6] /lib/tst_tmpdir indentation and coding style
	fixes
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
To: ltp-list@lists.sourceforge.net

On 18 July 2012 16:51, Caspar Zhang <caspar@casparzhang.com> wrote:
> On 07/18/2012 09:32 PM, marios.makris wrote:
>>
>> On 18 July 2012 11:20, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>>>
>>> On 07/13/2012 11:51 PM, Marios Makris wrote:
>>>>
>>>> Identation and coding style fixes as well as moved the function
>>>> descriptions
>>>> to the header file (/include/test.h)
>>>>
>>>> Signed-off-by: Marios Makris <marios.makris@gmail.com>
>>>> ---
>>>>   include/test.h   |   26 +++++++++++++++
>>>>   lib/tst_tmpdir.c |   97
>>>> ++++++++++++++++++------------------------------------
>>>>   2 files changed, 58 insertions(+), 65 deletions(-)
>>>>
>>>> diff --git a/include/test.h b/include/test.h
>>>> index 033fdbc..934585e 100644
>>>> --- a/include/test.h
>>>> +++ b/include/test.h
>>>> @@ -201,8 +201,34 @@ extern int Tst_count;
>>>>   void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
>>>>
>>>>   /* lib/tst_tmpdir.c */
>>>> +
>>>> +/* tst_tmpdir()
>>>> + *
>>>> + * Create a unique temporary directory and chdir() to it. It expects
>>>> the caller
>>>
>>>
>>> It's better to keep the comments lines within 73 characters.
>>>
>>> Thanks,
>>> Wanlong Gao
>>>
>>
>> Well i thought that the line limit was 80 characters(columns) ?
>>
>> Thanks
>>
>
> I think it's 80 characters. (it should be OK if checkpatch.pl doesn't
> complain...)
>
> Caspar
>

Well there are 2 lines slightly over 80 characters but they are completely
removed in 5th patch with the TDIRECTORY part...

I could fix them in the first patch as-well if you think it would be better
but the end result (if all patches are applied) is the same.

Thanks


-- 
Marios Makris

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
