From: Ghislain <gadnet@aqueos.com>
Date: Fri, 13 Nov 2015 10:44:43 +0100
Subject: [LTP] new user to ltp
Message-ID: <5645B10B.9030708@aqueos.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hi,

  i stumbled upon this project while i was searching for a tool that 
could tell me if my custom compiled kernel is not broken compared to the 
one used in distro (as i nedded a patch applied). After trying the ltp 
script i tried to run it on several kernels and both crashed even the 
debian ones:

- debian 3.16 (ionotify06)
Message from syslogd@62-210-125-37 at Nov 12 17:54:53 ...
  kernel:[ 6266.914342] BUG: soft lockup - CPU#1 stuck for 24s! 
[inotify06:2674]

Nov 11 17:26:14 62-210-125-37 kernel: [    0.000000] Linux version 
3.16.0-4-amd64 (debian-kernel@lists.debian.org) (gcc version 4.8.4 
(Debian 4.8.4-1) ) #1 SMP Debian 3.16.7-ckt11-1+deb8u5 (2015-10-09)
****
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606043] NMI backtrace for 
cpu 0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606044] CPU: 0 PID: 27523 
Comm: inotify06 Not tainted 3.16.0-4-amd64 #1 Debian 3.16.7-ckt11-1+deb8u5
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606044] Hardware name: 
Dell Inc. PowerEdge R210 II/03X6X0, BIOS 2.5.1 07/11/2013
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606045] task: 
ffff88042eb76050 ti: ffff88025d71c000 task.ti: ffff88025d71c000
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606048] RIP: 
0010:[<ffffffff81317b19>]  [<ffffffff81317b19>] cfb_imageblit+0x4f9/0x530
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606049] RSP: 
0018:ffff88043fc039d8  EFLAGS: 00000086
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606049] RAX: 
0000000000000000 RBX: 0000000000000004 RCX: 0000000000000004
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606050] RDX: 
00000000ff000000 RSI: 0000000000000074 RDI: 00000000ff000000
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606050] RBP: 
ffff88042eb3e2a0 R08: 0000000000000001 R09: ffffffff81659ac0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606051] R10: 
0000000000000001 R11: 0000000000000000 R12: ffffc90011ddb68c
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606051] R13: 
ffff88042eb3e2a1 R14: ffffc90011ddb690 R15: ffffc90011ddb660
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606052] FS: 
00007fd6677af700(0000) GS:ffff88043fc00000(0000) knlGS:0000000000000000
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606053] CS:  0010 DS: 0000 
ES: 0000 CR0: 0000000080050033
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606053] CR2: 
000000000060ae00 CR3: 000000042b047000 CR4: 00000000000407f0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606053] Stack:
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606054] ffffc90000000080 
0000000000000010 0000000000001000 000000803fc0ce40
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606055] ffff88043fc4ce80 
0000000000000082 0000020000000082 000000000000ce80
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606056] 000000fd00000000 
ffff88042eb3e200 0000000000000010 0000000000000000
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606056] Call Trace:
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606057]  <IRQ>
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606059] 
[<ffffffff8130a90a>] ? bit_putcs+0x2ea/0x4e0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606061] 
[<ffffffff8108a7f1>] ? enqueue_hrtimer+0x21/0x80
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606062] 
[<ffffffff8130a5eb>] ? bit_cursor+0x58b/0x5c0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606065] 
[<ffffffff81305a5a>] ? fbcon_putcs+0x12a/0x160
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606065] 
[<ffffffff8130a620>] ? bit_cursor+0x5c0/0x5c0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606067] 
[<ffffffff81305d86>] ? fbcon_redraw.isra.25+0x1a6/0x210
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606068] 
[<ffffffff8130715a>] ? fbcon_scroll+0x1ea/0xd00
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606070] 
[<ffffffff81378a6b>] ? scrup+0xdb/0xf0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606071] 
[<ffffffff81378b00>] ? lf+0x80/0x90
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606072] 
[<ffffffff8137962c>] ? vt_console_print+0x2ac/0x3f0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606075] 
[<ffffffff810b7af2>] ? call_console_drivers.constprop.24+0x92/0xf0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606076] 
[<ffffffff810b8977>] ? console_unlock+0x2e7/0x430
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606077] 
[<ffffffff810b8d40>] ? vprintk_emit+0x280/0x550
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606079] 
[<ffffffff81508a4c>] ? printk+0x54/0x56
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606081] 
[<ffffffff810a0b5e>] ? task_tick_fair+0x46e/0x640
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606082] 
[<ffffffff810c53c0>] ? rcu_check_callbacks+0x3e0/0x630
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606084] 
[<ffffffff810c6f15>] ? timekeeping_update.constprop.9+0x35/0x70
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606085] 
[<ffffffff810cfde0>] ? tick_sched_handle.isra.16+0x60/0x60
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606087] 
[<ffffffff81074ab0>] ? update_process_times+0x40/0x70
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606088] 
[<ffffffff810cfda0>] ? tick_sched_handle.isra.16+0x20/0x60
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606089] 
[<ffffffff810cfe1c>] ? tick_sched_timer+0x3c/0x60
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606090] 
[<ffffffff8108b067>] ? __run_hrtimer+0x67/0x1c0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606091] 
[<ffffffff8108b419>] ? hrtimer_interrupt+0xe9/0x220
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606092] 
[<ffffffff8151456b>] ? smp_apic_timer_interrupt+0x3b/0x60
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606094] 
[<ffffffff815125fd>] ? apic_timer_interrupt+0x6d/0x80
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606094]  <EOI>
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606095] 
[<ffffffff815111ce>] ? _raw_spin_lock+0xe/0x30
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606098] 
[<ffffffff811e3c54>] ? fsnotify_destroy_mark_locked+0x24/0x150
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606100] 
[<ffffffff811e40a4>] ? fsnotify_clear_marks_by_group_flags+0x74/0xa0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606101] 
[<ffffffff811e33ae>] ? fsnotify_destroy_group+0xe/0x40
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606103] 
[<ffffffff811e51ee>] ? inotify_release+0x1e/0x50
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606104] 
[<ffffffff811a9b4a>] ? __fput+0xca/0x1d0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606106] 
[<ffffffff810851a7>] ? task_work_run+0x97/0xd0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606108] 
[<ffffffff81012e99>] ? do_notify_resume+0x69/0xa0
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606109] 
[<ffffffff8151194a>] ? int_signal+0x12/0x17
Nov 13 08:48:47 62-210-125-37 kernel: [149628.606118] Code: 04 24 eb 34 
66 0f 1f 44 00 00 41 0f be 55 00 44 29 c1 4d 8d 74 24 04 d3 fa 44 21 d2 
41 8b 04 91 44 21 d8 89 c2 31 fa 41 89 14 24 <85> c9 75 06 49 83 c5 01 
b1 08 4d 89 f4 83 ee 01 83 fe ff 75 ca
Nov 13 08:48:47 62-210-125-37 kernel: [149631.941491] sending NMI to all 
CPUs:


