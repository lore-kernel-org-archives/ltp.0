From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 13 Jan 2021 10:23:46 +0800
Subject: [LTP] [PATCH 0/3] Build fix undefined struct file_handle
In-Reply-To: <20210112193039.12506-1-pvorel@suse.cz>
References: <20210112193039.12506-1-pvorel@suse.cz>
Message-ID: <5FFE59B2.1040903@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
I think detecting file_handle struct(it is in fcntl.h) in configure.ac 
is correct instead of using HAVE_NAME_TO_HANDLE_AT macro directly.

Best Regards
Yang Xu
> Hi all,
>
> this would be great to get merged before release.
>
> Kind regards,
> Petr
>
> Petr Vorel (3):
>    lapi: Move struct file_handle into lapi/fcntl.h
>    fanotify: Fix build on undefined struct file_handle
>    syscalls: Remove unused include<fcntl.h>
>
>   include/lapi/fcntl.h                                   | 10 ++++++++++
>   include/lapi/name_to_handle_at.h                       |  9 +--------
>   testcases/kernel/syscalls/fanotify/fanotify.h          |  2 +-
>   testcases/kernel/syscalls/fanotify/fanotify09.c        |  1 -
>   testcases/kernel/syscalls/fanotify/fanotify13.c        |  1 -
>   testcases/kernel/syscalls/fanotify/fanotify15.c        |  1 -
>   testcases/kernel/syscalls/fanotify/fanotify16.c        |  1 -
>   .../syscalls/name_to_handle_at/name_to_handle_at01.c   |  1 -
>   .../syscalls/name_to_handle_at/name_to_handle_at02.c   |  1 -
>   .../syscalls/open_by_handle_at/open_by_handle_at01.c   |  1 -
>   .../syscalls/open_by_handle_at/open_by_handle_at02.c   |  1 -
>   11 files changed, 12 insertions(+), 17 deletions(-)
>



