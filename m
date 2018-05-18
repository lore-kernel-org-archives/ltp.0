From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 May 2018 15:25:36 +0200
Subject: [LTP] [PATCH] syscalls/shmctl05: new test for IPC file
 use-after-free bug
In-Reply-To: <20180513012325.877-1-ebiggers3@gmail.com>
References: <20180513012325.877-1-ebiggers3@gmail.com>
Message-ID: <20180518132536.GB32299@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
> @@ -0,0 +1,113 @@
> +/*
> + * Copyright (c) 2018 Google, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program, if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Regression test for commit 3f05317d9889 ("ipc/shm: fix use-after-free of shm
> + * file via remap_file_pages()").  This bug allowed the remap_file_pages()
> + * syscall to use the file of a System V shared memory segment after its ID had
> + * been reallocated and the file freed.  This test reproduces the bug as a NULL
> + * pointer dereference in touch_atime(), although it's a race condition so it's
> + * not guaranteed to work.  This test is based on the reproducer provided in the
> + * fix's commit message.
> + */

Have you considered using the fuzzy sync library here?

https://github.com/linux-test-project/ltp/blob/master/include/tst_fuzzy_sync.h

-- 
Cyril Hrubis
chrubis@suse.cz
