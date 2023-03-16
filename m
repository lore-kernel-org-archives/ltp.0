Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F235CC6FD1F
	for <ltp@archiver.kernel.org>; Thu, 16 Mar 2023 07:22:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 711FC3CD47E
	for <ltp@archiver.kernel.org>; Thu, 16 Mar 2023 08:22:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB6D63C0041
 for <ltp@lists.linux.it>; Thu, 16 Mar 2023 08:22:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E1C651000DD2
 for <ltp@lists.linux.it>; Thu, 16 Mar 2023 08:22:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D039E1FDEC;
 Thu, 16 Mar 2023 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678951364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8aGn0+Vl4AjSODG8WJVh3G+oqO2wID0QSG+ZNBnsIE=;
 b=F7a9LlZTnWS5E/cF0PA1JUmI0LRV9N9JYeTq2Mf90IlmAxe5HuoED1mixgoLTfAM3V421w
 L/ypoUXt2YFoFA3s91W+WUZdndCqF608bMU3hG+AkhchiY0cUTZ1PEE//KKXdrzzh2kfkN
 t9KapUq46PbhnjU/IwuE6rT0Ej8XRTA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15098133E0;
 Thu, 16 Mar 2023 07:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NrPnNMPDEmTiAQAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 16 Mar 2023 07:22:43 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Mar 2023 03:22:29 -0400
Message-Id: <20230316072231.19157-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230302071555.18420-1-wegao@suse.com>
References: <20230302071555.18420-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Refactor semaphore
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  Move semaphore/ tests to semop/
  semop04:Refactor with new API

 runtest/ipc                                   |   2 -
 runtest/syscalls                              |   2 +
 testcases/kernel/ipc/semaphore/.gitignore     |   2 -
 testcases/kernel/ipc/semaphore/Makefile       |  30 ----
 testcases/kernel/ipc/semaphore/sem01.c        | 164 ------------------
 .../kernel/syscalls/ipc/semop/.gitignore      |   2 +
 testcases/kernel/syscalls/ipc/semop/Makefile  |   5 +-
 testcases/kernel/syscalls/ipc/semop/semop04.c | 117 +++++++++++++
 .../sem02.c => syscalls/ipc/semop/semop05.c}  |   0
 9 files changed, 125 insertions(+), 199 deletions(-)
 delete mode 100644 testcases/kernel/ipc/semaphore/.gitignore
 delete mode 100644 testcases/kernel/ipc/semaphore/Makefile
 delete mode 100644 testcases/kernel/ipc/semaphore/sem01.c
 create mode 100644 testcases/kernel/syscalls/ipc/semop/semop04.c
 rename testcases/kernel/{ipc/semaphore/sem02.c => syscalls/ipc/semop/semop05.c} (100%)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
