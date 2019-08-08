From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 08 Aug 2019 17:41:52 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190808090635.GA11500@rei.lan>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz> <871rxyd5tc.fsf@rpws.prws.suse.cz>
 <20190808090635.GA11500@rei.lan>
Message-ID: <87zhkjbr5r.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > +void tst_free_all(void)
>> > +{
>> > +	struct map *i = maps;
>> > +
>> > +	while (i) {
>> > +		struct map *j = i;
>> > +		tst_res(TINFO, "Freeing %p %zu", i->addr, i->size);
>> 
>> This seems like debug info to me. Not really useful most of the time.
>
> Yes, this is a leftover.
>
> I do wonder if we should print a message first time the tst_alloc() is
> called so that it's clear that the test is using guarded buffers.

Maybe some summary info.

>
>> > +		SAFE_MUNMAP(i->addr, i->size);
>> > +		i = i->next;
>> > +		free(j);
>> > +	}
>> > +
>> > +	maps = NULL;
>> > +}
>> 
>> -- 
>> Thank you,
>> Richard.
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.
