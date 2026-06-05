Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374A1CD6E7C
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:18:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C05E43E7181
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:18:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8B13E547A
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:17:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B360600BD8
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:17:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DBE06AF06;
 Fri,  5 Jun 2026 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780651035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJ8UROcoSZdyC1OMfFUOVMykchwx5HXveX/UIaCekNw=;
 b=F6v+72+4K2jUTDJlJtWbaNI0/i07LJyCv/BZthngAHrDZivoP0Avq8TRdYho/jfA3VUrBf
 BNsww8NbawHWHv3Qgb7su82FmCmzIRHlhanHxa4hgDQ/ZGHVYtk2abJM1nnd23MqdP3bxz
 ODGl7HaBGRVhzYbskkw8NoKAHE2vNMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780651035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJ8UROcoSZdyC1OMfFUOVMykchwx5HXveX/UIaCekNw=;
 b=mw1PxMx+RFHEiMxVGm94Qudf6xrZs4JHpFatiaEf02NmuScW68PNA/DEyxgCc69nSG3RRW
 6M0ERMqH7lHb2pBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780651035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJ8UROcoSZdyC1OMfFUOVMykchwx5HXveX/UIaCekNw=;
 b=F6v+72+4K2jUTDJlJtWbaNI0/i07LJyCv/BZthngAHrDZivoP0Avq8TRdYho/jfA3VUrBf
 BNsww8NbawHWHv3Qgb7su82FmCmzIRHlhanHxa4hgDQ/ZGHVYtk2abJM1nnd23MqdP3bxz
 ODGl7HaBGRVhzYbskkw8NoKAHE2vNMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780651035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJ8UROcoSZdyC1OMfFUOVMykchwx5HXveX/UIaCekNw=;
 b=mw1PxMx+RFHEiMxVGm94Qudf6xrZs4JHpFatiaEf02NmuScW68PNA/DEyxgCc69nSG3RRW
 6M0ERMqH7lHb2pBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54257779A9;
 Fri,  5 Jun 2026 09:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eByMERuUImodHAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 05 Jun 2026 09:17:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 05 Jun 2026 11:17:15 +0200
MIME-Version: 1.0
Message-Id: <20260605-doc_add_missing_headers-v6-3-678aac302a60@suse.com>
References: <20260605-doc_add_missing_headers-v6-0-678aac302a60@suse.com>
In-Reply-To: <20260605-doc_add_missing_headers-v6-0-678aac302a60@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780651034; l=14078;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=h6J7kHIx/zZu1Shdll30pARS237QJ5A4mFSnvebKAWs=;
 b=pxWYJMrHWz0ErxFLpbMgsrfR/IH+BZTH5G7trLSiiMCG9xWBE646hJUb6mQNO8GkMAGoRxdkO
 IcIZ05iZQfDA+aunOvkgtDIV+mOB+yLWKPdI5v1kv0DtO8A7mpA2lq7
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/3] doc: Add SAFE_* macros reference page
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add doc/developers/api_safe_macros.rst listing all 245 SAFE_* wrapper
macros grouped by header and category (file ops, memory, process,
signals, networking, pthreads, IPC, cgroups, clocks, etc.).

This gives test writers a single reference page to discover available
safe macros without grepping headers.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/api_safe_macros.rst | 382 +++++++++++++++++++++++++++++++++++++
 doc/index.rst                      |   4 +
 2 files changed, 386 insertions(+)

