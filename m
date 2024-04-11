Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9C1C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:39:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA53C3CF820
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:39:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 783563CF83E
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:36 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 52F4010103C1
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D175B5CD1B;
 Thu, 11 Apr 2024 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4gEqYO83js+SXkoa2eF8atnsmfGlF3M7a9ZdcEZHtE=;
 b=kC2BqGdV1PCEW4TwB4HgWVYQ4cmEwQoggts92Bl3t0T0jfH8P7+U4m4uV0Pb8yIp+DMKtu
 7IWN76aumo555k5+280fJvMWeV/Fs/A/uSCWGidvNbSxsYtBAjAn6s76eR/dyckqfbiJ5j
 rUuvEHT5RXXZMOtBX+BvU6HWOF2S9iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4gEqYO83js+SXkoa2eF8atnsmfGlF3M7a9ZdcEZHtE=;
 b=jzTr4gYhRgHz6bf+uJISV6KAkdvSA/O9rGklM0wY65nLEQWiJUZD/0kVyDHrtDzfzJBYOE
 yj5R8zrtDePrnHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4gEqYO83js+SXkoa2eF8atnsmfGlF3M7a9ZdcEZHtE=;
 b=kC2BqGdV1PCEW4TwB4HgWVYQ4cmEwQoggts92Bl3t0T0jfH8P7+U4m4uV0Pb8yIp+DMKtu
 7IWN76aumo555k5+280fJvMWeV/Fs/A/uSCWGidvNbSxsYtBAjAn6s76eR/dyckqfbiJ5j
 rUuvEHT5RXXZMOtBX+BvU6HWOF2S9iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4gEqYO83js+SXkoa2eF8atnsmfGlF3M7a9ZdcEZHtE=;
 b=jzTr4gYhRgHz6bf+uJISV6KAkdvSA/O9rGklM0wY65nLEQWiJUZD/0kVyDHrtDzfzJBYOE
 yj5R8zrtDePrnHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 904971386D;
 Thu, 11 Apr 2024 14:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UMx9Hwr0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:24 +0200
Message-ID: <20240411143025.352507-31-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 30/31] Remove doc/old/nommu-notes.txt
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

UCLINUX is dead and it's support has been removed from LTP.

Although Documentation/admin-guide/mm/nommu-mmap.rst still exists in
kernel tree, there is nobody really using it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/old/nommu-notes.txt | 171 ----------------------------------------
 1 file changed, 171 deletions(-)
 delete mode 100644 doc/old/nommu-notes.txt

