From: $rik@nth  <srikanth007m@gmail.com>
Date: Thu, 8 Oct 2015 22:42:47 +0530
Subject: [LTP]  inotify06 test causing kernel panic
Message-ID: <CANKSX+G1QKMqRF8TzSxGQAe=i+VQFAqmL8qpBTdaup1pSzivww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

on latest available LTP release there is one newly added test
`inotify06 `. Which is causing kernel panic. Is the test targeted to
>4.0 kernel? Can anyone confirm.

Kernel version i am using is 3.18.


2703.726959:   <6> Process inotify06 (pid: 14532, stack limit =
0xffffffc063d08058)
  2703.733988:   <6> Call trace:
  2703.736427:   <2> [<ffffffc0001d3ab8>]
fsnotify_clear_marks_by_group_flags+0x6c/0x98
  2703.743629:   <2> [<ffffffc0001d3af0>] fsnotify_clear_marks_by_group+0xc/0x18
  2703.750225:   <2> [<ffffffc0001d2d80>] fsnotify_destroy_group+0x10/0x50
  2703.756302:   <2> [<ffffffc0001d4b74>] inotify_release+0x40/0x54
  2703.761773:   <2> [<ffffffc00019d7e8>] __fput+0x100/0x1c8
  2703.766631:   <2> [<ffffffc00019d904>] ____fput+0x8/0x14
  2703.771409:   <2> [<ffffffc0000b53a0>] task_work_run+0xb0/0xe4
  2703.776701:   <2> [<ffffffc000088290>] do_notify_resume+0x44/0x5c
  2703.782259:   <6> Code: aa1603e1 97fffed6 aa1303e0 97fffe7b (f9400a80)
  2703.788723:   <6> ---[ end trace 1c4cbab85cd92d3d ]---
  2703.793077:   <6> Kernel panic - not syncing: Fatal exception

-- 
Thanks & Regards,
M.Srikanth Kumar.
