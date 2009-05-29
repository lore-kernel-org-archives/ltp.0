Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MA1cT-0007MI-Nw
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:55:33 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA1cQ-0001Wp-Rh
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:55:33 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4TCnrtL015836
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:49:53 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4TCtUcN249582
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:55:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4TCtTVm028450
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:55:30 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090527100710.18638.29072.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
	<20090527100710.18638.29072.sendpatchset@subratamodak.linux.ibm.com>
Date: Fri, 29 May 2009 18:25:25 +0530
Message-Id: <1243601725.5188.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 01/13] Add/Port Utility Headers for these set of
	tests
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Manas Kumar Nayak <maknayak@in.ibm.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Wed, 2009-05-27 at 15:37 +0530, Manas Kumar Nayak wrote: 
> Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>

Thanks. Merged.

Regards--
Subrata

> To: LTP List <ltp-list@lists.sourceforge.net>
> Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
> Cc: Masatake YAMATO <yamato@redhat.com>
> ---
> 
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utils/common_j_h.c	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utils/common_j_h.c	2009-05-18 21:35:36.000000000 +0530
> @@ -0,0 +1,360 @@
> +/*
> + * Crackerjack Project
> + *
> + * Copyright (C) 2007-2008, Hitachi, Ltd.
> + * Author(s): Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
> + *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + *
> + * $Id:$
> + *
> + */
> +//#define _GNU_SOURCE 1
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/stat.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <pwd.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <mqueue.h>
> +#include "include_j_h.h"
> +
> +
> +/*
> + * Change user ID
> + *
> + *   We assume 'test' executable is executed with 'root' permission.
> + *   So, if you use this function, you can not return 'root' uid.
> + */
> +int setup_uid(char *uname)
> +{
> +	struct passwd *pw;
> +	int rc;
> +
> +	pw = getpwnam(uname);
> +	if (!pw) {
> +		EPRINTF("getpwnam failed.\n");
> +		return -1;
> +	}
> +	rc = setuid(pw->pw_uid);
> +	if (rc < 0) {
> +		EPRINTF("setuid failed.\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Change effective user ID
> + */
> +int setup_euid(char *uname, uid_t *old_uid)
> +{
> +	struct passwd *pw;
> +	int rc;
> +
> +	*old_uid = geteuid();
> +	pw = getpwnam(uname);
> +	if (!pw) {
> +		EPRINTF("getpwnam failed.\n");
> +		return -1;
> +	}
> +	rc = seteuid(pw->pw_uid);
> +	if (rc < 0) {
> +		EPRINTF("seteuid failed.\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +int cleanup_euid(uid_t old_uid)
> +{
> +	int rc;
> +
> +	rc = seteuid(old_uid);
> +	if (rc < 0) {
> +		EPRINTF("seteuid failed.\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +
> +/*
> + * Generate a child process which will send a signal
> + */
> +static void sighandler_for_sig_proc(int sig)
> +{
> +	if (sig == SIGUSR2)
> +		return;
> +	return;
> +}
> +
> +pid_t create_sig_proc(unsigned long usec, int sig)
> +{
> +	pid_t pid, cpid;
> +
> +	signal(SIGUSR2, sighandler_for_sig_proc);
> +	pid = getpid();
> +	cpid = fork();
> +	switch (cpid) {
> +	case 0:
> +		pause();
> +		usleep(usec);
> +		kill(pid, sig);
> +		_exit(0);
> +		break;
> +	case -1:
> +		EPRINTF("fork failed.\n");
> +		return cpid;
> +	default:
> +		kill(cpid, SIGUSR2);
> +		return cpid;
> +	}
> +}
> +
> +
> +/*
> + * Create and delete test file
> + */
> +int setup_file(char *testdir, char *fname, char *path)
> +{
> +	return _setup_file(testdir, fname, path,
> +			   O_CREAT|O_EXCL|O_RDWR, S_IRUSR|S_IWUSR);
> +}
> +
> +int _setup_file(char *testdir, char *fname, char *path, int flags, mode_t mode)
> +{
> +	int rc;
> +
> +	sprintf(path, "%s/%s", testdir, fname);
> +	rc = open(path, flags, mode);
> +	if (rc < 0) {
> +		EPRINTF("open failed.\n");
> +		return -1;
> +	}
> +	return rc;
> +}
> +
> +int cleanup_file(char *path)
> +{
> +	unlink(path);
> +	return 0;
> +}
> +
> +
> +/*
> + * Create and delete swap file
> + */
> +/* swap file needs to be more than 40KB */
> +#define MIN_SWAPFILE_SIZE	(64 * 1024)
> +int setup_swapfile(char *testdir, char *fname, char *path, size_t size)
> +{
> +	int fd = -1, rc;
> +	size_t r_sz;
> +	int cmdlen = 256;
> +	char cmd[cmdlen];
> +	char *p = NULL;
> +
> +	sprintf(path, "%s/%s", testdir, fname);
> +	fd = open(path, O_CREAT|O_EXCL|O_RDWR, S_IRUSR|S_IWUSR);
> +	if (fd < 0) {
> +		EPRINTF("open failed.\n");
> +		goto ERR_EXIT;
> +	}
> +	if (size < MIN_SWAPFILE_SIZE) {
> +		EPRINTF("size too short.\n");
> +		goto ERR_EXIT;
> +	}
> +	p = malloc(size);
> +	if (!p) {
> +		EPRINTF("malloc failed.\n");
> +		goto ERR_EXIT;
> +	}
> +	/* Swap file must not have hole area */
> +	memset(p, 0x5a, size);
> +	r_sz = (size_t)write(fd, p, size);
> +	if (r_sz != size) {
> +		EPRINTF("write failed.\n");
> +		goto ERR_EXIT;
> +	}
> +	snprintf(cmd, cmdlen, "/sbin/mkswap %s > /dev/null 2>&1", path);
> +	rc = system(cmd);
> +	if (rc != 0) {
> +		EPRINTF("system(%s) failed.\n", cmd);
> +		goto ERR_EXIT;
> +	}
> +	return fd;
> +
> +ERR_EXIT:
> +	if (fd >= 0)
> +		close(fd);
> +	if (p)
> +		free(p);
> +	return -1;
> +}
> +
> +int cleanup_swapfile(char *path)
> +{
> +	unlink(path);
> +	return 0;
> +}
> +
> +
> +/*
> + * Change user limit that the calling process can open
> + */
> +int setup_ulimit_fnum(rlim_t newlim, rlim_t *oldlim)
> +{
> +	int rc;
> +	struct rlimit rlim;
> +
> +	rc = getrlimit(RLIMIT_NOFILE, &rlim);
> +	if (rc < 0) {
> +		EPRINTF("getrlimit failed.\n");
> +		return -1;
> +	}
> +	*oldlim = rlim.rlim_cur;
> +	if (newlim > rlim.rlim_max) {
> +		EPRINTF("can't set ulimit value: %ld.\n", newlim);
> +		return -1;
> +	}
> +	rlim.rlim_cur = newlim;
> +	rc = setrlimit(RLIMIT_NOFILE, &rlim);
> +	if (rc < 0) {
> +		EPRINTF("setrlimit failed.\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +int cleanup_ulimit_fnum(rlim_t oldlim)
> +{
> +	int rc;
> +	struct rlimit rlim;
> +
> +	rc = getrlimit(RLIMIT_NOFILE, &rlim);
> +	if (rc < 0) {
> +		EPRINTF("getrlimit failed.\n");
> +		return -1;
> +	}
> +	if (oldlim > rlim.rlim_max) {
> +		EPRINTF("can't set ulimit value: %ld.\n", oldlim);
> +		return -1;
> +	}
> +	rlim.rlim_cur = oldlim;
> +	rc = setrlimit(RLIMIT_NOFILE, &rlim);
> +	if (rc < 0) {
> +		EPRINTF("setrlimit failed.\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +
> +/*
> + * Change /proc or /sys setting
> + */
> +int setup_proc_fs(char *path, int newval, int *oldval)
> +{
> +	int fd = -1, rc, len;
> +	char buf[32];
> +
> +	fd = open(path, O_RDWR);
> +	if (fd < 0) {
> +		EPRINTF("open %s failed.\n", path);
> +		return -1;
> +	}
> +
> +	do {
> +		rc = read(fd, buf, 32);
> +	} while (rc < 0 && errno == EAGAIN);
> +	if (rc < 0) {
> +		EPRINTF("read failed.\n");
> +		return -1;
> +	}
> +
> +	*oldval = atoi(buf);
> +	sprintf(buf, "%d\n", newval);
> +	len = strlen(buf);
> +	rc = write(fd, buf, len);
> +	if (rc != len) {
> +		EPRINTF("write failed.\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +int cleanup_proc_fs(char *path, int oldval)
> +{
> +	int fd = -1, rc, len;
> +	char buf[32];
> +
> +	fd = open(path, O_RDWR);
> +	if (fd < 0) {
> +		EPRINTF("open %s failed.\n", path);
> +		return -1;
> +	}
> +
> +	sprintf(buf, "%d\n", oldval);
> +	len = strlen(buf);
> +	rc = write(fd, buf, len);
> +	if (rc != len) {
> +		EPRINTF("write failed.\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +
> +#if 0
> +/*
> + * Check max nodes from /sys/devices/system/node/node* files (for NUMA)
> + */
> +int get_max_nodes(void)
> +{
> +	/* We assume that there is only one node */
> +	return 1;
> +}
> +#endif
> +
> +/*
> + * Get unexist pid
> + */
> +pid_t get_unexist_pid(void)
> +{
> +	pid_t pid;
> +	int st;
> +
> +	pid = fork();
> +	switch (pid) {
> +	case -1:
> +		EPRINTF("fork failed.\n");
> +		return -1;
> +	case 0:
> +		_exit(0);
> +	default:
> +		wait(&st);
> +		return pid;
> +	}
> +}
> +
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utils/include_j_h.h	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utils/include_j_h.h	2009-05-18 21:35:36.000000000 +0530
> @@ -0,0 +1,160 @@
> +/*
> + * Crackerjack Project
> + *
> + * Copyright (C) 2007-2008, Hitachi, Ltd.
> + * Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
> + *            Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
> + *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + *
> + * $Id:$
> + *
> + */
> +#ifndef __CJK_SYSCALL_J_H__
> +#define __CJK_SYSCALL_J_H__
> +
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +
> +
> +#define REG_RESULT_LOG_FP	stdout
> +#define REG_DETAIL_LOG_FP	stderr
> +
> +
> +/*
> + * RPRINTF : macro to output test result
> + */
> +#define RPRINTF(...)						\
> +	do {							\
> +		fprintf(REG_RESULT_LOG_FP, __VA_ARGS__);	\
> +	} while (0)
> +
> +
> +/*
> + * PRINTF : macro to output detail log
> + */
> +#define PRINTF(...)						\
> +	do {							\
> +		fprintf(REG_DETAIL_LOG_FP, __VA_ARGS__);	\
> +	} while (0)
> +
> +
> +/*
> + * EPRINTF : macro to output error message
> + */
> +#define EPRINTF(...)						\
> +	do {							\
> +		fprintf(REG_DETAIL_LOG_FP, __VA_ARGS__);	\
> +	} while (0)
> +
> +
> +/*
> + * DPRINTF : macro to output debug message
> + */
> +#define DPRINTF(...)						\
> +	do {							\
> +		if (opt_debug)					\
> +			PRINTF("[DEBUG] " __VA_ARGS__);		\
> +	} while (0)
> +
> +
> +/*
> + * PRINT_XXX : macro to output test result and expect
> + */
> +#define __PRINT_EXPECT(rc_has_range, rc, errno)				\
> +	do {								\
> +		if (rc_has_range)					\
> +			PRINTF("EXPECT: return value(ret)=%s",		\
> +			       (rc) >= 0 ? "(N >= 0)" : "(N <  0)");	\
> +		else							\
> +			PRINTF("EXPECT: return value(ret)=%d", rc);	\
> +		PRINTF(" errno=%d (%s)", errno, strerror(errno));	\
> +	} while (0)
> +
> +#define __PRINT_RESULT(rc_has_range, rc, errno)				\
> +	do {								\
> +		if (rc_has_range)					\
> +			PRINTF("RESULT: return value(ret)=%8d", rc);	\
> +		else							\
> +			PRINTF("RESULT: return value(ret)=%d", rc);	\
> +		PRINTF(" errno=%d (%s)", errno, strerror(errno));	\
> +	} while (0)
> +
> +#define PRINT_RESULT(rc_has_range, e_rc, e_errno, r_rc, r_errno)	\
> +	do {								\
> +		__PRINT_EXPECT(rc_has_range, e_rc, e_errno);		\
> +		PRINTF("\n");						\
> +		__PRINT_RESULT(rc_has_range, r_rc, r_errno);		\
> +		PRINTF("\n");						\
> +	} while (0)
> +
> +#define PRINT_RESULT_EXTRA(rc_has_range, e_rc, e_errno, r_rc, r_errno,	\
> +			   str, extra_ok)				\
> +	do {								\
> +		__PRINT_EXPECT(rc_has_range, e_rc, e_errno);		\
> +		if ((extra_ok))						\
> +			PRINTF("\n");					\
> +		else							\
> +			PRINTF(", %s=OK\n", str);			\
> +		__PRINT_RESULT(rc_has_range, r_rc, r_errno);		\
> +		if ((extra_ok))						\
> +			PRINTF("\n");					\
> +		else							\
> +			PRINTF(", %s=NG\n", str);			\
> +	} while (0)
> +
> +#define PRINT_RESULT_CMP(rc_has_range, e_rc, e_errno, r_rc, r_errno, cmp_ok) \
> +	PRINT_RESULT_EXTRA(rc_has_range, e_rc, e_errno, r_rc, r_errno,	\
> +			   "r/w check", cmp_ok)
> +
> +
> +/*
> + * Definitions
> + */
> +enum result_val {
> +	RESULT_OK,
> +	RESULT_NG
> +};
> +
> +
> +/*
> + * Prototype
> + */
> +int setup_uid(char *uname);
> +int setup_euid(char *uname, uid_t *old_uid);
> +int cleanup_euid(uid_t old_uid);
> +
> +pid_t create_sig_proc(unsigned long usec, int sig);
> +
> +int _setup_file(char *testdir, char *fname, char *path, int flags, mode_t mode);
> +int setup_file(char *testdir, char *fname, char *path);
> +int cleanup_file(char *path);
> +
> +int setup_swapfile(char *testdir, char *fname, char *path, size_t size);
> +int cleanup_swapfile(char *path);
> +
> +int setup_ulimit_fnum(rlim_t newlim, rlim_t *oldlim);
> +int cleanup_ulimit_fnum(rlim_t oldlim);
> +
> +int setup_proc_fs(char *path, int newval, int *oldval);
> +int cleanup_proc_fs(char *path, int oldval);
> +
> +#define QUEUE_NAME	"/test_mqueue"
> +pid_t create_echo_msg_proc(void);
> +
> +pid_t get_unexist_pid(void);
> +
> +#endif /* __CJK_SYSCALL_J_H__ */
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utils/inotify.h	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utils/inotify.h	2009-05-18 21:35:36.000000000 +0530
> @@ -0,0 +1,227 @@
> +/*
> + * Inode based directory notification for Linux
> + *
> + * Copyright (C) 2005 John McCutchan
> + */
> +
> +#ifndef _LINUX_INOTIFY_H
> +#define _LINUX_INOTIFY_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * struct inotify_event - structure read from the inotify device for each event
> + *
> + * When you are watching a directory, you will receive the filename for events
> + * such as IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, ..., relative to the wd.
> + */
> +struct inotify_event {
> +	__s32		wd;		/* watch descriptor */
> +	__u32		mask;		/* watch mask */
> +	__u32		cookie;		/* cookie to synchronize two events */
> +	__u32		len;		/* length (including nulls) of name */
> +	char		name[0];	/* stub for possible name */
> +};
> +
> +/* the following are legal, implemented events that user-space can watch for */
> +#define IN_ACCESS		0x00000001	/* File was accessed */
> +#define IN_MODIFY		0x00000002	/* File was modified */
> +#define IN_ATTRIB		0x00000004	/* Metadata changed */
> +#define IN_CLOSE_WRITE		0x00000008	/* Writtable file was closed */
> +#define IN_CLOSE_NOWRITE	0x00000010	/* Unwrittable file closed */
> +#define IN_OPEN			0x00000020	/* File was opened */
> +#define IN_MOVED_FROM		0x00000040	/* File was moved from X */
> +#define IN_MOVED_TO		0x00000080	/* File was moved to Y */
> +#define IN_CREATE		0x00000100	/* Subfile was created */
> +#define IN_DELETE		0x00000200	/* Subfile was deleted */
> +#define IN_DELETE_SELF		0x00000400	/* Self was deleted */
> +#define IN_MOVE_SELF		0x00000800	/* Self was moved */
> +
> +/* the following are legal events.  they are sent as needed to any watch */
> +#define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
> +#define IN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
> +#define IN_IGNORED		0x00008000	/* File was ignored */
> +
> +/* helper events */
> +#define IN_CLOSE		(IN_CLOSE_WRITE | IN_CLOSE_NOWRITE) /* close */
> +#define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) /* moves */
> +
> +/* special flags */
> +#define IN_ONLYDIR		0x01000000	/* only watch the path if it is a directory */
> +#define IN_DONT_FOLLOW		0x02000000	/* don't follow a sym link */
> +#define IN_MASK_ADD		0x20000000	/* add to the mask of an already existing watch */
> +#define IN_ISDIR		0x40000000	/* event occurred against dir */
> +#define IN_ONESHOT		0x80000000	/* only send event once */
> +
> +/*
> + * All of the events - we build the list by hand so that we can add flags in
> + * the future and not break backward compatibility.  Apps will get only the
> + * events that they originally wanted.  Be sure to add new events here!
> + */
> +#define IN_ALL_EVENTS	(IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
> +			 IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
> +			 IN_MOVED_TO | IN_DELETE | IN_CREATE | IN_DELETE_SELF | \
> +			 IN_MOVE_SELF)
> +
> +#ifdef __KERNEL__
> +
> +#include <linux/dcache.h>
> +#include <linux/fs.h>
> +
> +/*
> + * struct inotify_watch - represents a watch request on a specific inode
> + *
> + * h_list is protected by ih->mutex of the associated inotify_handle.
> + * i_list, mask are protected by inode->inotify_mutex of the associated inode.
> + * ih, inode, and wd are never written to once the watch is created.
> + *
> + * Callers must use the established inotify interfaces to access inotify_watch
> + * contents.  The content of this structure is private to the inotify
> + * implementation.
> + */
> +struct inotify_watch {
> +	struct list_head	h_list;	/* entry in inotify_handle's list */
> +	struct list_head	i_list;	/* entry in inode's list */
> +	atomic_t		count;	/* reference count */
> +	struct inotify_handle	*ih;	/* associated inotify handle */
> +	struct inode		*inode;	/* associated inode */
> +	__s32			wd;	/* watch descriptor */
> +	__u32			mask;	/* event mask for this watch */
> +};
> +
> +struct inotify_operations {
> +	void (*handle_event)(struct inotify_watch *, u32, u32, u32,
> +			     const char *, struct inode *);
> +	void (*destroy_watch)(struct inotify_watch *);
> +};
> +
> +#ifdef CONFIG_INOTIFY
> +
> +/* Kernel API for producing events */
> +
> +extern void inotify_d_instantiate(struct dentry *, struct inode *);
> +extern void inotify_d_move(struct dentry *);
> +extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
> +				      const char *, struct inode *);
> +extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
> +					      const char *);
> +extern void inotify_unmount_inodes(struct list_head *);
> +extern void inotify_inode_is_dead(struct inode *);
> +extern u32 inotify_get_cookie(void);
> +
> +/* Kernel Consumer API */
> +
> +extern struct inotify_handle *inotify_init(const struct inotify_operations *);
> +extern void inotify_init_watch(struct inotify_watch *);
> +extern void inotify_destroy(struct inotify_handle *);
> +extern __s32 inotify_find_watch(struct inotify_handle *, struct inode *,
> +				struct inotify_watch **);
> +extern __s32 inotify_find_update_watch(struct inotify_handle *, struct inode *,
> +				       u32);
> +extern __s32 inotify_add_watch(struct inotify_handle *, struct inotify_watch *,
> +			       struct inode *, __u32);
> +extern int inotify_rm_watch(struct inotify_handle *, struct inotify_watch *);
> +extern int inotify_rm_wd(struct inotify_handle *, __u32);
> +extern void inotify_remove_watch_locked(struct inotify_handle *,
> +					struct inotify_watch *);
> +extern void get_inotify_watch(struct inotify_watch *);
> +extern void put_inotify_watch(struct inotify_watch *);
> +
> +#else
> +
> +static inline void inotify_d_instantiate(struct dentry *dentry,
> +					struct inode *inode)
> +{
> +}
> +
> +static inline void inotify_d_move(struct dentry *dentry)
> +{
> +}
> +
> +static inline void inotify_inode_queue_event(struct inode *inode,
> +					     __u32 mask, __u32 cookie,
> +					     const char *filename,
> +					     struct inode *n_inode)
> +{
> +}
> +
> +static inline void inotify_dentry_parent_queue_event(struct dentry *dentry,
> +						     __u32 mask, __u32 cookie,
> +						     const char *filename)
> +{
> +}
> +
> +static inline void inotify_unmount_inodes(struct list_head *list)
> +{
> +}
> +
> +static inline void inotify_inode_is_dead(struct inode *inode)
> +{
> +}
> +
> +static inline u32 inotify_get_cookie(void)
> +{
> +	return 0;
> +}
> +
> +static inline struct inotify_handle *inotify_init(const struct inotify_operations *ops)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void inotify_init_watch(struct inotify_watch *watch)
> +{
> +}
> +
> +static inline void inotify_destroy(struct inotify_handle *ih)
> +{
> +}
> +
> +static inline __s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
> +				       struct inotify_watch **watchp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline __s32 inotify_find_update_watch(struct inotify_handle *ih,
> +					      struct inode *inode, u32 mask)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline __s32 inotify_add_watch(struct inotify_handle *ih,
> +				      struct inotify_watch *watch,
> +				      struct inode *inode, __u32 mask)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int inotify_rm_watch(struct inotify_handle *ih,
> +				   struct inotify_watch *watch)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int inotify_rm_wd(struct inotify_handle *ih, __u32 wd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void inotify_remove_watch_locked(struct inotify_handle *ih,
> +					       struct inotify_watch *watch)
> +{
> +}
> +
> +static inline void get_inotify_watch(struct inotify_watch *watch)
> +{
> +}
> +
> +static inline void put_inotify_watch(struct inotify_watch *watch)
> +{
> +}
> +
> +#endif	/* CONFIG_INOTIFY */
> +
> +#endif	/* __KERNEL __ */
> +
> +#endif	/* _LINUX_INOTIFY_H */
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utils/ioprio.h	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utils/ioprio.h	2009-05-18 21:35:36.000000000 +0530
> @@ -0,0 +1,46 @@
> +#ifndef __IOPRIO_H__
> +#define	__IOPRIO_H__
> +
> +//----------------------------------------------------------------------------
> +// Copy of the 2.6.18 kernel header (linux/ioprio.h)
> +//
> +
> +/*
> + * Gives us 8 prio classes with 13-bits of data for each class
> + */
> +#define IOPRIO_BITS		(16)
> +#define IOPRIO_CLASS_SHIFT	(13)
> +#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
> +
> +#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
> +#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
> +#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
> +
> +#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
> +
> +/*
> + * These are the io priority groups as implemented by CFQ. RT is the realtime
> + * class, it always gets premium service. BE is the best-effort scheduling
> + * class, the default for any process. IDLE is the idle scheduling class, it
> + * is only served when no one else is using the disk.
> + */
> +enum {
> +	IOPRIO_CLASS_NONE,
> +	IOPRIO_CLASS_RT,
> +	IOPRIO_CLASS_BE,
> +	IOPRIO_CLASS_IDLE,
> +};
> +
> +/*
> + * 8 best effort priority levels are supported
> + */
> +#define IOPRIO_BE_NR	(8)
> +
> +enum {
> +	IOPRIO_WHO_PROCESS = 1,
> +	IOPRIO_WHO_PGRP,
> +	IOPRIO_WHO_USER,
> +};
> +//-----------------------------------------------------------------------------
> +
> +#endif /* __IOPRIO_H__ */
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utils/numaif.h	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utils/numaif.h	2009-05-18 21:35:36.000000000 +0530
> @@ -0,0 +1,115 @@
> +/*
> + * Crackerjack Project
> + *
> + * Copyright (C) 2007-2008, Hitachi, Ltd.
> + * Author(s): Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
> + *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
> + *
> + *            Derived from 'numa.h' in numactl-0.9.8
> + *            Copyright (C) 2003,2004 Andi Kleen, SuSE Labs.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + *
> + * $Id:$
> + *
> + */
> +
> +#include "./include_j_h.h"
> +
> +#ifndef __NR_mbind
> +#  define __NR_mbind			274
> +#endif
> +#ifndef __NR_get_mempolicy
> +#  define __NR_get_mempolicy		275
> +#endif
> +#ifndef __NR_set_mempolicy
> +#  define __NR_set_mempolicy		276
> +#endif
> +#ifndef __NR_migrate_pages
> +#  define __NR_migrate_pages		294
> +#endif
> +#ifndef __NR_move_pages
> +#  define __NR_move_pages		317
> +#endif
> +
> +
> +
> +
> +#define NUMA_NUM_NODES 	128
> +typedef struct { 
> +	unsigned long n[NUMA_NUM_NODES/(sizeof(unsigned long)*8)];
> +} nodemask_t;
> +
> +static inline void nodemask_zero(nodemask_t *mask)
> +{ 
> +	memset(mask->n, 0, sizeof(mask->n)); 
> +} 
> +
> +static inline void nodemask_set(nodemask_t *mask, int node)
> +{
> +	mask->n[node / (8*sizeof(unsigned long))] |=
> +		(1UL << (node % (8*sizeof(unsigned long))));		
> +} 
> +
> +static inline void nodemask_clr(nodemask_t *mask, int node)
> +{
> +	mask->n[node / (8*sizeof(unsigned long))] &= 
> +		~(1UL << (node % (8*sizeof(unsigned long))));	
> +}
> +
> +static inline int nodemask_isset(const nodemask_t *mask, int node)
> +{
> +	if ((unsigned)node >= NUMA_NUM_NODES)
> +		return 0;
> +	if (mask->n[node / (8*sizeof(unsigned long))] & 
> +		(1UL << (node % (8*sizeof(unsigned long)))))
> +		return 1;
> +	return 0;	
> +}
> +
> +static inline int nodemask_equal(const nodemask_t *a, const nodemask_t *b) 
> +{ 
> +	int i;
> +	for (i = 0; i < NUMA_NUM_NODES/(sizeof(unsigned long)*8); i++) 
> +		if (a->n[i] != b->n[i]) 
> +			return 0; 
> +	return 1;
> +} 
> +
> +static inline void nodemask_dump(const char *header, const nodemask_t *mask)
> +{
> +	int i;
> +	EPRINTF("%s", header);
> +	for (i = 0; i < NUMA_NUM_NODES/(sizeof(unsigned long)*8); i++) 
> +		EPRINTF(" 0x%08lx", mask->n[i]);
> +	EPRINTF("\n");
> +}
> +
> +
> +#ifndef MPOL_DEFAULT
> +   // Policies
> +#  define MPOL_DEFAULT			0
> +#  define MPOL_PREFERRED		1
> +#  define MPOL_BIND			2
> +#  define MPOL_INTERLEAVE		3
> +   // Flags for get_mem_policy
> +#  define MPOL_F_NODE			(1<<0)
> +#  define MPOL_F_ADDR			(1<<1)
> +   // Flags for mbind
> +#  define MPOL_MF_STRICT		(1<<0)
> +#  define MPOL_MF_MOVE			(1<<1)
> +#  define MPOL_MF_MOVE_ALL		(1<<2)
> +#endif
> +
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utils/poll.h	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utils/poll.h	2009-05-18 21:35:36.000000000 +0530
> @@ -0,0 +1,27 @@
> +#ifndef __i386_POLL_H
> +#define __i386_POLL_H
> +
> +/* These are specified by iBCS2 */
> +#define POLLIN		0x0001
> +#define POLLPRI		0x0002
> +#define POLLOUT		0x0004
> +#define POLLERR		0x0008
> +#define POLLHUP		0x0010
> +#define POLLNVAL	0x0020
> +
> +/* The rest seem to be more-or-less nonstandard. Check them! */
> +#define POLLRDNORM	0x0040
> +#define POLLRDBAND	0x0080
> +#define POLLWRNORM	0x0100
> +#define POLLWRBAND	0x0200
> +#define POLLMSG		0x0400
> +#define POLLREMOVE	0x1000
> +#define POLLRDHUP       0x2000
> +
> +struct pollfd {
> +	int fd;
> +	short events;
> +	short revents;
> +};
> +
> +#endif
> 
> ---
> Regards--
> Manas
> 


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