- vanilla 4.1.12 (lock_torture_re)
Nov  9 10:12:53 62-210-125-37 kernel: [    0.000000] Linux version 
4.1.12 (root@buildjessie64.aqueos.net) (gcc version 4.9.2 (Debian 
4.9.2-10) ) #1 SMP Mon Nov 9 09:16:13 CET 2015
Nov  9 14:51:47 62-210-125-37 kernel: [16455.811285] Writes:  Total: 
191554485  Max/Min: 0/0   Fail: 0
Nov  9 14:51:47 62-210-125-37 kernel: [16455.838665] 
spin_lock_irq-torture: Stopping lock_torture_stats
Nov  9 14:51:47 62-210-125-37 kernel: [16455.864328] Writes:  Total: 
191554485  Max/Min: 0/0   Fail: 0
Nov  9 14:51:47 62-210-125-37 kernel: [16455.888892] 
spin_lock_irq-torture:--- End of test: SUCCESS: nwriters_stress=8 
nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 
stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
Nov  9 14:51:47 62-210-125-37 kernel: [16455.954404] rw_lock-torture:--- 
Start of test: nwriters_stress=4 nreaders_stress=4 stat_interval=60 
verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=0 
onoff_holdoff=0
Nov  9 14:51:47 62-210-125-37 kernel: [16456.016119] rw_lock-torture: 
Creating torture_shuffle task
Nov  9 14:51:48 62-210-125-37 kernel: [16456.048085] rw_lock-torture: 
Creating torture_stutter task
Nov  9 14:51:48 62-210-125-37 kernel: [16456.048122] rw_lock-torture: 
torture_shuffle task started
Nov  9 14:51:48 62-210-125-37 kernel: [16456.109988] rw_lock-torture: 
Creating lock_torture_writer task
Nov  9 14:51:48 62-210-125-37 kernel: [16456.110020] rw_lock-torture: 
torture_stutter task started
Nov  9 14:51:48 62-210-125-37 kernel: [16456.171992] rw_lock-torture: 
Creating lock_torture_reader task
Nov  9 14:51:48 62-210-125-37 kernel: [16456.171996] rw_lock-torture: 
lock_torture_writer task started
Nov  9 14:51:48 62-210-125-37 kernel: [16456.233841] rw_lock-torture: 
Creating lock_torture_writer task
Nov  9 14:51:48 62-210-125-37 kernel: [16456.233870] rw_lock-torture: 
lock_torture_reader task started
Nov  9 14:51:48 62-210-125-37 kernel: [16456.297098] rw_lock-torture: 
Creating lock_torture_reader task
Nov  9 14:51:48 62-210-125-37 kernel: [16456.297127] rw_lock-torture: 
lock_torture_writer task started

then crash with BUG: soft lockup - CPU#1 stuck for xxs

so, i just wanted to ask if this is supposed to happen even on the 
debian one or if this is because i run the tool in brainless mode ( 
./runltp  -d /var/tmp/     -b /dev/mapper/vserverpool-testcq ) without 
really understanding the real way to use it.
Perhaps it is not usefull to test the way i try it like this so excuse 
my errors if this is the case :)

best regards,
Ghislain.




