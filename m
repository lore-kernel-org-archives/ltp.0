Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD2C4828D
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:18:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 419D63CE4A0
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 17:18:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D91B3C12A7
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:18:40 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 188EB6001B8
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:18:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 529862231C;
 Wed,  7 Feb 2024 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707322719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qAcEpzXNPZCX0pHYBdAQju7vVYFcExlvgZ8ztb9/m0=;
 b=1caXHe+VfDefT/8GVgZgrzicIrZKik7svuvi7xIyPlYAOHNtV97n75NLDy3xKK9b+W2VWC
 aNG87rwt5ZHDLjLEizIY33XfxgX2iHAxdK5yiuAlrSBbG8Jns0G1Hj8pujNome073LUwMi
 GYa9Wm0H9KrnbJUjPoyQ8bv/fnDrmKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707322719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qAcEpzXNPZCX0pHYBdAQju7vVYFcExlvgZ8ztb9/m0=;
 b=UIklxWaZcOLdp+6ZSrGxkbFV33JxnRzYcgJU+WtShdYyBwi+xiajWIzk9+zJ1fj6xHpz6v
 oAb1nGB9zGiV7lCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707322719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qAcEpzXNPZCX0pHYBdAQju7vVYFcExlvgZ8ztb9/m0=;
 b=1caXHe+VfDefT/8GVgZgrzicIrZKik7svuvi7xIyPlYAOHNtV97n75NLDy3xKK9b+W2VWC
 aNG87rwt5ZHDLjLEizIY33XfxgX2iHAxdK5yiuAlrSBbG8Jns0G1Hj8pujNome073LUwMi
 GYa9Wm0H9KrnbJUjPoyQ8bv/fnDrmKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707322719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qAcEpzXNPZCX0pHYBdAQju7vVYFcExlvgZ8ztb9/m0=;
 b=UIklxWaZcOLdp+6ZSrGxkbFV33JxnRzYcgJU+WtShdYyBwi+xiajWIzk9+zJ1fj6xHpz6v
 oAb1nGB9zGiV7lCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E9B813931;
 Wed,  7 Feb 2024 16:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PgBfAV+tw2WITAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Feb 2024 16:18:39 +0000
Date: Wed, 7 Feb 2024 17:18:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240207161837.GB128563@pevik>
References: <20240207160628.125908-1-pvorel@suse.cz>
 <20240207160628.125908-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240207160628.125908-3-pvorel@suse.cz>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1caXHe+V;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UIklxWaZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[19.98%]
X-Rspamd-Queue-Id: 529862231C
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add test for tst_tmpdir
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

And more diff here.

Kind regards,
Petr

diff --git lib/newlib_tests/tst_tmpdir.c lib/newlib_tests/tst_tmpdir.c
index 008542808..c34430fa6 100644
--- lib/newlib_tests/tst_tmpdir.c
+++ lib/newlib_tests/tst_tmpdir.c
@@ -18,7 +18,8 @@ static struct tcase {
 } tcases[] = {
 	{NULL, TEMPDIR, "default value"},
 	{"/tmp/", "/tmp", "removing trailing slash"},
-	{"//var///tmp", "/var/tmp", "removing duplicate slashes"},
+	{"/var//tmp", "/var/tmp", "removing duplicate slashes"},
+	{"//var///tmp///", "/var/tmp", "removing too many slashes"},
 };
 
 static void do_test(unsigned int nr)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
