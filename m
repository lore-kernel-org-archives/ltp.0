From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Wed, 14 Oct 2020 21:47:01 +0900
Subject: [LTP] BUG: KASAN: global-out-of-bounds in vprintk_store on
 x86_64
In-Reply-To: <CA+G9fYt46oC7-BKryNDaaXPJ9GztvS2cs_7GjYRjanRi4+ryCQ@mail.gmail.com>
References: <CA+G9fYt46oC7-BKryNDaaXPJ9GztvS2cs_7GjYRjanRi4+ryCQ@mail.gmail.com>
Message-ID: <20201014124701.GA614@jagdpanzerIV.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On (20/10/14 16:19), Naresh Kamboju wrote:
> Crash log:
> --------------
> [  221.921944] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=c,mems_allowed=0,oom_memcg=/0,task_memcg=in
> [  221.922108] ==================================================================
> [  221.922111] BUG: KASAN: global-out-of-bounds in vprintk_store+0x362/0x3d0
> [  221.922112] Write of size 2 at addr ffffffffba51dbcd by task
> memcg_test_1/11282
> [  221.922113]
> [  221.922114] CPU: 1 PID: 11282 Comm: memcg_test_1 Not tainted
> 5.9.0-next-20201013 #1
> [  221.922116] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [  221.922116] Call Trace:
> [  221.922117]  dump_stack+0xa4/0xd9
> [  221.922118]  print_address_description.constprop.0+0x21/0x210
> [  221.922119]  ? _raw_write_lock_bh+0xe0/0xe0
> [  221.922120]  ? vprintk_store+0x362/0x3d0
> [  221.922121]  kasan_report.cold+0x37/0x7c
> [  221.922122]  ? vprintk_store+0x362/0x3d0
> [  221.922123]  check_memory_region+0x18c/0x1f0
> [  221.922124]  memcpy+0x3c/0x60
> [  221.922125]  vprintk_store+0x362/0x3d0
> [  221.922125]  ? __ia32_sys_syslog+0x50/0x50
> [  221.922126]  ? _raw_spin_lock_irqsave+0x9b/0x100
> [  221.922127]  ? _raw_spin_lock_irq+0xf0/0xf0
> [  221.922128]  ? __kasan_check_write+0x14/0x20
> [  221.922129]  vprintk_emit+0x8d/0x1f0
> [  221.922130]  vprintk_default+0x1d/0x20
> [  221.922131]  vprintk_func+0x5a/0x100
> [  221.922132]  printk+0xb2/0xe3
> [  221.922133]  ? swsusp_write.cold+0x189/0x189
> [  221.922134]  ? kernfs_vfs_xattr_set+0x60/0x60
> [  221.922134]  ? _raw_write_lock_bh+0xe0/0xe0
> [  221.922135]  ? trace_hardirqs_on+0x38/0x100
> [  221.922136]  pr_cont_kernfs_path.cold+0x49/0x4b

A side note,
So this brings the question:


	#define PATH_MAX        4096

	static char kernfs_pr_cont_buf[PATH_MAX];

	void pr_cont_kernfs_path(struct kernfs_node *kn)
	{
	...
		if (sz >= sizeof(kernfs_pr_cont_buf)) {
			pr_cont("(name too long)");
			goto out;
		}
	
		pr_cont("%s", kernfs_pr_cont_buf);
	...
	}

Do we still want to limit printk line to 1024?
There are functions that want longer lines (e.g. kernel boot command
line).

	-ss
