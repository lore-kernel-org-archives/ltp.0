From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 29 Oct 2020 17:23:40 +0100
Subject: [LTP] [PATCH 04/19] Unify error handling in lib/safe_file_ops.c
In-Reply-To: <20201029161714.GE8378@yuki.lan>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-5-mdoucha@suse.cz> <20201029155907.GC8378@yuki.lan>
 <20201029160222.GD8378@yuki.lan>
 <af6cdfdd-23e8-1593-9509-43685e4706c3@suse.cz>
 <20201029161714.GE8378@yuki.lan>
Message-ID: <fbb52689-5797-7615-e4b8-a8bcabee09e8@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29. 10. 20 17:17, Cyril Hrubis wrote:
> Hi!
>>> That's true for printf() scanf returns EOF instead. But I guess that
>>> anything < 0 would work better than 1 which means that one input item
>>> was matched successfuly...
>>
>> These safe file functions could use some additional improvements but
>> changing the return value is out of scope of my patchset. That would
>> probably require reviewing and modifying some test code as well. The
>> patchset is over 4000 lines long as is.
> 
> It's actually not since you are chaning the void functions to return
> int, if you kept them void that would mean that it's out of scope.

Changing return type from void to int is fully backwards compatible
because the return value is ignored everywhere anyway. On the other
hand, changing return value in functions which already return int could
break a lot of existing test code. Especially when you do it in a
control flow branch that doesn't terminates the test through tst_brk().

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
