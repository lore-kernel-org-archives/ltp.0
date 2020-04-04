From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 4 Apr 2020 20:10:42 +0530
Subject: [LTP] mm/mremap.c : WARNING: at mm/mremap.c:211
 move_page_tables+0x5b0/0x5d0
In-Reply-To: <20200403133252.ivdqoppxhc6w5b47@box>
References: <CA+G9fYs1xStrrsvGbW7bc4h1a0Kjfz0_zn4c7LL7-bGZb0GH6g@mail.gmail.com>
 <20200402133849.mmkvekzx37kw4nsj@box>
 <CA+G9fYv0xNtnD=eBmxVqYqEoYTbMk6mdn04WmgSUasDw2L7uFg@mail.gmail.com>
 <20200403133252.ivdqoppxhc6w5b47@box>
Message-ID: <CA+G9fYsnD0vkCpSH98Lpsi6nxXBS+JYbSPhTnNE16CrQ4s4QhQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 3 Apr 2020 at 19:02, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Apr 03, 2020 at 12:56:57AM +0530, Naresh Kamboju wrote:
> > [  734.876355] old_addr: 0xbfe00000, new_addr: 0xbfc00000, old_end: 0xc0000000
>
> The ranges are overlapping. We don't expect it. mremap(2) never does this.
>
> shift_arg_pages() only moves range downwards. It should be safe.
>
> Could you try this:

Applied the patch and tested and still getting kernel warning.
CONFIG_HIGHMEM64G=y is still enabled.

[  790.041040] ------------[ cut here ]------------
[  790.045664] WARNING: CPU: 3 PID: 3195 at mm/mremap.c:212
move_page_tables+0x7a7/0x840
[  790.053486] Modules linked in: x86_pkg_temp_thermal
[  790.058358] CPU: 3 PID: 3195 Comm: true Tainted: G        W
5.6.2-rc1+ #15
[  790.065915] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  790.073386] EIP: move_page_tables+0x7a7/0x840
[  790.077737] Code: 9f 84 c0 0f 84 b7 fc ff ff 89 c3 e9 ba fe ff ff
8b 40 54 8b 40 10 8b 40 1c 8b 80 20 02 00 00 8b 40 0c 8b 50 08 83 c2
0c eb a7 <0f> 0b e9 55 fd ff ff 8d 45 d8 83 4d e8 01 e8 c6 e6 01 00 e9
ac f8
[  790.096475] EAX: bfe00000 EBX: 00200000 ECX: 07606001 EDX: 07606000
[  790.102732] ESI: c64c0010 EDI: c7606ff8 EBP: c845de14 ESP: c845dd7c
[  790.108989] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
[  790.115764] CR0: 80050033 CR2: b7e13b50 CR3: 064c0000 CR4: 003406f0
[  790.122024] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  790.128281] DR6: fffe0ff0 DR7: 00000400
[  790.132111] Call Trace:
[  790.134558]  setup_arg_pages+0x22c/0x350
[  790.138514]  ? strlcpy+0x33/0x50
[  790.141776]  load_elf_binary+0x352/0x1010
[  790.145788]  ? selinux_inode_permission+0xe5/0x1f0
[  790.150573]  search_binary_handler+0x77/0x1a0
[  790.154931]  __do_execve_file+0x5aa/0x710
[  790.158935]  sys_execve+0x21/0x30
[  790.162246]  do_fast_syscall_32+0x75/0x260
[  790.166336]  entry_SYSENTER_32+0xa5/0xf8
[  790.170254] EIP: 0xb7f12c11
[  790.173045] Code: Bad RIP value.
[  790.176266] EAX: ffffffda EBX: bfc687d0 ECX: 08069420 EDX: bfc68a34
[  790.182548] ESI: 080599d4 EDI: bfc687d9 EBP: bfc68878 ESP: bfc687a8
[  790.188808] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  790.195585] ---[ end trace e8f9014a5c1de460 ]---

full test log,
https://lkft.validation.linaro.org/scheduler/job/1339582#L9858

- Naresh
