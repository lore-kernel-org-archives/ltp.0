Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D757CD98F2
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 13:57:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF10B3E0E51
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 15:57:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72B13E0DA4
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 15:56:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A06A1A00667
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 15:56:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5D0175CE4
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782136609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+i6Asnjc4lVlCWPwyei3Zb/JC+RWNy/k7RPF1jcRLQ=;
 b=KtW8xCgKUj8AN6DdxULZjnMMaRqfVuaaPwXmCZS8RUdtVlBwj2i246w78+iP42NpMjY0Je
 2Dyc7XSQMFMGOozopK6BQsduWUqZhmirIV2WzShaq2Yf8cvaGxpJfyqcSDhToZXYG1uPde
 tBdubuy+PRXZvvKmHeoK6ZmlRfMQrw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782136609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+i6Asnjc4lVlCWPwyei3Zb/JC+RWNy/k7RPF1jcRLQ=;
 b=zm612gG3+54p/bbfbMQtYwCmPLwz6Svypd9xZRykO4bvttE5XHeVVS1dPzjQP9iQMIjtKk
 9f547KhFT4VFa2Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KtW8xCgK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zm612gG3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782136609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+i6Asnjc4lVlCWPwyei3Zb/JC+RWNy/k7RPF1jcRLQ=;
 b=KtW8xCgKUj8AN6DdxULZjnMMaRqfVuaaPwXmCZS8RUdtVlBwj2i246w78+iP42NpMjY0Je
 2Dyc7XSQMFMGOozopK6BQsduWUqZhmirIV2WzShaq2Yf8cvaGxpJfyqcSDhToZXYG1uPde
 tBdubuy+PRXZvvKmHeoK6ZmlRfMQrw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782136609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+i6Asnjc4lVlCWPwyei3Zb/JC+RWNy/k7RPF1jcRLQ=;
 b=zm612gG3+54p/bbfbMQtYwCmPLwz6Svypd9xZRykO4bvttE5XHeVVS1dPzjQP9iQMIjtKk
 9f547KhFT4VFa2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0AF6779A8
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 13:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X4CoJSE/OWqUQQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 13:56:49 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 22 Jun 2026 15:56:52 +0200
Message-ID: <20260622135652.3516051-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C5D0175CE4
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: Flatten the directory structure
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

Move the syscall tests from syscalls/ipc/ directory to syscalls/
directory. And the ipc/msgstress to kernel/ipc/ directory.

