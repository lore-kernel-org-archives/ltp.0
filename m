Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6962C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 17:38:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CC443CF919
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:38:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D905F3CE182
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 18:38:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39A3B14103A4
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 18:38:42 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 192841FB8E;
 Wed, 31 Jan 2024 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706722722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZuAmIQGw5zF3eZhj/Dvlnw7yglVdpHHuSSIThkoFMEU=;
 b=yUPSzttaf4nuH2+zURYr8Thh/Nmtne6f+PZ7oYjLhhFYLW4oH8RruPxo5/hxyCcmFAhTNC
 5a2PQXrMbrP8dOogVEDA0HK1bic4fd3XxyW14ufIpDe4F2z0XLrKC+vYM7qAPAYDu3Ue1h
 jFX2mzCj+ZCNRGHrnco3U11X66Fyw6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706722722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZuAmIQGw5zF3eZhj/Dvlnw7yglVdpHHuSSIThkoFMEU=;
 b=0FDTF/Tj6ZgasAwg6hqVqRJcxU2gQThi+pLSqri3FxAoEwDLV92JJoFBFZd4ep4E3S6atV
 E0/2TfSRm50WxFDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706722722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZuAmIQGw5zF3eZhj/Dvlnw7yglVdpHHuSSIThkoFMEU=;
 b=yUPSzttaf4nuH2+zURYr8Thh/Nmtne6f+PZ7oYjLhhFYLW4oH8RruPxo5/hxyCcmFAhTNC
 5a2PQXrMbrP8dOogVEDA0HK1bic4fd3XxyW14ufIpDe4F2z0XLrKC+vYM7qAPAYDu3Ue1h
 jFX2mzCj+ZCNRGHrnco3U11X66Fyw6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706722722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZuAmIQGw5zF3eZhj/Dvlnw7yglVdpHHuSSIThkoFMEU=;
 b=0FDTF/Tj6ZgasAwg6hqVqRJcxU2gQThi+pLSqri3FxAoEwDLV92JJoFBFZd4ep4E3S6atV
 E0/2TfSRm50WxFDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E92C7132FA;
 Wed, 31 Jan 2024 17:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id GnRqNqGFumX0GwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 17:38:41 +0000
Date: Wed, 31 Jan 2024 18:38:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240131173840.GA18869@pevik>
References: <20240131102514.2739270-1-liwang@redhat.com>
 <20240131102514.2739270-8-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240131102514.2739270-8-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yUPSztta;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0FDTF/Tj"
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[41.89%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 192841FB8E
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap
 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

LGTM

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Although get on all VMs due low memory:

tst_test.c:1091: TCONF: No enough memory for tmpfs use

instead of
libswap.c:202: TCONF: Swapfile on tmpfs not implemented

I would also suggest to print who much memory is needed, e.g.:

diff --git lib/tst_test.c lib/tst_test.c
index edb42f7f4..151c6acca 100644
--- lib/tst_test.c
+++ lib/tst_test.c
@@ -1088,7 +1088,8 @@ static const char *limit_tmpfs_mount_size(const char *mnt_data,
 		tmpfs_size = tdev.size;
 
 	if ((tst_available_mem() / 1024) < (tmpfs_size * 2))
-		tst_brk(TCONF, "No enough memory for tmpfs use");
+		tst_brk(TCONF, "No enough memory for tmpfs use (%d MB < %d MB)",
+				tst_available_mem() / 1024, tmpfs_size * 2);
 
 	if (mnt_data)
 		snprintf(buf, buf_size, "%s,size=%uM", mnt_data, tmpfs_size);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
