Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B64C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 11:35:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A92473D3930
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 13:35:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F36153D0F08
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 13:35:36 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09534200A00
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 13:35:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C678B219FD;
 Tue,  9 Jul 2024 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720524934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pty5i4oH3B7W1yCDigbZ5kpY08wzP2MBoM9j+7XpOX8=;
 b=rSaFgFPiHlJzQfF5opNmUDchjkuXtl6jjDQ46wPGD6woarNAdD0HhFI28FIhg3p7+ycOqB
 GPyXHDKmX+EGQtkZdIT06K3B6Aae1ZnO5MTFVnVwBM9sQ9Uy/qxV50qNh1ZCuquy2s0Kfr
 lur5Cf7/n3AlaYs4evv8Q+GCqnDO4dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720524934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pty5i4oH3B7W1yCDigbZ5kpY08wzP2MBoM9j+7XpOX8=;
 b=/74ojIJu3LDAevnXPQbr5bONfBLTXkm+vES2nEwWPiQ4IDXtZ4F6qVL1edv0tqCORPgFfq
 NS5t3BQ258TfWXAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720524934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pty5i4oH3B7W1yCDigbZ5kpY08wzP2MBoM9j+7XpOX8=;
 b=rSaFgFPiHlJzQfF5opNmUDchjkuXtl6jjDQ46wPGD6woarNAdD0HhFI28FIhg3p7+ycOqB
 GPyXHDKmX+EGQtkZdIT06K3B6Aae1ZnO5MTFVnVwBM9sQ9Uy/qxV50qNh1ZCuquy2s0Kfr
 lur5Cf7/n3AlaYs4evv8Q+GCqnDO4dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720524934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pty5i4oH3B7W1yCDigbZ5kpY08wzP2MBoM9j+7XpOX8=;
 b=/74ojIJu3LDAevnXPQbr5bONfBLTXkm+vES2nEwWPiQ4IDXtZ4F6qVL1edv0tqCORPgFfq
 NS5t3BQ258TfWXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B743D1396E;
 Tue,  9 Jul 2024 11:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pdu7K4YgjWZoZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jul 2024 11:35:34 +0000
Date: Tue, 9 Jul 2024 13:35:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zo0gfRp0MblEL_oq@yuki>
References: <20240709103324.183993-1-pvorel@suse.cz> <Zo0ZiWT01NFENPaz@yuki>
 <20240709111847.GA198566@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240709111847.GA198566@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test: Fix tests using device without
 .filesystems
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
> > +       fs = fs ? &dummy : fs;

This is a stupid typo, it should be fs = fs ? fs : &dummy instead.

> This looks more elegant, but I get coredump.
> I also think you need to have count_fs_descs() <= 1 and maybe define fs_type
> (not sure about it).

You need count_fs_descs() <= 1 but the fs type is used from the
tst_device structure instead. So the whole patch should be:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b49c248ae..c6ed5d562 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1101,6 +1101,9 @@ static void prepare_device(struct tst_fs *fs)
 {
        const char *mnt_data;
        char buf[1024];
+       struct tst_fs dummy = {};
+
+       fs = fs ? fs: &dummy;

        const char *const extra[] = {fs->mkfs_size_opt, NULL};

@@ -1355,8 +1358,8 @@ static void do_setup(int argc, char *argv[])

                tdev.fs_type = default_fs_type();

-               if (!tst_test->all_filesystems && count_fs_descs() == 1)
-                       prepare_device(&tst_test->filesystems[0]);
+               if (!tst_test->all_filesystems && count_fs_descs() <= 1)
+                       prepare_device(tst_test->filesystems);
        }

        if (tst_test->needs_overlay && !tst_test->mount_device)



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
