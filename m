Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2892CC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 14:05:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AFA23CE41F
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 15:05:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 985913C80F6
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 15:05:39 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EECD91001265
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 15:05:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20A2A21F49;
 Thu, 11 Jan 2024 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704981937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnnpKqbQulcezH1sSqC8YGoJTprF9iSRIFkHOMZEhsQ=;
 b=r6zgnUywKzK8kVF/WLdXjJTjXrmUmJCVQtezxFm20Pi64udJu0uUzDlM9b05hCISrgViKI
 EIfgLfAe/gabN43bZ9dQAbl6K3wjwlVebsLt20KrYcrQDsIfNHpIoCbYo4Va+W5YANbw4N
 pQaXSKnI8cjcCJkLE937/LccDKG5Nic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704981937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnnpKqbQulcezH1sSqC8YGoJTprF9iSRIFkHOMZEhsQ=;
 b=2j6W/8fY8roa5n6UTWHr+PBk+oMv3EfSjNGmJXlN3FGs982SuLi1Mu7RNDhVLz9FIF5Re8
 L2txLcOzxxFTKaBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704981937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnnpKqbQulcezH1sSqC8YGoJTprF9iSRIFkHOMZEhsQ=;
 b=r6zgnUywKzK8kVF/WLdXjJTjXrmUmJCVQtezxFm20Pi64udJu0uUzDlM9b05hCISrgViKI
 EIfgLfAe/gabN43bZ9dQAbl6K3wjwlVebsLt20KrYcrQDsIfNHpIoCbYo4Va+W5YANbw4N
 pQaXSKnI8cjcCJkLE937/LccDKG5Nic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704981937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnnpKqbQulcezH1sSqC8YGoJTprF9iSRIFkHOMZEhsQ=;
 b=2j6W/8fY8roa5n6UTWHr+PBk+oMv3EfSjNGmJXlN3FGs982SuLi1Mu7RNDhVLz9FIF5Re8
 L2txLcOzxxFTKaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BA1913635;
 Thu, 11 Jan 2024 14:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5pu6ArH1n2WuOQAAD6G6ig
 (envelope-from <pvorel@suse.de>); Thu, 11 Jan 2024 14:05:37 +0000
MIME-Version: 1.0
Date: Thu, 11 Jan 2024 15:05:36 +0100
From: pvorel <pvorel@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>, Jan Stancek
 <jstancek@redhat.com>, Xiao Yang <yangx.jy@fujitsu.com>, Yang Xu
 <xuyang2018.jy@fujitsu.com>
In-Reply-To: <ZZvK9OL6MduUpWZQ@yuki>
References: <20231207194011.273027-1-pvorel@suse.cz> <ZZvK9OL6MduUpWZQ@yuki>
User-Agent: Roundcube Webmail
Message-ID: <067cf38108dd5b088168628d569f79c1@suse.de>
X-Sender: pvorel@suse.de
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r6zgnUyw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="2j6W/8fY"
X-Spamd-Result: default: False [-5.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; BAYES_HAM(-2.99)[99.95%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[lists.linux.it,linux.dev,redhat.com,vger.kernel.org,gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 20A2A21F49
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] ENODEV on bcachefs on kernel < 6.7 [was: Re: [PATCH v2 0/3]
 Add support bcachefs filesystem]
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
Cc: Jan Kara <jack@suse.cz>, Brian Foster <bfoster@redhat.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I'm sorry I haven't tested LTP with bcachefs-tools and kernel < 6.7. 
Quite a lot of tests fails:

# LTP_SINGLE_FS_TYPE=bcachefs ./chdir01
tst_buffers.c:56: TINFO: Test is using guarded buffers
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1709: TINFO: LTP version: 20230929-269-g958402a95
tst_test.c:1593: TINFO: Timeout per run is 0h 00m 30s
tst_supported_fs_types.c:151: TINFO: WARNING: testing only bcachefs
tst_supported_fs_types.c:122: TINFO: FUSE does support bcachefs
tst_supported_fs_types.c:57: TINFO: mkfs.bcachefs does exist
tst_test.c:1669: TINFO: === Testing on bcachefs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with bcachefs opts='' 
extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to 
/tmp/LTP_chdwqhGtZ/mntpoint fstyp=bcachefs flags=0
tst_test.c:1131: TBROK: mount(/dev/loop0, mntpoint, bcachefs, 0, (nil)) 
failed: ENODEV (19)

Library fails on safe_mount(). I wonder if we should check for kernel >= 
6.7 in case of bcachefs, or if we should return 0 in safe_mount() in 
case of bcachefs and errno == ENODEV (and possibly kernel < 6.7).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
