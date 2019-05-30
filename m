From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 May 2019 13:10:30 +0200
Subject: [LTP] [PATCH 2/2] syscalls: update tcases using dev_fs_type to
 use some_filesystems
In-Reply-To: <20190530102336.10898-2-xzhou@redhat.com>
References: <20190530102336.10898-1-xzhou@redhat.com>
 <20190530102336.10898-2-xzhou@redhat.com>
Message-ID: <20190530111030.GC31468@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  .../kernel/syscalls/copy_file_range/copy_file_range02.c   | 8 ++++++--

I guess that we can enable the this test for all filesystems, there is
in-kernel fallback for filesystems that does not support the syscall so
it should work on all filesystems and the fallback code should be tested
as well.

>  testcases/kernel/syscalls/getxattr/getxattr04.c           | 7 +++++--

Well I would be slightly in favor of enabling this test for all
filesystems as well.

If we ever want to maintain list of filesystems that support extended
attributes there should be only one somewhere in the test library so
that we don't have to change thousand testcases later on.

-- 
Cyril Hrubis
chrubis@suse.cz
