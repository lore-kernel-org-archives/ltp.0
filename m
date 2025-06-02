Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DCEC54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 17:09:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 301FA3C9DE7
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 19:09:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 577CB3C9A81
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 19:08:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B3F851000CE6
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 19:08:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A67F2123F;
 Mon,  2 Jun 2025 17:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748884121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pruoClOYZfMQB/3oJefvIGXqq5kgb7rbKC9HbpL2KQM=;
 b=HQwqSJPkxgSe+gC2pqq66LPZ6UXz8KnjfupAwOKhtevkxArtrAuO3IirYDCSk/jE7AAirR
 /e6xL9/OZ8AmSY6ENVYX96HBnPUoUSIdgAjr1MjNA1KicRQnGI9YNAgGqA7Xb9ulPhdHRf
 69USVDaJHBZMfGJtIq3AcvNgs85DfAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748884121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pruoClOYZfMQB/3oJefvIGXqq5kgb7rbKC9HbpL2KQM=;
 b=mDSdPn+TL5my29icl3AAuptQe9yQiFCnCu0mfMzz0zgV/ZqrF/qHSv9j5+/F9lYQOc2eqN
 XMyzye86tP2s5sAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748884121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pruoClOYZfMQB/3oJefvIGXqq5kgb7rbKC9HbpL2KQM=;
 b=HQwqSJPkxgSe+gC2pqq66LPZ6UXz8KnjfupAwOKhtevkxArtrAuO3IirYDCSk/jE7AAirR
 /e6xL9/OZ8AmSY6ENVYX96HBnPUoUSIdgAjr1MjNA1KicRQnGI9YNAgGqA7Xb9ulPhdHRf
 69USVDaJHBZMfGJtIq3AcvNgs85DfAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748884121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pruoClOYZfMQB/3oJefvIGXqq5kgb7rbKC9HbpL2KQM=;
 b=mDSdPn+TL5my29icl3AAuptQe9yQiFCnCu0mfMzz0zgV/ZqrF/qHSv9j5+/F9lYQOc2eqN
 XMyzye86tP2s5sAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01D3C13A63;
 Mon,  2 Jun 2025 17:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EBkML5faPWgZHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Jun 2025 17:08:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  2 Jun 2025 19:08:31 +0200
Message-ID: <20250602170831.404641-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602170831.404641-1-pvorel@suse.cz>
References: <20250602170831.404641-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lapi/mount.h: Add missing mnt_ns_id member
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

It was added 09b31295f8330 ("fs: export the mount ns id via statmount")
in v6.10-rc1. It also added STATMOUNT_MNT_NS_ID definition, but that's
not needed yet.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Not needed for the fix (it can wait).

 include/lapi/mount.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index aea6bca77a..daca14e551 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -51,6 +51,7 @@ struct mnt_id_req {
 	uint32_t spare;
 	uint64_t mnt_id;
 	uint64_t param;
+	uint64_t mnt_ns_id;
 };
 #endif
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
