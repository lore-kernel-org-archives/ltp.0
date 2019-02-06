From: Vijay Kumar <vijaykumar@bravegnu.org>
Date: Wed, 6 Feb 2019 14:06:11 +0530
Subject: [LTP] [PATCH] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190128134656.27979-1-metan@ucw.cz>
References: <20190128134656.27979-1-metan@ucw.cz>
Message-ID: <641a380d-b43b-3bfe-385d-fc4e8772069e@bravegnu.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Monday 28 January 2019 07:16 PM, Cyril Hrubis wrote:

> From: Cyril Hrubis <chrubis@suse.cz>
>
> We are attempting to trigger the EAGAIN path for the RWF_NOWAIT flag.
>
> In order to do so the test runs three threads:
>
> * nowait_reader: reads from a random offset from a random file with
>                   RWF_NOWAIT flag and expects to get EAGAIN and short
>                   read sooner or later
>
> * writer_thread: rewrites random file in order to keep the underlying device
>                   bussy so that pages evicted from cache cannot be faulted
>                   immediatelly
>
> * cache_dropper: attempts to evict pages from a cache in order for reader to
>                   hit evicted page sooner or later
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jiri Kosina <jikos@kernel.org>
> CC: Linux-MM <linux-mm@kvack.org>
> CC: kernel list <linux-kernel@vger.kernel.org>
> CC: Linux API <linux-api@vger.kernel.org>
>
> ---
>
> I was wondering if we can do a better job at flushing the caches. Is
> there an interface for flusing caches just for the device we are using
> for the test?
>

Will the BLKFLSBUF ioctl be suitable for this purpose?

Regards,
Vijay