diff --git a/doc/developers/api_safe_macros.rst b/doc/developers/api_safe_macros.rst
new file mode 100644
index 0000000000000000000000000000000000000000..e992615424aa19fb6f9d9f643e9a5e25c02758c3
--- /dev/null
+++ b/doc/developers/api_safe_macros.rst
@@ -0,0 +1,382 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (c) Linux Test Project, 2026
+
+Safe macros reference
+=====================
+
+LTP provides ``SAFE_*`` wrappers for common system calls and library
+functions. Each wrapper calls the underlying function and, on failure,
+invokes ``tst_brk(TBROK | TERRNO, ...)`` to abort the test. This
+eliminates repetitive error-checking boilerplate.
+
+**When NOT to use SAFE_\* macros:** when the syscall is the *subject*
+of the test (e.g. testing ``close()`` error paths). Use ``TEST()`` or
+``TST_EXP_*`` macros instead.
+
+Core macros (tst_safe_macros.h)
+-------------------------------
+
+File and directory operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- ``SAFE_ACCESS(path, mode)``
+- ``SAFE_CHMOD(path, mode)``
+- ``SAFE_CHOWN(path, owner, group)``
+- ``SAFE_CHDIR(path)``
+- ``SAFE_CHROOT(path)``
+- ``SAFE_CREAT(path, mode)``
+- ``SAFE_FCHMOD(fd, mode)``
+- ``SAFE_FCHOWN(fd, owner, group)``
+- ``SAFE_GETCWD(buf, size)``
+- ``SAFE_LCHOWN(path, owner, group)``
+- ``SAFE_LINK(oldpath, newpath)``
+- ``SAFE_LINKAT(olddirfd, oldpath, newdirfd, newpath, flags)``
+- ``SAFE_MKDIR(path, mode)``
+- ``SAFE_MKFIFO(path, mode)``
+- ``SAFE_MKNOD(path, mode, dev)``
+- ``SAFE_READLINK(path, buf, bufsiz)``
+- ``SAFE_RENAME(oldpath, newpath)``
+- ``SAFE_RMDIR(path)``
+- ``SAFE_SYMLINK(target, linkpath)``
+- ``SAFE_SYMLINKAT(target, newdirfd, linkpath)``
+- ``SAFE_UNLINK(path)``
+
+File descriptor operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- ``SAFE_CLOSE(fd)`` -- also sets ``fd = -1``
+- ``SAFE_DUP(oldfd)``
+- ``SAFE_DUP2(oldfd, newfd)``
+- ``SAFE_FCNTL(fd, cmd, ...)``
+- ``SAFE_FSYNC(fd)``
+- ``SAFE_OPEN(path, oflag, ...)``
+- ``SAFE_OPENDIR(name)``
+- ``SAFE_CLOSEDIR(dirp)``
+- ``SAFE_READDIR(dirp)``
+- ``SAFE_PIPE(pipefd)``
+- ``SAFE_PIPE2(pipefd, flags)``
+- ``SAFE_PTSNAME(fd)``
+
+Reading and writing
+~~~~~~~~~~~~~~~~~~~
+
+- ``SAFE_READ(len_strict, fd, buf, count)``
+- ``SAFE_READV(fd, iov, iovcnt)``
+- ``SAFE_WRITE(len_strict, fd, buf, count)``
+- ``SAFE_WRITEV(fd, iov, iovcnt)``
+
+Memory management
+~~~~~~~~~~~~~~~~~
+
+- ``SAFE_CALLOC(nmemb, size)``
+- ``SAFE_MALLOC(size)``
+- ``SAFE_MEMALIGN(alignment, size)``
+- ``SAFE_REALLOC(ptr, size)``
+- ``SAFE_MUNMAP(addr, length)``
+- ``SAFE_MLOCK(addr, len)``
+- ``SAFE_MUNLOCK(addr, len)``
+- ``SAFE_MPROTECT(addr, len, prot)``
+- ``SAFE_MSYNC(addr, length, flags)``
+- ``SAFE_MINCORE(addr, length, vec)``
+
+Process management
+~~~~~~~~~~~~~~~~~~
+
+- ``SAFE_EXECL(path, arg, ...)``
+- ``SAFE_EXECLP(file, arg, ...)``
+- ``SAFE_EXECVP(file, argv)``
+- ``SAFE_KILL(pid, sig)``
+- ``SAFE_WAIT(status)``
+- ``SAFE_WAITPID(pid, status, opts)``
+- ``SAFE_GETPGID(pid)``
+- ``SAFE_SETPGID(pid, pgid)``
+- ``SAFE_SETSID()``
+- ``SAFE_PRCTL(option, ...)``
+- ``SAFE_PTRACE(request, pid, addr, data)``
+- ``SAFE_PIDFD_OPEN(pid, flags)``
+
+User and group
+~~~~~~~~~~~~~~
+
+- ``SAFE_GETPWNAM(name)``
+- ``SAFE_GETGRNAM(name)``
+- ``SAFE_GETGRNAM_FALLBACK(name)``
+- ``SAFE_GETGRGID(gid)``
+- ``SAFE_GETGROUPS(size, list)``
+- ``SAFE_SETGROUPS(size, list)``
+- ``SAFE_SETUID(uid)``
+- ``SAFE_SETEUID(euid)``
+- ``SAFE_SETREUID(ruid, euid)``
+- ``SAFE_SETRESUID(ruid, euid, suid)``
+- ``SAFE_GETRESUID(ruid, euid, suid)``
+- ``SAFE_SETGID(gid)``
+- ``SAFE_SETEGID(egid)``
+- ``SAFE_SETREGID(rgid, egid)``
+- ``SAFE_SETRESGID(rgid, egid, sgid)``
+- ``SAFE_GETRESGID(rgid, egid, sgid)``
+
+Signals
+~~~~~~~
+
+- ``SAFE_SIGACTION(signum, act, oldact)``
+- ``SAFE_SIGADDSET(set, signum)``
+- ``SAFE_SIGDELSET(set, signum)``
+- ``SAFE_SIGEMPTYSET(set)``
+- ``SAFE_SIGFILLSET(set)``
+- ``SAFE_SIGNAL(signum, handler)``
+- ``SAFE_SIGPROCMASK(how, set, oldset)``
+- ``SAFE_SIGWAIT(set, sig)``
+
+Extended attributes
+~~~~~~~~~~~~~~~~~~~
+
+- ``SAFE_GETXATTR(path, name, value, size)``
+- ``SAFE_SETXATTR(path, name, value, size, flags)``
+- ``SAFE_REMOVEXATTR(path, name)``
+- ``SAFE_LSETXATTR(path, name, value, size, flags)``
+- ``SAFE_LREMOVEXATTR(path, name)``
+- ``SAFE_FSETXATTR(fd, name, value, size, flags)``
+- ``SAFE_FREMOVEXATTR(fd, name)``
+
+Mounting
+~~~~~~~~
+
+- ``SAFE_MOUNT(source, target, filesystemtype, mountflags, data)``
+- ``SAFE_MOUNT2(source, target, filesystemtype, mountflags, data)``
+- ``SAFE_UMOUNT(target)``
+
+Miscellaneous
+~~~~~~~~~~~~~
+
+- ``SAFE_BASENAME(path)``
+- ``SAFE_CMD(argv, stdout_path, stderr_path)``
+- ``SAFE_DIRNAME(path)``
+- ``SAFE_GETPRIORITY(which, who)``
+- ``SAFE_GETRUSAGE(who, usage)``
+- ``SAFE_IOCTL(fd, request, ...)``
+- ``SAFE_PERSONALITY(persona)``
+- ``SAFE_SETENV(name, value, overwrite)``
+- ``SAFE_SETNS(fd, nstype)``
+- ``SAFE_SSCANF(str, format, ...)``
+- ``SAFE_STATVFS(path, buf)``
+- ``SAFE_SYSCONF(name)``
+- ``SAFE_SYSINFO(info)``
+- ``SAFE_UNSHARE(flags)``
+
+String conversion
+~~~~~~~~~~~~~~~~~
+
+- ``SAFE_STRTOL(str, min, max)``
+- ``SAFE_STRTOUL(str, min, max)``
+- ``SAFE_STRTOF(str, min, max)``
+
+Inline macros (tst_safe_macros_inline.h)
+----------------------------------------
+
+- ``SAFE_FSTAT(fd, statbuf)``
+- ``SAFE_FTRUNCATE(fd, length)``
+- ``SAFE_GETRLIMIT(resource, rlim)``
+- ``SAFE_LSEEK(fd, offset, whence)``
+- ``SAFE_LSTAT(path, statbuf)``
+- ``SAFE_MMAP(addr, length, prot, flags, fd, offset)``
+- ``SAFE_POSIX_FADVISE(fd, offset, len, advice)``
+- ``SAFE_SETRLIMIT(resource, rlim)``
+- ``SAFE_STAT(path, statbuf)``
+- ``SAFE_STATFS(path, buf)``
+- ``SAFE_TRUNCATE(path, length)``
+
+File content operations (tst_safe_file_ops.h)
+----------------------------------------------
+
+- ``SAFE_FILE_SCANF(path, fmt, ...)``
+- ``SAFE_FILE_LINES_SCANF(path, fmt, ...)``
+- ``SAFE_FILE_PRINTF(path, fmt, ...)``
+- ``SAFE_TRY_FILE_PRINTF(path, fmt, ...)``
+- ``SAFE_FILE_READ_STR(path, buf)``
+- ``SAFE_READ_MEMINFO(item)``
+- ``SAFE_READ_PROC_STATUS(pid, item)``
+- ``SAFE_CP(src, dst)``
+- ``SAFE_TOUCH(path, mode, times)``
+- ``SAFE_MOUNT_OVERLAY()``
+
+File-at operations (tst_safe_file_at.h)
+----------------------------------------
+
+- ``SAFE_OPENAT(dirfd, path, oflag, ...)``
+- ``SAFE_FILE_READAT(dirfd, path, buf, bufsiz)``
+- ``SAFE_FILE_PRINTFAT(dirfd, path, fmt, ...)``
+- ``SAFE_UNLINKAT(dirfd, path, flags)``
+- ``SAFE_FCHOWNAT(dirfd, path, owner, group, flags)``
+- ``SAFE_FSTATAT(dirfd, path, statbuf, flags)``
+
+Positioned I/O (tst_safe_prw.h)
+---------------------------------
+
+- ``SAFE_PREAD(len_strict, fd, buf, count, offset)``
+- ``SAFE_PREADV(fd, iov, iovcnt, offset)``
+- ``SAFE_PWRITE(len_strict, fd, buf, count, offset)``
+- ``SAFE_PWRITEV(fd, iov, iovcnt, offset)``
+
+Networking (tst_safe_net.h)
+----------------------------
+
+- ``SAFE_SOCKET(domain, type, protocol)``
+- ``SAFE_SOCKETPAIR(domain, type, protocol, sv)``
+- ``SAFE_BIND(sockfd, addr, addrlen)``
+- ``SAFE_CONNECT(sockfd, addr, addrlen)``
+- ``SAFE_LISTEN(sockfd, backlog)``
+- ``SAFE_ACCEPT(sockfd, addr, addrlen)``
+- ``SAFE_SEND(sockfd, buf, len, flags)``
+- ``SAFE_SENDTO(sockfd, buf, len, flags, dest_addr, addrlen)``
+- ``SAFE_SENDMSG(sockfd, msg, flags)``
+- ``SAFE_RECV(sockfd, buf, len, flags)``
+- ``SAFE_RECVMSG(sockfd, msg, flags)``
+- ``SAFE_GETSOCKNAME(sockfd, addr, addrlen)``
+- ``SAFE_GETSOCKOPT(sockfd, level, optname, optval, optlen)``
+- ``SAFE_SETSOCKOPT(sockfd, level, optname, optval, optlen)``
+- ``SAFE_SETSOCKOPT_INT(sockfd, level, optname, value)``
+- ``SAFE_GETHOSTNAME(name, len)``
+- ``SAFE_SETHOSTNAME(name, len)``
+- ``SAFE_GETADDRINFO(node, service, hints, res)``
+
+Pthreads (tst_safe_pthread.h)
+------------------------------
+
+- ``SAFE_PTHREAD_CREATE(thread, attr, start_routine, arg)``
+- ``SAFE_PTHREAD_JOIN(thread, retval)``
+- ``SAFE_PTHREAD_CANCEL(thread)``
+- ``SAFE_PTHREAD_KILL(thread, sig)``
+- ``SAFE_PTHREAD_BARRIER_INIT(barrier, attr, count)``
+- ``SAFE_PTHREAD_BARRIER_WAIT(barrier)``
+- ``SAFE_PTHREAD_BARRIER_DESTROY(barrier)``
+- ``SAFE_PTHREAD_MUTEX_INIT(mutex, attr)``
+- ``SAFE_PTHREAD_MUTEX_LOCK(mutex)``
+- ``SAFE_PTHREAD_MUTEX_TRYLOCK(mutex)``
+- ``SAFE_PTHREAD_MUTEX_TIMEDLOCK(mutex, abstime)``
+- ``SAFE_PTHREAD_MUTEX_UNLOCK(mutex)``
+- ``SAFE_PTHREAD_MUTEX_DESTROY(mutex)``
+- ``SAFE_PTHREAD_MUTEXATTR_INIT(attr)``
+- ``SAFE_PTHREAD_MUTEXATTR_SETTYPE(attr, type)``
+- ``SAFE_PTHREAD_MUTEXATTR_DESTROY(attr)``
+
+Standard I/O (tst_safe_stdio.h)
+--------------------------------
+
+- ``SAFE_FOPEN(path, mode)``
+- ``SAFE_FREOPEN(path, mode, stream)``
+- ``SAFE_FCLOSE(stream)``
+- ``SAFE_FREAD(ptr, size, nmemb, stream)``
+- ``SAFE_FWRITE(ptr, size, nmemb, stream)``
+- ``SAFE_FFLUSH(stream)``
+- ``SAFE_FSEEK(stream, offset, whence)``
+- ``SAFE_FTELL(stream)``
+- ``SAFE_FILENO(stream)``
+- ``SAFE_POPEN(command, type)``
+- ``SAFE_ASPRINTF(strp, fmt, ...)``
+
+SysV IPC (tst_safe_sysv_ipc.h)
+--------------------------------
+
+- ``SAFE_MSGGET(key, msgflg)``
+- ``SAFE_MSGSND(msqid, msgp, msgsz, msgflg)``
+- ``SAFE_MSGRCV(msqid, msgp, msgsz, msgtyp, msgflg)``
+- ``SAFE_MSGCTL(msqid, cmd, buf)``
+- ``SAFE_SEMGET(key, nsems, semflg)``
+- ``SAFE_SEMOP(semid, sops, nsops)``
+- ``SAFE_SEMCTL(semid, semnum, cmd, ...)``
+- ``SAFE_SHMGET(key, size, shmflg)``
+- ``SAFE_SHMAT(shmid, shmaddr, shmflg)``
+- ``SAFE_SHMDT(shmaddr)``
+- ``SAFE_SHMCTL(shmid, cmd, buf)``
+
+POSIX IPC (tst_safe_posix_ipc.h)
+----------------------------------
+
+- ``SAFE_MQ_OPEN(name, oflag, ...)``
+- ``SAFE_MQ_CLOSE(mqdes)``
+- ``SAFE_MQ_SEND(mqdes, msg_ptr, msg_len, msg_prio)``
+- ``SAFE_MQ_NOTIFY(mqdes, sevp)``
+- ``SAFE_MQ_UNLINK(name)``
+
+Clocks and timers (tst_safe_clocks.h)
+--------------------------------------
+
+- ``SAFE_CLOCK_GETRES(clk_id, res)``
+- ``SAFE_CLOCK_GETTIME(clk_id, tp)``
+- ``SAFE_CLOCK_SETTIME(clk_id, tp)``
+- ``SAFE_CLOCK_NANOSLEEP(clk_id, flags, request, remain)``
+- ``SAFE_TIMER_CREATE(clockid, sevp, timerid)``
+- ``SAFE_TIMER_SETTIME(timerid, flags, new_value, old_value)``
+- ``SAFE_TIMER_GETTIME(timerid, curr_value)``
+- ``SAFE_TIMER_DELETE(timerid)``
+
+Timer file descriptors (tst_safe_timerfd.h)
+--------------------------------------------
+
+- ``SAFE_TIMERFD_CREATE(clockid, flags)``
+- ``SAFE_TIMERFD_SETTIME(fd, flags, new_value, old_value)``
+- ``SAFE_TIMERFD_GETTIME(fd, curr_value)``
+
+io_uring (tst_safe_io_uring.h)
+-------------------------------
+
+- ``SAFE_IO_URING_INIT(entries, params, ring)``
+- ``SAFE_IO_URING_ENTER(fd, to_submit, min_complete, flags, sig)``
+- ``SAFE_IO_URING_CLOSE(ring)``
+
+Filesystem creation (tst_mkfs.h)
+--------------------------------
+
+- ``SAFE_MKFS(device, fs_type, fs_opts, extra_opts)``
+
+Process creation (tst_clone.h, tst_test.h)
+------------------------------------------
+
+- ``SAFE_CLONE(args)``
+- ``SAFE_FORK()``
+
+Control groups (tst_cgroup.h)
+-----------------------------
+
+- ``SAFE_CG_HAS(cg, file_name)``
+- ``SAFE_CG_OPEN(cg, file_name, flags, fds)``
+- ``SAFE_CG_READ(cg, file_name, out, len)``
+- ``SAFE_CG_PRINT(cg, file_name, str)``
+- ``SAFE_CG_PRINTF(cg, file_name, fmt, ...)``
+- ``SAFE_CG_SCANF(cg, file_name, fmt, ...)``
+- ``SAFE_CG_LINES_SCANF(cg, file_name, fmt, ...)``
+- ``SAFE_CG_OCCURSIN(cg, file_name, needle)``
+- ``SAFE_CG_FCHOWN(cg, file_name, owner, group)``
+
+Epoll (tst_epoll.h)
+-------------------
+
+- ``SAFE_EPOLL_CREATE1(flags)``
+- ``SAFE_EPOLL_CTL(epfd, op, fd, ev)``
+- ``SAFE_EPOLL_WAIT(epfd, events, maxevents, timeout)``
+
+Swap files (tse_swap.h)
+-----------------------
+
+- ``SAFE_MAKE_SMALL_SWAPFILE(swapfile)``
+- ``SAFE_MAKE_SWAPFILE_SIZE(swapfile, size)``
+- ``SAFE_MAKE_SWAPFILE_BLKS(swapfile, blocks)``
+
+Realtime signals (lapi/safe_rt_signal.h)
+----------------------------------------
+
+- ``SAFE_RT_SIGACTION(signum, act, oldact, sigsetsize)``
+- ``SAFE_RT_SIGPROCMASK(how, set, oldset, sigsetsize)``
+
+Fallback syscall wrappers (include/lapi/)
+-----------------------------------------
+
+- ``SAFE_STATX(dirfd, pathname, flags, mask, buf)``
+- ``SAFE_FCHMODAT2(dfd, filename, mode, flags)``
+- ``SAFE_SPLICE(fd_in, off_in, fd_out, off_out, len, flags)``
+- ``SAFE_KEYCTL(cmd, arg2, arg3, arg4, arg5)``
+- ``SAFE_USERFAULTFD(flags, retry)``
+- ``SAFE_MODIFY_LDT(func, ptr, bytecount)``
+- ``SAFE_LANDLOCK_CREATE_RULESET(attr, size, flags)``
+- ``SAFE_LANDLOCK_ADD_RULE(ruleset_fd, rule_type, rule_attr, flags)``
+- ``SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, flags)``
diff --git a/doc/index.rst b/doc/index.rst
index 58944a72da4c0a6d9362b0f85551683da03f5b72..c1252d34773e8411674fb143f5d871025b2fd96d 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -25,6 +25,7 @@
    developers/writing_tests
    developers/test_case_tutorial
    developers/api_c_tests
+   developers/api_safe_macros
    developers/api_shell_tests
    developers/api_network_tests
    developers/api_kvm_tests
@@ -82,6 +83,9 @@ For developers
 :doc:`developers/api_c_tests`
    Walk through the C API features
 
+:doc:`developers/api_safe_macros`
+   Reference of all ``SAFE_*`` wrapper macros
+
 :doc:`developers/api_shell_tests`
    Walk through the Shell API features
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