diff --git a/doc/old/nommu-notes.txt b/doc/old/nommu-notes.txt
deleted file mode 100644
index 4baeff3b2..000000000
--- a/doc/old/nommu-notes.txt
+++ /dev/null
@@ -1,171 +0,0 @@
--------------
---- Intro ---
--------------
-
-Linux running on processors without a memory management unit place certain
-restrictions on the userspace programs.  Here we will provide some guidelines
-for people who are not familiar with such systems.
-
-If you are not familiar with virtual memory, you might want to review some
-background such as:
-	http://en.wikipedia.org/wiki/Virtual_Memory
-	/usr/src/linux/Documentation/nommu-mmap.txt
-
-----------------------------
---- No memory protection ---
-----------------------------
-
-By virtue of every process getting its own virtual memory space, applications
-are protected from each other.  So a bad memory access in one will not affect
-the memory of another.  When processors forgo virtual memory, they typically
-do not add memory protection back in to the hardware.  There are one or two
-exceptions to this rule, but for now, we'll assume no one supports it.
-
-In practical terms, this means you cannot dereference bad pointers directly
-and expect the kernel to catch and kill your application.  However, you can
-expect the kernel to catch some bad pointers when given to system calls.
-
-For example, this will "work" in the sense that no signal will be sent:
-	char *foo = NULL;
-	foo[0] = 'a';
-	foo[1] = 'b';
-
-However, the kernel should return errors when using "standard" bad pointers
-with system calls.  Such as:
-	char *foo = NULL;
-	write(1, foo, 10);
-	-> kernel will return EFAULT or similar
-The other bad pointer you can rely on in your tests is -1:
-	char *foo = (void *)-1;
-	read(0, foo, 10);
-	-> kernel will return EFAULT or similar
-
-Otherwise, no bad pointer may reliably be tested, either directly or
-indirectly via the kernel.  This tends to be a large part of the UCLINUX
-ifdef code that shows up in LTP.
-
-----------------
---- No forks ---
-----------------
-
-The ubiquitous fork() function relies completely on the Copy On Write (COW)
-functionality provided by virtual memory to share pages between processes.
-Since this isn't feasible without virtual memory, there is no fork() function.
-You will either get a linker error (undefined reference to fork) or you will
-get a runtime failure of ENOSYS.
-
-Typically, fork() is used for very few programming paradigms:
-	- daemonization
-	- run a program
-	- parallelism
-
-For the daemonization functionality, simply use the daemon() function.  This
-works under both MMU and NOMMU systems.
-
-To run a program, simply use vfork() followed by an exec-style function.
-And change the error handler in the child from exit() to _exit().  This too
-works under both MMU and NOMMU systems.  But be aware of vfork() semantics --
-since the parent and child share the same memory process, the child has to be
-careful in what it does.  This is why the recommended construct is simply:
-	pid_t child = vfork();
-	if (vfork == 0)
-		_exit(execl(....));
-
-For parallelism where processes use IPC to work together, you have to options,
-neither of which are easy.  You can rewrite to use threads, or you can re-exec
-yourself with special flags to pass along updated runtime state.  This is what
-the self_exec() helper function in LTP is designed for.
-
--------------------------
---- No overcommitting ---
--------------------------
-
-Virtual memory allows people to do malloc(128MiB) and get back a buffer that
-big.  But that buffer is only of virtual memory, not physical.  On a NOMMU
-system, the memory comes immediately from physical memory and takes it away
-from anyone else.
-
-Avoid large mallocs.
-
----------------------
---- Fragmentation ---
----------------------
-
-On a MMU system, when physical memory gets fragmented, things slow down.  But
-they keep working.  This is because every new process gets a clean virtual
-memory address space.  While processes can fragment their own virtual address
-space, this usually takes quite a long time and a lot of effort, so generally
-it is not a problem people hit.
-
-On a NOMMU system, when physical memory gets fragmented, access to large
-contiguous blocks becomes unavailable which means requests fail.  Even if your
-system has 40MiB _total_ free, the largest contiguous block might only be 1MiB
-which means that allocations larger than that will always fail.
-
-Break up your large memory allocations when possible.  Generally speaking,
-single allocations under 2MiB aren't a problem.
-
------------------
---- No paging ---
------------------
-
-No virtual memory means you can't mmap() a file and only have the pages read in
-(paged) on the fly.  So if you use mmap() on a file, the kernel must allocate
-memory for it and read in all the contents immediately.
-
----------------------
---- No swap space ---
----------------------
-
-See the "No paging" section above.  For the same reason, there is no support
-for swap partitions.  Plus, nommu typically means embedded which means flash
-based storage which means limited storage space and limited number of times
-you can write it.
-
--------------------------
---- No dynamic stacks ---
--------------------------
-
-No virtual memory means that applications can't all have their stacks at the
-top of memory and allowed to grown "indefinitely" downwards.  Stack space is
-fixed at process creation time (when it is first executed) and cannot grow.
-While the fixed size may be increased, it's best to avoid stack pressure in
-the first place.
-
-Avoid the alloca() function and use malloc()/free() instead.
-
-Avoid declaring large buffers on the stack.  Some people like to do things
-such as:
-	char buf[PATH_MAX];
-This will most likely smash the stack on nommu systems !  Use global variables
-(the bss), or use malloc()/free() type functions.
-
--------------------------------
---- No dynamic data segment ---
--------------------------------
-
-No virtual memory means that mappings cannot arbitrarily be extended.  Another
-process might have its own mapping right after yours!  This is where the brk()
-and sbrk() functions come into play.  These are most often used to dynamically
-increase the heap space via the C library, but a few people use these manually.
-
-Best if you simply avoid them, and if you're writing tests to exercise these
-functions specifically, make them nops/XFAIL for nommu systems.
-
--------------------------------
---- Limited shared mappings ---
--------------------------------
-
-No virtual memory means files cannot be mmapped in and have writes to it
-written back out to disk on the fly.  So you cannot use MAP_SHARED when
-mmapping a file.
-
--------------------------
---- No fixed mappings ---
--------------------------
-
-The MAP_FIXED option to mmap() is not supported.  It doesn't even really work
-all that well under MMU systems.
-
-Best if you simply avoid it, and if you're writing tests to exercise this
-option specifically, make them nops/XFAIL for nommu systems.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
