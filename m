From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 12 Nov 2020 08:59:14 -0700
Subject: [LTP] [PATCH 1/1] loop: Fix occasional uevent drop
In-Reply-To: <20201112144307.GA8377@lst.de>
References: <20201111180846.21515-1-pvorel@suse.cz>
 <20201112144307.GA8377@lst.de>
Message-ID: <9276a97c-3b71-ddb4-d027-6b184c8d86fa@kernel.dk>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/12/20 7:43 AM, Christoph Hellwig wrote:
> On Wed, Nov 11, 2020 at 07:08:46PM +0100, Petr Vorel wrote:
>> 716ad0986cbd caused to occasional drop of loop device uevent, which was
>> no longer triggered in loop_set_size() but in a different part of code.
>>
>> Bug is reproducible with LTP test uevent01 [1]:
>>
>> i=0; while true; do
>>     i=$((i+1)); echo "== $i =="
>>     lsmod |grep -q loop && rmmod -f loop
>>     ./uevent01 || break
>> done
>>
>> Put back triggering through code called in loop_set_size().
>>
>> Fix required to add yet another parameter to
>> set_capacity_revalidate_and_notify().
> 
> I don't like where this is heading, especially as I've rewritten the whole
> area pending inclusion for 5.11. I think the you want something like what
> I did in this three commits with a loop commit equivalent to the last
> commit for nbd:
> 
> http://git.infradead.org/users/hch/block.git/commitdiff/89348f9f510d77d0bf69994f096eb6b71199e0f4
> 
> http://git.infradead.org/users/hch/block.git/commitdiff/89348f9f510d77d0bf69994f096eb6b71199e0f4
> 
> Jens, maybe I should rebase things so that a version of that first
> commit can go into 5.10 and stable?

That's fine, already wasn't a huge fan of pulling in block-5.10. So let's
plan on fixing this for -rc4, and I'll rebase the 5.11 branches on top of
that.

-- 
Jens Axboe

