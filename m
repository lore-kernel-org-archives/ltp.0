From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Dec 2017 08:35:02 -0500 (EST)
Subject: [LTP] [PATCH v2] brk01: Rewrite from scratch.
In-Reply-To: <20171219083814.13110-1-chrubis@suse.cz>
References: <20171219083814.13110-1-chrubis@suse.cz>
Message-ID: <1037328137.2233326.1513863302714.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> This commit rewrites the brk01 test from scratch since the original code
> wasn't making much sense.
> 
> Now we actually run the brk() in a loop increasing and shrinking the
> break repeatedly a few times, which the original code was supposed to do
> but never actually did since we do not pass the -i parameter in the
> runtest files.
> 
> The increment is also choosen to be much much more reasonable instead of
> using the multiple of the absolute address of the page break we choose
> much more modest 2 * pagesize - 1. Note that the increment is not page
> aligned since that way we also check that kernel page-aligns it just
> fine.
> 
> The sequence has been choosen to grow the heap first then shrink it to
> the original size, which should be safe since the heap never shrinks
> below its original size.
> 
> We also write to the newly allocated heap in a case that that the heap
> has grown, which should be safe enough in a case that we do not call
> anything that would cause memory to be allocated in the loop, since that
> way we will not rewrite anything that was previously stored there.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
> 
> Changes since v1:
>  - dropped the tst_res(TINFO, ...) in the middle of the loop
>    and updated commit message
>  - used -B when git formatted the patch

Looks good to me.

Regards,
Jan
