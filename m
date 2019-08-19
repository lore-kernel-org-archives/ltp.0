From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Aug 2019 14:42:00 +0200
Subject: [LTP] [PATCH v2 01/11] lib: Add support for guarded buffers
In-Reply-To: <877e79wmme.fsf@rpws.prws.suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
 <20190812143941.8119-2-chrubis@suse.cz>
 <877e79wmme.fsf@rpws.prws.suse.cz>
Message-ID: <20190819124159.GA11715@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We could add guarded buffers to huge numbers of tests by wrapping the
> user supplied buffer in various calls to SAFE_* macros and tst_*
> functions. This could be configurable at compile time and it should be
> detectable if a buffer is already guarded, so double wrapping should not
> be an issue.

Fair point. The detection would however be O(n), well we can do a little
trick like maintaing the memory range in which all the mmaps were done
and rule out any heap based allocation in O(1) easily, but anything that
crosses the malloc threshold would be O(n).

> However I am not sure the current API makes this easy. We should
> probably have a tst_free(void *buf) and/or tst_buffer_alloc(struct
> tst_buffer *buf) and tst_buffer_free(struct tst_buffer *buf) (which
> could just put the buffer on a free list for reuse).

I guess that this calls for completely different API since 99% time we
will do with just single buffer.

Unless we are:

* The test is compiled with pthreads
  and we managed to run two SAFE_MACROS() concurently

* The buffer is bigger than one page

* We call SAFE_MACROS() recursively, which we don't

So all of this could be done by a tst_temp_alloc() and tst_temp_free()
that would attempt to grab single pre-allocated buffer and only fall
back to allocating/freeing new buffer when the buffer is currently in
use.

> I am not sure if this is something which needs to be addressed now or
> can be left for another patch set. My main concern is that one of the
> existing API functions will need to be changed.

I guess that it would be easier to make these changes incrementally,
because adding more functionality to this patchset would only make it
harder to review and I would like to get this API in so that we can
star making use of it.

-- 
Cyril Hrubis
chrubis@suse.cz
