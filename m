From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 15:58:12 +0100
Subject: [LTP] [PATCH v2 2/5] syscalls/ipc: add newipc library for new
	API
In-Reply-To: <1481087800-20639-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1481087800-20639-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161212145811.GE21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/syscalls/ipc/libnewipc/Makefile b/testcases/kernel/syscalls/ipc/libnewipc/Makefile
> new file mode 100644
> index 0000000..e5190f9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/libnewipc/Makefile
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
> +#
> +# This program is free software;  you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +# the GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.
> +#
> +
> +top_srcdir		?= ../../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +LIB			:= libnewipc.a

Should be INTERNAL_LIB so that it's skipped at installation phase.

> +include $(top_srcdir)/include/mk/lib.mk
> diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
> new file mode 100644
> index 0000000..5e27662
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
> @@ -0,0 +1,145 @@
> +/*
> + * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
> + */
> +
> +/*
> + * DESCRIPTION
> + * common routines for the IPC system call tests.
> + *
> + * The library contains the following routines:
> + * getipckey()
> + * rm_queue()
> + * rm_sema()
> + * rm_shm()
> + * get_used_msgqueues()
> + * get_max_msgqueues()

This is kind of redundant information, pretty much anybody can see what
functions are implemented here.

> + */
> +
> +#define NEWLIBIPC

This macro seems to be unused.

> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdlib.h>
> +#include <pwd.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <sys/shm.h>
> +#include <sys/sem.h>
> +
> +#include "libnewipc.h"
> +#include "tst_res_flags.h"
> +#include "tst_res.h"
> +#include "tst_safe_macros.h"
> +#include "lapi/semun.h"
> +
> +#define BUFSIZE 512
> +
> +key_t getipckey(void)
> +{
> +	int ascii_a = (int) 'a';

Eh, why do you store the value into an variable when you can just use
the (int) 'a' in the computation directly...

> +	char buf[BUFSIZE];
> +	key_t key;
> +	int id;
> +	static int count;
> +
> +	SAFE_GETCWD(buf, BUFSIZE);
> +
> +	id = count % 26 + ascii_a;
> +	count++;

This could be written just as:

	id = (count++) % 26 + (int)'a';

> +	key = ftok(buf, id);
> +	if (key == -1)
> +		tst_brk(TBROK | TERRNO, "ftok() failed");
> +
> +	return key;
> +}
> +
> +void rm_queue(int queue_id)
> +{
> +	if (queue_id == -1)
> +		return;
> +
> +	if (msgctl(queue_id, IPC_RMID, NULL) == -1) {
> +		tst_res(TINFO, "WARNING: message queue deletion failed.");
                         ^
			 This really should be TWARN, even the message
			 includes 'WARNING' in the string. And we should
			 include errno with TERRNO as well.

			 Or even better we should exit the test with
			 TBROK here.

> +		tst_res(TINFO, "This could lead to IPC resource problems.");
> +		tst_res(TINFO, "id = %d", queue_id);
> +	}
> +}
> +
> +void rm_sema(int sem_id)
> +{
> +	union semun arr;
> +
> +	if (sem_id == -1)
> +		return;
> +
> +	if (semctl(sem_id, 0, IPC_RMID, arr) == -1) {
> +		tst_res(TINFO, "WARNING: semaphore deletion failed.");
                        ^
			Here as well.

> +		tst_res(TINFO, "This could lead to IPC resource problems.");
> +		tst_res(TINFO, "id = %d", sem_id);
> +	}
> +}
> +
> +void rm_shm(int shm_id)
> +{
> +	if (shm_id == -1)
> +		return;
> +
> +	if (shmctl(shm_id, IPC_RMID, NULL) == -1) {
> +		tst_res(TINFO, "WARNING: shared memory deletion failed.");
                              ^
			      And here as well.

> +		tst_res(TINFO, "This could lead to IPC resource problems.");
> +		tst_res(TINFO, "id = %d", shm_id);
> +	}
> +}

Moreover these there calls should really be implemented in a similar
style as SAFE_MACROS. I.e. macro RM_SHM() would pass filename and lineno
to the actuall function so that it can be printed in the resulting error
message.

> +int get_used_msgqueues(void)
> +{
> +	FILE *f;
> +	int used_queues;
> +	char buf[BUFSIZE];
> +
> +	f = popen("ipcs -q", "r");
> +	if (!f)
> +		tst_brk(TBROK | TERRNO, "pipe failed");
> +
> +	/* FIXME: Start at -4 because ipcs prints four lines of header */
> +	for (used_queues = -4; fgets(buf, BUFSIZE, f); used_queues++);
> +
> +	pclose(f);

Parsing output of a ipcs looks quite fragile to me. Why can't we use
/proc/sysvipc/msg directly instead?

> +	if (used_queues < 0) {
> +		tst_brk(TBROK, "Could not read output of 'ipcs' to "
> +			"calculate used message queues");
> +	}
> +
> +	return used_queues;
> +}
> +
> +int get_max_msgqueues(void)
> +{
> +	int fd;
> +	char buf[BUFSIZE];
> +
> +	fd = SAFE_OPEN("/proc/sys/kernel/msgmni", O_RDONLY);
> +
> +	SAFE_READ(0, fd, buf, BUFSIZE);
> +
> +	SAFE_CLOSE(fd);
> +
> +	return atoi(buf);

We have SAFE_FILE_SCANF() exactly for this purpose.

> +}
> diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
> new file mode 100644
> index 0000000..6a3064d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
> + */
> +
> +/*
> + * common definitions for the IPC system calls.
> + */
> +
> +#ifndef __NEWIPC_H
> +#define __NEWIPC_H	1

Identifiers starting with underscore are reserved for system libraries
such as libc. Use something as LIBNEWIPC_H__ here.

> +#define MSG_RD	0400
> +#define MSG_WR	0200
> +#define MSG_RW	(MSG_RD | MSG_WR)
> +#define MSGSIZE	1024
> +#define MSGTYPE	1
> +#define NR_MSGQUEUES	16
> +#define min(a, b)	(((a) < (b)) ? @ : (b))
> +
> +#define SEM_RD	0400
> +#define SEM_ALT	0200
> +#define SEM_RA	(SEM_RD | SEM_ALT)
> +#define PSEMS	10
> +
> +#define SHM_RD	0400
> +#define SHM_WR	0200
> +#define SHM_RW	(SHM_RD | SHM_WR)
> +#define SHM_SIZE	2048
> +#define INT_SIZE	4
> +#define MODE_MASK	0x01FF
> +
> +key_t getipckey(void);
> +void rm_queue(int queue_id);
> +void rm_sem(int sem_id);
> +void rm_shm(int shm_id);
> +int get_used_msgqueues(void);
> +int get_max_msgqueues(void);
> +
> +#endif /* newlibipc.h */
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
