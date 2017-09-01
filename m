From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 01 Sep 2017 14:44:33 +0200
Subject: [LTP] [PATCH] madvise07: Increase probability of testing a
	supported page type
In-Reply-To: <1387821959.5916937.1504079485373.JavaMail.zimbra@redhat.com>
References: <20170828134827.5871-1-rpalethorpe@suse.com>
 <1387821959.5916937.1504079485373.JavaMail.zimbra@redhat.com>
Message-ID: <87tw0mbnbi.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Jan,

Jan Stancek writes:

> ----- Original Message -----
>> We were attempting to poison page types which do not support it (e.g. the
>> zero
>> page) due to our usage of mmap. Now we map some anonymous memory and write to
>> it. Hopefully ensuring the underlying page is of a supported type.
>> + * If the underlying page type of the memory we have mapped does not support
>> + * poisoning then the test will fail. We try to map and write to the memory
>> in
>> + * such a way that by the time madvise is called the virtual memory address
>> + * points to a supported page. However there may be some rare circumstances
>> + * where the test produces the wrong result because we have somehow obtained
>> + * an unsupported page.
>
> Hi,
>
> Can you elaborate please? If we always do mmap+touch anonymous memory,
> how would we sometime end up with different page type?

Possibly if the page is completely swapped out and it is not in the page
cache. I am not sure if that is even possible, but my point was that we
can't fully gaurantee that we are testing a valid page type because it
is not something you can fully control from user land (unless there is some
debug interface which allows it). I'm not sure if it is a helpful
comment or not.

>
> I don't have objections to patch, but I'm thinking if we should go
> further if there's possibility the test still won't be reliable.
> We could relax the condition, for example by FAILing only if
> child dies unexpectedly (signal != SIGBUS).

I think that if we see another failure and it is not a real bug, then we
do that.

--
Thank you,
Richard.
