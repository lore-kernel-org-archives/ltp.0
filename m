From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, 5 Mar 2020 18:49:20 +0900
Subject: [LTP] fs/buffer.c: WARNING: alloc_page_buffers while mke2fs
In-Reply-To: <20200305093832.GG21048@quack2.suse.cz>
References: <CA+G9fYs==eMEmY_OpdhyCHO_1Z5f_M8CAQQTh-AOf5xAvBHKAQ@mail.gmail.com>
 <20200305093832.GG21048@quack2.suse.cz>
Message-ID: <c875cdda-212e-d88c-6456-c270586be1ef@i-love.sakura.ne.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/03/05 18:38, Jan Kara wrote:
> On Tue 03-03-20 14:15:24, Naresh Kamboju wrote:
>> [Sorry for the spam]
>>
>> Linux-next 5.6.0-rc3-next-20200302 running on arm64 juno-r2 device while
>> running LTP syscalls chown tests.
>>
>> Suspecting commits are (did not do git bisect),
>> b1473d5f3d0 fs/buffer.c: dump more info for __getblk_gfp() stall problem
>> b10a7ae6565 fs/buffer.c: add debug print for __getblk_gfp() stall problem
> 
> These are almost certainly unrelated. If I'm looking right, the warning is
> coming from memalloc_use_memcg() called from alloc_page_buffers()
> complaining that memcg to charge is already set. But I don't see how that
> would be possible (at least with today's linux-next). Can you reproduce the
> problem with today's linux-next?
> 

Already handled as
https://lore.kernel.org/linux-mm/20200303162948.a383cb88c4a1b0bfd3817798@linux-foundation.org/ .
