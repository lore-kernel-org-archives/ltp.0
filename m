From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Aug 2016 13:25:02 +0100
Subject: [LTP] [PATCH] syscalls/mprotect04: Use
 __builtin___clear_cache() to sync caches
In-Reply-To: <20160809121321.GA31315@rei.suse.cz>
References: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
 <20160801113157.GD6899@rei.lan>
 <CAFEAcA9fPp-Hemq5E6q7udfh-5jDHdiTstfNr6M7wn8JGfzbeA@mail.gmail.com>
 <20160801161727.GA13333@rei>
 <CAFEAcA96pwQxTR9Heu5jLm+0nKB9ODD7XaEmZwcZSiE_Rx3O0g@mail.gmail.com>
 <20160809121321.GA31315@rei.suse.cz>
Message-ID: <CAFEAcA_kQxUuKgqkfNcPquAFCoODrY=8=xPR1erRGeES9KHGNQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 9 August 2016 at 13:13, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> > Well I would be slightly inclined not to introduce false regressions
>> > with newer LTP versions. But given that this affects only really old
>> > compilers we may as well get with your version.
>>
>> Hi -- are you planning to commit this version of the patch
>> or would you prefer me to spin a v2 with the i386 ifdeffery ?
>
> I've pushed the first version, thanks.

That's great, thanks.

-- PMM
