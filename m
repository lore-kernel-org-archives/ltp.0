Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65E60703E3
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ukeWLe5g;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZnbvinPo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=bcwKTVKr;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5e/9rmi5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 157303CF0EF
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 18:18:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04D0A3CEF79
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 18:17:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD9011000A41
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 18:17:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 311731FEE7;
 Thu,  5 Nov 2026 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793899078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTz8gBjE773PrKGkaWjr5TgzZBBuYeuR0iRZmYgGGAE=;
 b=ukeWLe5gA3KSihLEROYz8XLCVdOaBRZAF48GglvUj7UQgHYzEDc9nNhx6fi1ayG+ZxjvKZ
 aDQIVuImMGdGLJ/ie2CEYOSKUSAjq8CKkyjSZzYDAFrfu85Iegj9aXFHj/pqkQ5lL3F/bo
 Rp+tBEf3+AdxAZDSCiSzDDSASB5fL5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793899078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTz8gBjE773PrKGkaWjr5TgzZBBuYeuR0iRZmYgGGAE=;
 b=ZnbvinPoxq2Uq+yXNteuSsJigyo6Q9/wYoyywtG8E82UPLRZ1uMj9m78h3lap/jvoz0bTF
 uax9n9UU7wUC90BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793899076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTz8gBjE773PrKGkaWjr5TgzZBBuYeuR0iRZmYgGGAE=;
 b=bcwKTVKrQ5n7DxjNQjzPteAjqnEp9a/13qh2I9drBT5FL7u15zWnHQjQHLfOLkv1nWzg4j
 BywRG+8LKgYUNZ8PPKHQmQB1mUPYnWEKHTFmmUxSUjkSSVyoOMCUtrvWFUTzNGcw9sPe5h
 LehpalxvDhJp9Si3a1n0b38/ntwy6hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793899076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTz8gBjE773PrKGkaWjr5TgzZBBuYeuR0iRZmYgGGAE=;
 b=5e/9rmi5yB27AJNUvsNIc1DrzMboeEqY7Iv4cT+RyuCPJ/2U+pvn7C9GaxlG2BtEtI3q75
 Xav+n9GJPux/G+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8602134F4;
 Thu,  5 Nov 2026 17:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Un7zH0O67GqqWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Nov 2026 17:17:55 +0000
Date: Thu, 5 Nov 2026 18:17:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>, Li Wang <li.wang@linux.dev>,
 Martin Doucha <martin.doucha@suse.com>
Message-ID: <20261105171745.GB513115@pevik>
References: <20261020190151.9420-1-linuxtestproject.agent@gmail.com>
 <oB4QkHztnNTcZNqTMjoGQkygrRUmUoyoYwsG@localhost.localdomain>
 <20261105105023.GA459386@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105105023.GA459386@pevik>
X-Spamd-Result: default: False [-11.00 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[suse.com,gmail.com,lists.linux.it,suse.cz,linux.dev];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -11.00
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: add pwnescape reproducer
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

> Hi Andrea, all,

> I'm verifying it at least on some of SLES versions.

> FYI on 4.12 and 4.4 based SLES kernels with backported 6785011f8b16 (i.e. fixed
> kernels) the test fails:
> pwnescape.c:213: TBROK: control datagram was not forwarded back

OK, when I double checked the error was on version without the fix.

Therefore I merged your patchset with these changes:

+++ testcases/cve/pwnescape.c
@@ -21,6 +21,12 @@
  * The test loads the tun module when run as root and runs inside a
  * private network namespace so that it needs no other privileges.
  *
+ * The frames carry two VID 0 VLAN tags because the TAP driver rejects
+ * checksum metadata starting less than ``sizeof(struct iphdr)`` bytes into
+ * the frame. Without the tags the IPv4 header would start at frame offset
+ * 14, so ``csum_start`` could not point at it. With the tags it starts at
+ * offset 22.
+ *
  * [Algorithm]
  *
  * - create a TAP device with MAC 02:00:00:00:00:01, address
@@ -215,15 +221,19 @@ static void run(void)
 		tst_brk(TBROK, "control datagram IHL corrupted (%u)", ihl);
 
 	send_datagram(&test_frame, offsetof(struct pkt_frame, ip));
-	if (capture_fragment(TEST_ID, &ihl) && ihl != GOOD_IHL) {
-		tst_res(TFAIL,
-			"IPv4 header IHL corrupted by checksum completion (%u)",
+	if (!capture_fragment(TEST_ID, &ihl)) {
+		tst_res(TPASS,
+			"kernel dropped the datagram with checksum metadata inside the IPv4 header");
+		return;
+	}
+
+	if (ihl != GOOD_IHL) {
+		tst_res(TFAIL, "IPv4 header IHL corrupted by checksum completion (%u)",
 			ihl);
 		return;
 	}
 
-	tst_res(TPASS,
-		"kernel dropped the datagram with checksum metadata inside the IPv4 header");
+	tst_res(TPASS, "IPv4 header not corrupted by checksum completion");
 }
 
 static void setup(void)
@@ -242,8 +252,12 @@ static void setup(void)
 	 * namespace that owns the netns the file was opened in
 	 */
 	tap_fd = open("/dev/net/tun", O_RDWR);
-	if (tap_fd < 0)
-		tst_brk(TCONF | TERRNO, "open /dev/net/tun failed");
+	if (tap_fd == -1) {
+		if (errno == ENOENT || errno == ENODEV)
+			tst_brk(TCONF | TERRNO, "TUN support is missing");
+
+		tst_brk(TBROK | TERRNO, "open /dev/net/tun failed");
+	}
 
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy(ifr.ifr_name, TAP_NAME, IFNAMSIZ - 1);
@@ -307,6 +321,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "6785011f8b16"},
+		{"CVE", "2026-99999"},
 		{}
 	},
 };


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
