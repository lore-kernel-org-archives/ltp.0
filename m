From: Shuah Khan <skhan@linuxfoundation.org>
Date: Tue, 9 Jun 2020 11:10:22 -0600
Subject: [LTP] [PATCH v3] Wrapper for Syzkaller reproducers
In-Reply-To: <20200609165921.GA28805@dell5510>
References: <20200609113421.10936-1-rpalethorpe@suse.com>
 <20200609165921.GA28805@dell5510>
Message-ID: <fa3b9d86-84f7-be61-f06f-c32f3ab60d3a@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 6/9/20 10:59 AM, Petr Vorel wrote:
> Hi Richard,
> 
>> So this has now being floating in limbo for some time. My preference is to
>> merge it to make it easy for users to try out with plenty of time before the
>> next LTP release. It shouldn't break anything because it is hidden behind a
>> configure switch.
> +1
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> I plan to test it a bit and appreciate if somebody else also test it,
> but I see no problem to include this patchset.
> >> V3:
>> + Updated linux-arts commit (thanks Dmitry and Shuah for updating those!)
>> + Fixed AC macro
> 

You can send patch to me against linux-arts for this and I will pull
it in.

Dmitry, is that okay with you. This could make it easier for you and
reduce your work.

thanks,
-- Shuah
