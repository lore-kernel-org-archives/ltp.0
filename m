From: Li Wang <liwan@redhat.com>
Date: Fri, 22 Jun 2018 16:44:15 +0800
Subject: [LTP] [PATCH] cve/meltdown: read *saved_command_line
In-Reply-To: <761d2d176c0765f3913e140191ceaf83aa745424.1529495077.git.jstancek@redhat.com>
References: <761d2d176c0765f3913e140191ceaf83aa745424.1529495077.git.jstancek@redhat.com>
Message-ID: <CAEemH2cufv8yc4CVkCTjFwa2dqUyefSX_we95GobYYNHYL-YeA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Wed, Jun 20, 2018 at 7:51 PM, Jan Stancek <jstancek@redhat.com> wrote:
> After commit 8c06c7740d19 ("x86/pti: Leave kernel text global for !PCID"),
> kernel can now map all of kernel text into the user page tables.
> So, read of "linux_proc_banner" can succeed and report a false positive.
>
> This patch changes the test to read value of "saved_command_line"
> pointer and then also memory pointed to by it. And compares result
> (first 32 bytes) to /proc/cmdline. saved_command_line string is
> allocated dynamically and falls outside of (_text, _end) area:
>   crash> p/x _text
>   $2 = 0xffffffff81000000 <startup_64>
>   crash> p/x _end
>   $3 = 0xffffffff82411000
>   crash> p/x &saved_command_line
>   $4 = 0xffffffff81cf3008
>   crash> p/x saved_command_line
>   $5 = 0xffff88007ff55100
> so test should work on kernels with and without the patch.

Awesome!

I tried this on a kvm guest(didn't have pcid && pti_mode == PTI_AUTO)
which leaving all kernel text global, the program was able to read
'&saved_command_line'(which located in kernel text area) and
'saved_command_line' value, but it could NOT read the content of
saved_command_line point to. So I think this patch is making sense.

# uname  -r
4.18.0-rc1.fi+

# systemd-detect-virt
kvm

# journalctl |grep isolation
Jun 22 01:13:43 localhost.localdomain kernel: Kernel/User page tables
isolation: enabled

# ./meltdown
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
meltdown.c:259: INFO: access time: cached = 77, uncached = 272, threshold = 144
meltdown.c:309: INFO: &saved_command_line == 0xffffffff86f90240
meltdown.c:342: INFO: read ffffffff86f90240 = 0x80
meltdown.c:342: INFO: read ffffffff86f90241 = 0xc5
meltdown.c:342: INFO: read ffffffff86f90242 = 0xf4
meltdown.c:342: INFO: read ffffffff86f90243 = 0x7f
meltdown.c:342: INFO: read ffffffff86f90244 = 0x01
meltdown.c:342: INFO: read ffffffff86f90245 = 0x88
meltdown.c:342: INFO: read ffffffff86f90246 = 0xff
meltdown.c:342: INFO: read ffffffff86f90247 = 0xff
meltdown.c:350: INFO: save_command_line: 0xffff88017ff4c580
meltdown.c:362: INFO: read ffff88017ff4c580 = 0x00   | expected 0x42 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c581 = 0x00   | expected 0x4f | match: 0
meltdown.c:362: INFO: read ffff88017ff4c582 = 0x00   | expected 0x4f | match: 0
meltdown.c:362: INFO: read ffff88017ff4c583 = 0x00   | expected 0x54 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c584 = 0x00   | expected 0x5f | match: 0
meltdown.c:362: INFO: read ffff88017ff4c585 = 0x00   | expected 0x49 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c586 = 0x00   | expected 0x4d | match: 0
meltdown.c:362: INFO: read ffff88017ff4c587 = 0x00   | expected 0x41 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c588 = 0x00   | expected 0x47 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c589 = 0x00   | expected 0x45 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c58a = 0x00   | expected 0x3d | match: 0
meltdown.c:362: INFO: read ffff88017ff4c58b = 0x00   | expected 0x2f | match: 0
meltdown.c:362: INFO: read ffff88017ff4c58c = 0x00   | expected 0x76 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c58d = 0x00   | expected 0x6d | match: 0
meltdown.c:362: INFO: read ffff88017ff4c58e = 0x00   | expected 0x6c | match: 0
meltdown.c:362: INFO: read ffff88017ff4c58f = 0x00   | expected 0x69 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c590 = 0x00   | expected 0x6e | match: 0
meltdown.c:362: INFO: read ffff88017ff4c591 = 0x00   | expected 0x75 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c592 = 0x00   | expected 0x7a | match: 0
meltdown.c:362: INFO: read ffff88017ff4c593 = 0x00   | expected 0x2d | match: 0
meltdown.c:362: INFO: read ffff88017ff4c594 = 0x00   | expected 0x34 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c595 = 0x00   | expected 0x2e | match: 0
meltdown.c:362: INFO: read ffff88017ff4c596 = 0x00   | expected 0x31 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c597 = 0x00   | expected 0x38 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c598 = 0x00   | expected 0x2e | match: 0
meltdown.c:362: INFO: read ffff88017ff4c599 = 0x00   | expected 0x30 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c59a = 0x00   | expected 0x2d | match: 0
meltdown.c:362: INFO: read ffff88017ff4c59b = 0x00   | expected 0x72 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c59c = 0x00   | expected 0x63 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c59d = 0x00   | expected 0x31 | match: 0
meltdown.c:362: INFO: read ffff88017ff4c59e = 0x00   | expected 0x2e | match: 0
meltdown.c:362: INFO: read ffff88017ff4c59f = 0x00   | expected 0x66 | match: 0
meltdown.c:375: PASS: I was not able to read your kernel memory
meltdown.c:376: INFO: score(matched/all): 0 / 32

Summary:
passed   1
failed   0
skipped  0
warnings 0

>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
