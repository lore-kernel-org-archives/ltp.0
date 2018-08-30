From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 30 Aug 2018 15:03:05 +0200
Subject: [LTP] [PATCH 4/5] fzsync: Simplify API with start/end race
	calls and limit exec time
In-Reply-To: <20180829091712.GA30074@rei>
References: <20180828093002.20368-1-rpalethorpe@suse.com>
 <20180828093002.20368-5-rpalethorpe@suse.com>
 <20180828162409.GC26231@rei.lan> <87va7tsgr1.fsf@rpws.prws.suse.cz>
 <20180829091712.GA30074@rei>
Message-ID: <87r2igroqe.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > If yuo init the pair with TST_FZSYNC_PAIR_INIT these fields are already
>> > zeroed...
>>
>> Not if the user uses the -i argument.
>
> Hmm, then we should probably drop the static initialization. We would
> have to have way to set some parameters to non-default values, but I
> guess that we can do that after we called the init function. Something
> as:
>
> 	tst_fzsync_init(&pair);
> 	tst_fzsync_set_foo(&par, val);
>
> Where tst_fzsync_set_foo() is an static inline function.
>

Yeah, thinking about it we should not do the static initialisation
statically anyway incase the test writer needs to dynamically allocate
the memory where the struct is stored. Although they could use memcpy,
but it seems a little bit messy.

--
Thank you,
Richard.
