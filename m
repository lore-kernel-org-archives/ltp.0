From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 02 Aug 2019 16:03:02 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190801114522.GA23916@rei>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
 <1879623564.3992300.1564655982672.JavaMail.zimbra@redhat.com>
 <20190801114522.GA23916@rei>
Message-ID: <878ssbd5rd.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > This commit adds a support for guarder buffers. Guarded buffer is a
>> > buffer allocated so that there is PROT_NONE page immediatelly after the
>> > end of the buffer i.e. any access after the buffer generates
>> > SEGFAULT/EFAULT etc.
>> > 
>> > The library is hooked into the tst_test structure so that all you need
>> > is to fill up an NULL terminated array of buffer pointers and sizes to
>> > get the respective buffers allocated. The library supports allocating
>> > memory in test runtime as well as well as allocating more complex
>> > buffers, which currently are iovec vectors.
>> 
>> Runtime alloc in loop could be an issue, do we need also runtime free?
>
> We can easily add it if we find it useful, so far all the usecases
> were either already allocating buffers in setup or converted to do so.

I am just starting to convert one of the bpf tests and I am considering
just wrapping the systemcall or creating some helper func which takes
whatever buffer is supplied and copy it to a new gaurded buffer. It is
maybe not efficient with large buffer sizes, but in most cases I don't
think it would matter too much.

-- 
Thank you,
Richard.
