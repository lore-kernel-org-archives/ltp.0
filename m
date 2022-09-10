Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2854EECAAD3
	for <ltp@archiver.kernel.org>; Sat, 10 Sep 2022 17:05:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 884C23CAAB0
	for <ltp@archiver.kernel.org>; Sat, 10 Sep 2022 19:05:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF7E93C952D
 for <ltp@lists.linux.it>; Sat, 10 Sep 2022 19:05:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6A6820011A
 for <ltp@lists.linux.it>; Sat, 10 Sep 2022 19:05:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8FEC1F8F5;
 Sat, 10 Sep 2022 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662829523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjGs2rA9LkGoKA9GugzrOh8yFZKoIqrfDG9zI2wwlv4=;
 b=kuWdyjAJgDTo6l/SL7D1TDT43IWdqgh0Q0T7uXjBLwQYeMPqecklPjVFkFpQGGwVdYCH9f
 AiihZ7ceZSbl9gebuup9MDO7peM6c36L/76MfZlzT98XzTw+RmYQO+B+0rZVsy1AjSN/J/
 4PEzPOOxxeS4w9tZ9BUjN8IiFSrQqMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662829523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjGs2rA9LkGoKA9GugzrOh8yFZKoIqrfDG9zI2wwlv4=;
 b=i3bKoSq5buhbmrLC+6eegTwikjvso31G/bXVGjGgWzEwGuANrzysusYmNAeih6yrltNqZm
 It6AJ+k6GZIcxsCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F34B13441;
 Sat, 10 Sep 2022 17:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v2xRFdPDHGPXdQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 10 Sep 2022 17:05:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sat, 10 Sep 2022 19:05:18 +0200
Message-Id: <20220910170518.17006-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] Add .mailmap
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
Cc: Jiri Jaburek <jjaburek@redhat.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To fix authors list (git shortlog -e).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

although I prefer to keep signing non-SUSE work ("after work hacking")
with my private gmail mail, for release counting purposes it's better to
keep only SUSE mail.

I suppose others want to update their mail. I didn't dare to add these,
feel free to send patch with your setup:

Andrea Cervesato <andrea.cervesato@suse.com> <andrea.cervesato@suse.de>
Jiri Jaburek <jjaburek@redhat.com> <jjaburek@users.noreply.github.com>
Richard Palethorpe <rpalethorpe@suse.com> <rpalethorpe@suse.com>
Yang Xu <xuyang2018.jy@fujitsu.com> <yangx.jy@cn.fujitsu.com>

Unfortunately I don't know how to correct addresses "Name Surname via ltp <ltp@lists.linux.it>".

Kind regards,
Petr

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 .mailmap

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 000000000..6c4b8dab3
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,2 @@
+Petr Vorel <pvorel@suse.cz> <petr.vorel@gmail.com>
+Petr Vorel <pvorel@suse.cz> <pevik@users.noreply.github.com>
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
