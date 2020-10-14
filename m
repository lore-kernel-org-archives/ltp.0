From: Petr Mladek <mladek.petr@gmail.com>
Date: Wed, 14 Oct 2020 17:13:11 +0200
Subject: [LTP] BUG: KASAN: global-out-of-bounds in vprintk_store on
 x86_64
In-Reply-To: <20201014140514.GB17231@alley>
References: <CA+G9fYt46oC7-BKryNDaaXPJ9GztvS2cs_7GjYRjanRi4+ryCQ@mail.gmail.com>
 <20201014140514.GB17231@alley>
Message-ID: <20201014151311.GB13775@alley>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed 2020-10-14 16:05:20, Petr Mladek wrote:
> On Wed 2020-10-14 16:19:18, Naresh Kamboju wrote:
> > While testing LTP controllers testing on x86_64 KASAN enabled linux
> > next 20201013 tag
> > kernel this kernel BUG noticed. The oom-killer log also noticed while
> > running tests.
> > 
> > metadata:
> >   git branch: master
> >   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git commit: f2fb1afc57304f9dd68c20a08270e287470af2eb
> >   git describe: next-20201013
> >   make_kernelversion: 5.9.0
> >   kernel-config:
> > https://builds.tuxbuild.com/TXP6cqokP8BCYJrv7zf6kw/kernel.config
> > 
> This is the last string stored in the ring buffer before KASAN trigerred.
> 
> > [  221.922108] ==================================================================
> > [  221.922111] BUG: KASAN: global-out-of-bounds in vprintk_store+0x362/0x3d0
> > [  221.922112] Write of size 2 at addr ffffffffba51dbcd by task
> > memcg_test_1/11282
> 
> > [  221.922114] CPU: 1 PID: 11282 Comm: memcg_test_1 Not tainted
> > 5.9.0-next-20201013 #1
> > [  221.922116] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.0b 07/27/2017
> > [  221.922116] Call Trace:
> > [  221.922117]  dump_stack+0xa4/0xd9
> > [  221.922118]  print_address_description.constprop.0+0x21/0x210
> > [  221.922119]  ? _raw_write_lock_bh+0xe0/0xe0
> > [  221.922120]  ? vprintk_store+0x362/0x3d0
> > [  221.922121]  kasan_report.cold+0x37/0x7c
> > [  221.922122]  ? vprintk_store+0x362/0x3d0
> > [  221.922123]  check_memory_region+0x18c/0x1f0
> > [  221.922124]  memcpy+0x3c/0x60
> > [  221.922125]  vprintk_store+0x362/0x3d0
> 
> It seems that vprintk() store was able to extend the last string
> by the two characters. So this is likely:
> 
> static size_t log_output(int facility, int level, enum log_flags lflags,
> 			 const struct dev_printk_info *dev_info,
> 			 char *text, size_t text_len)
> {
> [...]
> 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
> 			memcpy(&r.text_buf[r.info->text_len], text, text_len);
> 
> But very likely the two characters were copied to wrong location.
> There are many similar lines in the full log and they always contain
> 
>     task_memcg=/0
> 
> It means that the size of the path is 2 characters but it should be
> "/0". I guess that "in" was in the log buffer from the previous
> wrap.
> 
> So, it seems that prb_reserve_in_last() correctly updated the size
> of the extended record but it returned wrong pointer to the buffer
> or wrong current length.
> 
> Anyway, prb_commit(&e) moved the buffer back to consistent state.


> > [  213O[  221.922182] The buggy address belongs to the variable:
> > [  221.922183]  clear_seq+0x2d/0x40
> 
> The address ffffffffba51dbcd seems to be from the range of
> "module mapping space" adresses.
> 
> "clear_seq" is static variable from kernel/printk/printk.c.

There is a bug in data_realloc(). We return wrong pointer when there
is no need to resize the record and it has been wrapped.

It might happen when we add only few characters and there was
a space because of alignment.

It would cause writing outside the buffer into another statically
defined variables. So, it might be it.

The following change patch should fix it:


diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 2493348a1631..24a960a89aa8 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1125,7 +1125,10 @@ static char *data_realloc(struct printk_ringbuffer *rb,
 
 	/* If the data block does not increase, there is nothing to do. */
 	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
-		blk = to_block(data_ring, blk_lpos->begin);
+		if (wrapped)
+			blk = to_block(data_ring, 0);
+		else
+			blk = to_block(data_ring, blk_lpos->begin);
 		return &blk->data[0];
 	}
 
