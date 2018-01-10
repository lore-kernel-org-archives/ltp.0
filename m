From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Jan 2018 10:35:10 -0500 (EST)
Subject: [LTP] migrate_pages() of process with same UID in 4.15-rcX
In-Reply-To: <1243932888.5206621.1515594158029.JavaMail.zimbra@redhat.com>
Message-ID: <1394749328.5225281.1515598510696.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

LTP test migrate_pages02 [1] is failing with 4.15-rcX, presumably as
consequence of:
  313674661925 "Unify migrate_pages and move_pages access checks"

The scenario is that privileged parent forks child, both parent
and child change euid to nobody and then parent tries to migrate
child to different node. Starting with 4.15-rcX it fails with EPERM.

Can anyone comment on accuracy of this sentence from man-pages
after commit 313674661925?

quoting man2/migrate_pages.2:
 "To move pages in another process, the caller must be privileged
 (CAP_SYS_NICE) or the real or effective user ID of the calling 
 process must match the real or saved-set user ID of the target
 process."

Thanks,
Jan

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
