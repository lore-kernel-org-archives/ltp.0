From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 May 2020 07:53:18 +0200
Subject: [LTP] [PATCH v2 0/4] fanotify ltp tests for v5.7-rc1
In-Reply-To: <20200502162744.9589-1-amir73il@gmail.com>
References: <20200502162744.9589-1-amir73il@gmail.com>
Message-ID: <20200504055318.GA11558@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Hi Petr,

> Following patches test fanotify kernel code merged to v5.7-rc1.

> Changes since v1:
> - Patch to fanotify09 has already been merged
> - Addressed comments by Petr, Cyril, Matthew and added reviewed-by
> - Added patch to use new helper fanotify_save_fid by other tests

> Patch 3 adds a new test for the new event type FAN_MODIFY_DIR, which
> carries a new event format (parent fid + name).
> The man page patches for FAN_MODIFY_DIR have already been merged.

LGTM, I'll just fix failure on MUSl and then merge
https://travis-ci.org/github/pevik/ltp/jobs/682785812

Kind regards,
Petr

> Thanks all for the review,
> Amir.

> Amir Goldstein (4):
>   syscalls/fanotify15: Minor corrections
>   syscalls/fanotify15: Add a test case for inode marks
>   syscalls/fanotify: New test for FAN_MODIFY_DIR
>   syscalls/fanotify: Use fanotify_save_fid() helper

>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  testcases/kernel/syscalls/fanotify/fanotify.h |  36 +-
>  .../kernel/syscalls/fanotify/fanotify13.c     |  44 +-
>  .../kernel/syscalls/fanotify/fanotify15.c     | 191 ++++++---
>  .../kernel/syscalls/fanotify/fanotify16.c     | 403 ++++++++++++++++++
>  6 files changed, 596 insertions(+), 80 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify16.c
