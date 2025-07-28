Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A40C87FC9
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 15:37:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8223C925B
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 17:37:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EA993C68DA
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 17:36:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C1F681400554
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 17:36:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D39341F441;
 Mon, 28 Jul 2025 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753717005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e92Fug2fMAO1QnBwX8wPtpsMsQWwf9vdiuvNU4AqfgE=;
 b=1cIYkRPOYzq4yZMbbAm6b2jkBpUnCSbY87NAolPzW8wnqzFQVFZ6lrjO7E7xQF5U9Dt7hR
 VR45k23bH0z89iAaY8qq/y4OfoApVj27KmZuZniRzW527h5QXRNFgJQVDXH1oMK/18MQoY
 7A1ZzzW9nEaQNw/jG4YIG0XyvRWxGE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753717005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e92Fug2fMAO1QnBwX8wPtpsMsQWwf9vdiuvNU4AqfgE=;
 b=3zeKGqeuJg7qYWxJuHvwq/2fR3AtzhwwX2vm44lSXj2dMJGxSPk62P18cgDy+6WBtPciDF
 qFK3Dlll/BbTRrAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753717004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e92Fug2fMAO1QnBwX8wPtpsMsQWwf9vdiuvNU4AqfgE=;
 b=IyzEVtF2TQ0KBYuwJSP0jG1DrkeiHFOSC2XElaRW1wv1k1CjM+mL0aMguInvqTFcsOM6MJ
 M0oyfuBzf219BrnTEc8FpDe6nIes7Ee+zE5MrQajJEKDGgk9A3pYLe2ztvnRP8FZIz3ZlP
 LCB2STpnuosuA+OoBJXkqViU7YoISL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753717004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e92Fug2fMAO1QnBwX8wPtpsMsQWwf9vdiuvNU4AqfgE=;
 b=Gr8Lh0TNVQT7rGT+Pv8GZNVUazaVgQHzPVhvC18VZir+3/aYHYjy7KOgn39dltrpeeYOFT
 IQxFWXabzqM3W8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4E181368A;
 Mon, 28 Jul 2025 15:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gXA7LwyZh2ioKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 28 Jul 2025 15:36:44 +0000
Date: Mon, 28 Jul 2025 17:37:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aIeZOpdFQ4KLRzsH@yuki.lan>
References: <20250319114144.24349-1-wegao@suse.com>
 <20250724134052.568308-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250724134052.568308-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mount_setattr02.c: Check mount_setattr attr
 propagation
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
Pushed with some changes, thanks.


- We have to move the SAFE_UMOUNT(tmpdir) to the run() otherwise the test
  fails to cleanup() with -i 2

- Make sure that the slavedir was mounted shared before making it slave

- Minor adjustenment to the test description

diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
index 640778f7c..bb246ed10 100644
--- a/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
@@ -5,7 +5,7 @@

 /*\
  * This test is checking if the propagation field of the
- * structure is handled properly.
+ * mount_attr structure is handled properly.
  *
  * - EINVAL with propagation set to -1
  * - When propagation is set to 0 it's not changed
@@ -68,10 +68,8 @@ static bool check_mount_type(const char *path, enum mount_type type_to_check)

 static void cleanup(void)
 {
-       if (mounted) {
-               SAFE_UMOUNT(slavedir);
+       if (mounted)
                SAFE_UMOUNT(tmpdir);
-       }
 }

 static void setup(void)
@@ -109,9 +107,11 @@ static void run(void)

        attr.propagation = MS_SLAVE;
        SAFE_MOUNT(tmpdir, slavedir, "none", MS_BIND, NULL);
+       TST_EXP_EQ_LI(check_mount_type(slavedir, MOUNT_TYPE_SHARED), 1);
        TST_EXP_PASS_SILENT(mount_setattr(-1, slavedir, 0, &attr, sizeof(attr)));
        TST_EXP_EQ_LI(check_mount_type(slavedir, MOUNT_TYPE_MASTER), 1);
        TST_EXP_EQ_LI(check_mount_type(slavedir, MOUNT_TYPE_SHARED), 0);
+       SAFE_UMOUNT(slavedir);

        attr.propagation = MS_PRIVATE;
        TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