This fixes the generated metadata groups for SysV IPC tests.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/{syscalls => }/ipc/msgstress/.gitignore   | 0
 testcases/kernel/{syscalls => }/ipc/msgstress/Makefile     | 2 +-
 .../kernel/{syscalls => }/ipc/msgstress/msgstress01.c      | 0
 testcases/kernel/syscalls/ipc/Makefile                     | 7 -------
 testcases/kernel/syscalls/{ipc => }/msgctl/.gitignore      | 0
 testcases/kernel/syscalls/{ipc/shmat => msgctl}/Makefile   | 2 +-
 testcases/kernel/syscalls/{ipc => }/msgctl/msgctl01.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgctl/msgctl02.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgctl/msgctl03.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgctl/msgctl04.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgctl/msgctl05.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgctl/msgctl06.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgctl/msgctl12.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgget/.gitignore      | 0
 testcases/kernel/syscalls/{ipc/msgctl => msgget}/Makefile  | 2 +-
 testcases/kernel/syscalls/{ipc => }/msgget/msgget01.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgget/msgget02.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgget/msgget03.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgget/msgget04.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgget/msgget05.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgrcv/.gitignore      | 0
 testcases/kernel/syscalls/{ipc/msgget => msgrcv}/Makefile  | 2 +-
 testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv01.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv02.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv03.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv05.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv06.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv07.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv08.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgsnd/.gitignore      | 0
 testcases/kernel/syscalls/{ipc => }/msgsnd/Makefile        | 2 +-
 testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd01.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd02.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd05.c      | 0
 testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd06.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/.gitignore      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/Makefile        | 2 +-
 testcases/kernel/syscalls/{ipc => }/semctl/semctl01.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl02.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl03.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl04.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl05.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl06.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl07.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl08.c      | 0
 testcases/kernel/syscalls/{ipc => }/semctl/semctl09.c      | 0
 testcases/kernel/syscalls/{ipc => }/semget/.gitignore      | 0
 testcases/kernel/syscalls/{ipc => }/semget/Makefile        | 2 +-
 testcases/kernel/syscalls/{ipc => }/semget/semget01.c      | 0
 testcases/kernel/syscalls/{ipc => }/semget/semget02.c      | 0
 testcases/kernel/syscalls/{ipc => }/semget/semget05.c      | 0
 testcases/kernel/syscalls/{ipc => }/semop/.gitignore       | 0
 testcases/kernel/syscalls/{ipc => }/semop/Makefile         | 2 +-
 testcases/kernel/syscalls/{ipc => }/semop/semop.h          | 0
 testcases/kernel/syscalls/{ipc => }/semop/semop01.c        | 0
 testcases/kernel/syscalls/{ipc => }/semop/semop02.c        | 0
 testcases/kernel/syscalls/{ipc => }/semop/semop03.c        | 0
 testcases/kernel/syscalls/{ipc => }/semop/semop04.c        | 0
 testcases/kernel/syscalls/{ipc => }/semop/semop05.c        | 0
 testcases/kernel/syscalls/{ipc => }/shmat/.gitignore       | 0
 testcases/kernel/syscalls/{ipc/msgrcv => shmat}/Makefile   | 2 +-
 testcases/kernel/syscalls/{ipc => }/shmat/shmat01.c        | 0
 testcases/kernel/syscalls/{ipc => }/shmat/shmat02.c        | 0
 testcases/kernel/syscalls/{ipc => }/shmat/shmat03.c        | 0
 testcases/kernel/syscalls/{ipc => }/shmat/shmat04.c        | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/.gitignore      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/Makefile        | 2 +-
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl01.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl02.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl03.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl04.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl05.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl06.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl07.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmctl/shmctl08.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmdt/.gitignore       | 0
 testcases/kernel/syscalls/{ipc => }/shmdt/Makefile         | 2 +-
 testcases/kernel/syscalls/{ipc => }/shmdt/shmdt01.c        | 0
 testcases/kernel/syscalls/{ipc => }/shmdt/shmdt02.c        | 0
 testcases/kernel/syscalls/{ipc => }/shmget/.gitignore      | 0
 testcases/kernel/syscalls/{ipc => }/shmget/Makefile        | 2 +-
 testcases/kernel/syscalls/{ipc => }/shmget/shmget02.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmget/shmget03.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmget/shmget04.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmget/shmget05.c      | 0
 testcases/kernel/syscalls/{ipc => }/shmget/shmget06.c      | 0
 86 files changed, 12 insertions(+), 19 deletions(-)
 rename testcases/kernel/{syscalls => }/ipc/msgstress/.gitignore (100%)
 rename testcases/kernel/{syscalls => }/ipc/msgstress/Makefile (83%)
 rename testcases/kernel/{syscalls => }/ipc/msgstress/msgstress01.c (100%)
 delete mode 100644 testcases/kernel/syscalls/ipc/Makefile
 rename testcases/kernel/syscalls/{ipc => }/msgctl/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc/shmat => msgctl}/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/msgctl/msgctl01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgctl/msgctl02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgctl/msgctl03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgctl/msgctl04.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgctl/msgctl05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgctl/msgctl06.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgctl/msgctl12.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgget/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc/msgctl => msgget}/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/msgget/msgget01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgget/msgget02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgget/msgget03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgget/msgget04.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgget/msgget05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc/msgget => msgrcv}/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv06.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv07.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgrcv/msgrcv08.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgsnd/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgsnd/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/msgsnd/msgsnd06.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/Makefile (89%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl04.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl06.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl07.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl08.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semctl/semctl09.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semget/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc => }/semget/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/semget/semget01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semget/semget02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semget/semget05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semop/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc => }/semop/Makefile (89%)
 rename testcases/kernel/syscalls/{ipc => }/semop/semop.h (100%)
 rename testcases/kernel/syscalls/{ipc => }/semop/semop01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semop/semop02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semop/semop03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semop/semop04.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/semop/semop05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmat/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc/msgrcv => shmat}/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/shmat/shmat01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmat/shmat02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmat/shmat03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmat/shmat04.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/Makefile (89%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl04.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl06.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl07.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmctl/shmctl08.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmdt/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmdt/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/shmdt/shmdt01.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmdt/shmdt02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmget/.gitignore (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmget/Makefile (85%)
 rename testcases/kernel/syscalls/{ipc => }/shmget/shmget02.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmget/shmget03.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmget/shmget04.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmget/shmget05.c (100%)
 rename testcases/kernel/syscalls/{ipc => }/shmget/shmget06.c (100%)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/.gitignore b/testcases/kernel/ipc/msgstress/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgstress/.gitignore
rename to testcases/kernel/ipc/msgstress/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/ipc/msgstress/Makefile
similarity index 83%
rename from testcases/kernel/syscalls/ipc/msgstress/Makefile
rename to testcases/kernel/ipc/msgstress/Makefile
index 442eb87d5..744f099d8 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/ipc/msgstress/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/ipc/msgstress/msgstress01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
rename to testcases/kernel/ipc/msgstress/msgstress01.c
diff --git a/testcases/kernel/syscalls/ipc/Makefile b/testcases/kernel/syscalls/ipc/Makefile
deleted file mode 100644
index 7876f4bbd..000000000
--- a/testcases/kernel/syscalls/ipc/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines  Corp., 2001
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgctl/.gitignore b/testcases/kernel/syscalls/msgctl/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/.gitignore
rename to testcases/kernel/syscalls/msgctl/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/msgctl/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/shmat/Makefile
rename to testcases/kernel/syscalls/msgctl/Makefile
index baa2a48e6..7f4c92d46 100644
--- a/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ b/testcases/kernel/syscalls/msgctl/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c b/testcases/kernel/syscalls/msgctl/msgctl01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
rename to testcases/kernel/syscalls/msgctl/msgctl01.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c b/testcases/kernel/syscalls/msgctl/msgctl02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
rename to testcases/kernel/syscalls/msgctl/msgctl02.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c b/testcases/kernel/syscalls/msgctl/msgctl03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
rename to testcases/kernel/syscalls/msgctl/msgctl03.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/msgctl/msgctl04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
rename to testcases/kernel/syscalls/msgctl/msgctl04.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/msgctl/msgctl05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
rename to testcases/kernel/syscalls/msgctl/msgctl05.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/msgctl/msgctl06.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
rename to testcases/kernel/syscalls/msgctl/msgctl06.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c b/testcases/kernel/syscalls/msgctl/msgctl12.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
rename to testcases/kernel/syscalls/msgctl/msgctl12.c
diff --git a/testcases/kernel/syscalls/ipc/msgget/.gitignore b/testcases/kernel/syscalls/msgget/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgget/.gitignore
rename to testcases/kernel/syscalls/msgget/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/msgget/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/msgctl/Makefile
rename to testcases/kernel/syscalls/msgget/Makefile
index baa2a48e6..7f4c92d46 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/msgget/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/msgget/msgget01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgget/msgget01.c
rename to testcases/kernel/syscalls/msgget/msgget01.c
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/msgget/msgget02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgget/msgget02.c
rename to testcases/kernel/syscalls/msgget/msgget02.c
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/msgget/msgget03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgget/msgget03.c
rename to testcases/kernel/syscalls/msgget/msgget03.c
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/msgget/msgget04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgget/msgget04.c
rename to testcases/kernel/syscalls/msgget/msgget04.c
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c b/testcases/kernel/syscalls/msgget/msgget05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgget/msgget05.c
rename to testcases/kernel/syscalls/msgget/msgget05.c
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/.gitignore b/testcases/kernel/syscalls/msgrcv/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/.gitignore
rename to testcases/kernel/syscalls/msgrcv/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/msgget/Makefile b/testcases/kernel/syscalls/msgrcv/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/msgget/Makefile
rename to testcases/kernel/syscalls/msgrcv/Makefile
index baa2a48e6..7f4c92d46 100644
--- a/testcases/kernel/syscalls/ipc/msgget/Makefile
+++ b/testcases/kernel/syscalls/msgrcv/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/msgrcv/msgrcv01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
rename to testcases/kernel/syscalls/msgrcv/msgrcv01.c
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/msgrcv/msgrcv02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
rename to testcases/kernel/syscalls/msgrcv/msgrcv02.c
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c b/testcases/kernel/syscalls/msgrcv/msgrcv03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
rename to testcases/kernel/syscalls/msgrcv/msgrcv03.c
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c b/testcases/kernel/syscalls/msgrcv/msgrcv05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
rename to testcases/kernel/syscalls/msgrcv/msgrcv05.c
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c b/testcases/kernel/syscalls/msgrcv/msgrcv06.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
rename to testcases/kernel/syscalls/msgrcv/msgrcv06.c
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/msgrcv/msgrcv07.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
rename to testcases/kernel/syscalls/msgrcv/msgrcv07.c
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/msgrcv/msgrcv08.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
rename to testcases/kernel/syscalls/msgrcv/msgrcv08.c
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/.gitignore b/testcases/kernel/syscalls/msgsnd/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgsnd/.gitignore
rename to testcases/kernel/syscalls/msgsnd/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/Makefile b/testcases/kernel/syscalls/msgsnd/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/msgsnd/Makefile
rename to testcases/kernel/syscalls/msgsnd/Makefile
index 0b7b7bd40..87c93238e 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/msgsnd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/msgsnd/msgsnd01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
rename to testcases/kernel/syscalls/msgsnd/msgsnd01.c
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/msgsnd/msgsnd02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
rename to testcases/kernel/syscalls/msgsnd/msgsnd02.c
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/msgsnd/msgsnd05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
rename to testcases/kernel/syscalls/msgsnd/msgsnd05.c
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/msgsnd/msgsnd06.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
rename to testcases/kernel/syscalls/msgsnd/msgsnd06.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/.gitignore b/testcases/kernel/syscalls/semctl/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/.gitignore
rename to testcases/kernel/syscalls/semctl/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/semctl/Makefile
similarity index 89%
rename from testcases/kernel/syscalls/ipc/semctl/Makefile
rename to testcases/kernel/syscalls/semctl/Makefile
index aa11e7003..0e7223998 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/semctl/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = ipc newipc
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl01.c
rename to testcases/kernel/syscalls/semctl/semctl01.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/semctl/semctl02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl02.c
rename to testcases/kernel/syscalls/semctl/semctl02.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/semctl/semctl03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl03.c
rename to testcases/kernel/syscalls/semctl/semctl03.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl04.c b/testcases/kernel/syscalls/semctl/semctl04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl04.c
rename to testcases/kernel/syscalls/semctl/semctl04.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/semctl/semctl05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl05.c
rename to testcases/kernel/syscalls/semctl/semctl05.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl06.c b/testcases/kernel/syscalls/semctl/semctl06.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl06.c
rename to testcases/kernel/syscalls/semctl/semctl06.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/semctl/semctl07.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl07.c
rename to testcases/kernel/syscalls/semctl/semctl07.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/semctl/semctl08.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl08.c
rename to testcases/kernel/syscalls/semctl/semctl08.c
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/semctl/semctl09.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semctl/semctl09.c
rename to testcases/kernel/syscalls/semctl/semctl09.c
diff --git a/testcases/kernel/syscalls/ipc/semget/.gitignore b/testcases/kernel/syscalls/semget/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semget/.gitignore
rename to testcases/kernel/syscalls/semget/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/semget/Makefile b/testcases/kernel/syscalls/semget/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/semget/Makefile
rename to testcases/kernel/syscalls/semget/Makefile
index d1e778f98..161c2c187 100644
--- a/testcases/kernel/syscalls/ipc/semget/Makefile
+++ b/testcases/kernel/syscalls/semget/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget01.c b/testcases/kernel/syscalls/semget/semget01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semget/semget01.c
rename to testcases/kernel/syscalls/semget/semget01.c
diff --git a/testcases/kernel/syscalls/ipc/semget/semget02.c b/testcases/kernel/syscalls/semget/semget02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semget/semget02.c
rename to testcases/kernel/syscalls/semget/semget02.c
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/semget/semget05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semget/semget05.c
rename to testcases/kernel/syscalls/semget/semget05.c
diff --git a/testcases/kernel/syscalls/ipc/semop/.gitignore b/testcases/kernel/syscalls/semop/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/.gitignore
rename to testcases/kernel/syscalls/semop/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/semop/Makefile b/testcases/kernel/syscalls/semop/Makefile
similarity index 89%
rename from testcases/kernel/syscalls/ipc/semop/Makefile
rename to testcases/kernel/syscalls/semop/Makefile
index 5d082e912..2775d84a9 100644
--- a/testcases/kernel/syscalls/ipc/semop/Makefile
+++ b/testcases/kernel/syscalls/semop/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop.h b/testcases/kernel/syscalls/semop/semop.h
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/semop.h
rename to testcases/kernel/syscalls/semop/semop.h
diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/semop/semop01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/semop01.c
rename to testcases/kernel/syscalls/semop/semop01.c
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/semop/semop02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/semop02.c
rename to testcases/kernel/syscalls/semop/semop02.c
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/semop/semop03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/semop03.c
rename to testcases/kernel/syscalls/semop/semop03.c
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/semop/semop04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/semop04.c
rename to testcases/kernel/syscalls/semop/semop04.c
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/semop/semop05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/semop05.c
rename to testcases/kernel/syscalls/semop/semop05.c
diff --git a/testcases/kernel/syscalls/ipc/shmat/.gitignore b/testcases/kernel/syscalls/shmat/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmat/.gitignore
rename to testcases/kernel/syscalls/shmat/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/Makefile b/testcases/kernel/syscalls/shmat/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/msgrcv/Makefile
rename to testcases/kernel/syscalls/shmat/Makefile
index baa2a48e6..7f4c92d46 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/Makefile
+++ b/testcases/kernel/syscalls/shmat/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/shmat/shmat01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmat/shmat01.c
rename to testcases/kernel/syscalls/shmat/shmat01.c
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/shmat/shmat02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmat/shmat02.c
rename to testcases/kernel/syscalls/shmat/shmat02.c
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/shmat/shmat03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmat/shmat03.c
rename to testcases/kernel/syscalls/shmat/shmat03.c
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat04.c b/testcases/kernel/syscalls/shmat/shmat04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmat/shmat04.c
rename to testcases/kernel/syscalls/shmat/shmat04.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/.gitignore b/testcases/kernel/syscalls/shmctl/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/.gitignore
rename to testcases/kernel/syscalls/shmctl/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/shmctl/Makefile
similarity index 89%
rename from testcases/kernel/syscalls/ipc/shmctl/Makefile
rename to testcases/kernel/syscalls/shmctl/Makefile
index d4278dcd7..6bc9a2b4c 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/shmctl/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/shmctl/shmctl01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
rename to testcases/kernel/syscalls/shmctl/shmctl01.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/shmctl/shmctl02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
rename to testcases/kernel/syscalls/shmctl/shmctl02.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
rename to testcases/kernel/syscalls/shmctl/shmctl03.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/shmctl/shmctl04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
rename to testcases/kernel/syscalls/shmctl/shmctl04.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/shmctl/shmctl05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
rename to testcases/kernel/syscalls/shmctl/shmctl05.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c b/testcases/kernel/syscalls/shmctl/shmctl06.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
rename to testcases/kernel/syscalls/shmctl/shmctl06.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c b/testcases/kernel/syscalls/shmctl/shmctl07.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
rename to testcases/kernel/syscalls/shmctl/shmctl07.c
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c b/testcases/kernel/syscalls/shmctl/shmctl08.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
rename to testcases/kernel/syscalls/shmctl/shmctl08.c
diff --git a/testcases/kernel/syscalls/ipc/shmdt/.gitignore b/testcases/kernel/syscalls/shmdt/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmdt/.gitignore
rename to testcases/kernel/syscalls/shmdt/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/shmdt/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/shmdt/Makefile
rename to testcases/kernel/syscalls/shmdt/Makefile
index d1e778f98..161c2c187 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/shmdt/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c b/testcases/kernel/syscalls/shmdt/shmdt01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
rename to testcases/kernel/syscalls/shmdt/shmdt01.c
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c b/testcases/kernel/syscalls/shmdt/shmdt02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
rename to testcases/kernel/syscalls/shmdt/shmdt02.c
diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/shmget/.gitignore
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmget/.gitignore
rename to testcases/kernel/syscalls/shmget/.gitignore
diff --git a/testcases/kernel/syscalls/ipc/shmget/Makefile b/testcases/kernel/syscalls/shmget/Makefile
similarity index 85%
rename from testcases/kernel/syscalls/ipc/shmget/Makefile
rename to testcases/kernel/syscalls/shmget/Makefile
index d1e778f98..161c2c187 100644
--- a/testcases/kernel/syscalls/ipc/shmget/Makefile
+++ b/testcases/kernel/syscalls/shmget/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir              ?= ../../../../..
+top_srcdir              ?= ../../../..
 
 LTPLIBS = newipc
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/shmget/shmget02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmget/shmget02.c
rename to testcases/kernel/syscalls/shmget/shmget02.c
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/shmget/shmget03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmget/shmget03.c
rename to testcases/kernel/syscalls/shmget/shmget03.c
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/shmget/shmget04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmget/shmget04.c
rename to testcases/kernel/syscalls/shmget/shmget04.c
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/shmget/shmget05.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmget/shmget05.c
rename to testcases/kernel/syscalls/shmget/shmget05.c
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget06.c b/testcases/kernel/syscalls/shmget/shmget06.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/shmget/shmget06.c
rename to testcases/kernel/syscalls/shmget/shmget06.c
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
