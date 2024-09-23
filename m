Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F31CF9C6E
	for <ltp@archiver.kernel.org>; Mon, 23 Sep 2024 12:56:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33FC33C32E6
	for <ltp@archiver.kernel.org>; Mon, 23 Sep 2024 14:56:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 507E03C02E4
 for <ltp@lists.linux.it>; Mon, 23 Sep 2024 14:55:51 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9BDBB1000C61
 for <ltp@lists.linux.it>; Mon, 23 Sep 2024 14:55:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2285C21178;
 Mon, 23 Sep 2024 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727096149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SF7tv6MUkRRdOj5PGIOazi9BKZJT54CzlroR7C8a1P0=;
 b=hHB/WRbjd+kxVie6fMU3bes4EhRwJd7LZKPZn76IhuCEMw8KaBeUXar23BDG9XmqitRrEA
 XrA7Ivy5li3Ial2k30xP5SGOn3wc6lRhY4EPoB9W0rNvtATVGsZi/AuVRziDNYsASFbhNW
 qKTfFP9Gz4AGl03Ie8EcbJT2P+lajjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727096149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SF7tv6MUkRRdOj5PGIOazi9BKZJT54CzlroR7C8a1P0=;
 b=lSDBa8zt8IDlSxV1iTQ7La2VF1MlVDBXWU69nYi7FewHiBOAQfUhNZEfgTtPoZD/Q7i5/z
 bfugVO077QxgclCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727096149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SF7tv6MUkRRdOj5PGIOazi9BKZJT54CzlroR7C8a1P0=;
 b=hHB/WRbjd+kxVie6fMU3bes4EhRwJd7LZKPZn76IhuCEMw8KaBeUXar23BDG9XmqitRrEA
 XrA7Ivy5li3Ial2k30xP5SGOn3wc6lRhY4EPoB9W0rNvtATVGsZi/AuVRziDNYsASFbhNW
 qKTfFP9Gz4AGl03Ie8EcbJT2P+lajjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727096149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SF7tv6MUkRRdOj5PGIOazi9BKZJT54CzlroR7C8a1P0=;
 b=lSDBa8zt8IDlSxV1iTQ7La2VF1MlVDBXWU69nYi7FewHiBOAQfUhNZEfgTtPoZD/Q7i5/z
 bfugVO077QxgclCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC3BF13A64;
 Mon, 23 Sep 2024 12:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mw6OOFRl8WYkRQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Sep 2024 12:55:48 +0000
Date: Mon, 23 Sep 2024 14:54:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <ZvFlFEA52rQWQYP0@yuki.lan>
References: <20240919032729.458711-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240919032729.458711-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2]
 posix/conformance/interfaces/sem_timedwait/2-1: Remove MAP_ANONYMOUS
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with two minor changes, thanks.

- POSIX requires that the SHM_NAME starts with /
- Made use of ERROR_PREFIX

Full diff:
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
index b1747f01d..d9012cc5e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
@@ -24,7 +24,7 @@
 #include "posixtest.h"
 
 #define TEST "2-1"
-#define SHM_NAME "posixtest_2-1"
+#define SHM_NAME "/posixtest_2-1"
 #define FUNCTION "sem_timedwait"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
@@ -36,17 +36,17 @@ int main(void)
 
        fd = shm_open(SHM_NAME, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
        if (fd == -1) {
-               perror("An error occurs when calling shm_open()");
+               perror(ERROR_PREFIX "shm_open()");
                return PTS_UNRESOLVED;
        }
 
        if (ftruncate(fd, sizeof(*mysemp)) == -1) {
-               perror("An error occurs when calling ftruncate()");
+               perror(ERROR_PREFIX "ftruncate()");
                return PTS_UNRESOLVED;
        }
 
        if (shm_unlink(SHM_NAME) != 0) {
-               perror("An error occurs when calling shm_unlink()");
+               perror(ERROR_PREFIX "shm_unlink()");
                return PTS_UNRESOLVED;
        }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
