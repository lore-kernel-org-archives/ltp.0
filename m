From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 10:42:01 +0800
Subject: [LTP] [PATCH 3/3] syscalls/umask03: Cleanup && Convert to new
 API
In-Reply-To: <20161101150508.GA5787@rei.lan>
References: <1477882478-30693-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1477882478-30693-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161031114002.GI30590@rei.lan> <58181967.9070700@cn.fujitsu.com>
 <20161101150508.GA5787@rei.lan>
Message-ID: <58195279.7030405@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 11/01/2016 11:05 PM, Cyril Hrubis wrote:
> Hi!
>>> Hmm, so this test is just the same as umask02 but tries to create the
>>> file as well.
>>>
>>> What about we remove umask01.c and umask02.c and rename umask03.c to
>>> umask01.c?
>>>
>>> It's not like umask01.c or umask02.c adds any more value since umask03.c
>>> is superset of these.
>>>
>>
>> I think it's a little bit different between umask02 and umask03, manual page
>> says that umask(2) returns the previous value of the mask, and this is only
>> checked in umask02.
>>
>> So what about we just remove umask01.c and rename umask02.c and umask03.c to
>> umask01.c and umask02.c?
> 
> Hmm, right, the umask03 is not checking the return value. But still,
> it's trivial enough to both check the return value and to try to create
> the file in one test. There is no real need to have two when thing could
> be easily done in just one.

OK, I see, I will rewrite the patch as you said, thanks.

Best Regards,
Guangwen Feng


