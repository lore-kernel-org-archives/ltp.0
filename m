From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 10 Jun 2020 08:18:09 +0100
Subject: [LTP] [PATCH v3] Wrapper for Syzkaller reproducers
In-Reply-To: <8b3cbf25-83ad-42da-f3ec-e2bafdfff97c@linuxfoundation.org>
References: <20200609113421.10936-1-rpalethorpe@suse.com>
 <20200609165921.GA28805@dell5510>
 <fa3b9d86-84f7-be61-f06f-c32f3ab60d3a@linuxfoundation.org>
 <CACT4Y+bYdmD7vdNUayT86oiW8yVLUBdFLOZRJ1nTi9AE99KzSg@mail.gmail.com>
 <ce8bd6c0-0abb-e09e-b21f-5e769ffd3ab3@linuxfoundation.org>
 <20200609195851.GA29515@x230>
 <8b3cbf25-83ad-42da-f3ec-e2bafdfff97c@linuxfoundation.org>
Message-ID: <874krjxuby.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Shuah Khan <skhan@linuxfoundation.org> writes:

> On 6/9/20 1:58 PM, Petr Vorel wrote:
>> Hi Shuah,
>>
>> ...
>>>> I don't have any particular comments.
>>>> I assume Richard tested it and it works. if so, it's fine with me :)
>>>> I don't have any concrete plans to use this at the moment. We have a
>>>> corpus of reproducers in syzkaller format and we can run these. This
>>>> should be more useful for kernel continuous integration systems and
>>>> distro testing.
>>
>>> Right. That is what I was thinking that this is more relevant for kernel
>>> developers, CI and distros.
>>
>>> Richard, Please send the patch for linux-arts to me once Petr gives it a
>>> try and I will apply it.
>> NOTE: this patch is for LTP. But maybe I miss something (some other patch for
>> linux-arts I overlooked).
>>
>
> Possibly I misread the
>
> V3:
> + Updated linux-arts commit (thanks Dmitry and Shuah for updating those!)
> + Fixed AC macro
>
> If this patch doesn't intend to update syzkaller-repo, there is
> nothing to do for linux-arts. I thought that this patch is for
> Dmitry's syzkaller repo I update from and looking get this into
> linux-arts directly.
>
> Since this is LTP patch, ignore my comments. Sorry for the noise.
>
> thanks,
> -- Shuah

No problem at all, I should have made that more clear.

Infact I will send a seperate patch to linux-arts mentioning the LTP
wrapper.
-- 
Thank you,
Richard.
