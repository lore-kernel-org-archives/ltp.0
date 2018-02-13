From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 13 Feb 2018 16:33:11 +0100
Subject: [LTP] [PATCH v2] Add read_all file systems test
In-Reply-To: <20180213141535.GA10493@rei>
References: <20180119163715.32599-1-rpalethorpe@suse.com>
 <20180122132123.GA10527@rei.lan> <87mv0dxccb.fsf@rpws.prws.suse.cz>
 <20180213141535.GA10493@rei>
Message-ID: <87inb0ykeg.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> >> +	queue_destroy(q, 1);
>> >> +	fflush(stdout);
>> >
>> > What are trying to flush here? The tst_res() messages are printed
>> > into the stderr btw.
>>
>> I found that the pass message was being written after some of the
>> childrens' information messages. Calling fflush on stdout prevents that
>> from happening even though it is the wrong fd...
>
> You mean the tst_res(TPASS, ...) called after the tst_reap_children() ?
>
> That is really strange since at that time the processes had called
> exit() already and the buffers should have been flushed at that point.
> I.e. if we haven't flushed it in the worker_run() the exit() should take
> care of that, which is guaranteed to run before we return from the
> tst_reap_children().

It only happens on older products, so it could be removed if you are not
concerned about that? I'm not sure if investigating it further would be
useful.

Also I found a bug when pushing to a full queue, so I need to do another
patch revision anyway.

--
Thank you,
Richard.
