Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C7AEED613
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 15:09:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A8503C2693
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 17:09:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CD583C2646
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 17:08:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA5141400268
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 17:08:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1CCBA21B01;
 Thu, 12 Sep 2024 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726153723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ON484IpOwp05US8JW2ABwxiggPNLDl61yaqBUgW/7q8=;
 b=tUIJL0ULZB2j8BHM/RgOdO6N7LqbqLa8dRbhUs0eu26etBNtuV2OnZmEHN7kxjtOFc9Yup
 iTPbknVGcmjcWVy0MX2anxk+A/PEBD6NdGovY/OU9z4bqolnRgY1GGynrtcJr2Lj/Dh/em
 hELbZdTBYe5Fz31voubgLrIwGzzFVfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726153723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ON484IpOwp05US8JW2ABwxiggPNLDl61yaqBUgW/7q8=;
 b=kyRNtH6moar/ok/LR5mh2XaygIJbKcG6/IfvVrZJvBL8KQ2YMgQk9oOAu6kZWQF58ej/am
 hqvsKzteojD4VGDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tUIJL0UL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kyRNtH6m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726153723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ON484IpOwp05US8JW2ABwxiggPNLDl61yaqBUgW/7q8=;
 b=tUIJL0ULZB2j8BHM/RgOdO6N7LqbqLa8dRbhUs0eu26etBNtuV2OnZmEHN7kxjtOFc9Yup
 iTPbknVGcmjcWVy0MX2anxk+A/PEBD6NdGovY/OU9z4bqolnRgY1GGynrtcJr2Lj/Dh/em
 hELbZdTBYe5Fz31voubgLrIwGzzFVfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726153723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ON484IpOwp05US8JW2ABwxiggPNLDl61yaqBUgW/7q8=;
 b=kyRNtH6moar/ok/LR5mh2XaygIJbKcG6/IfvVrZJvBL8KQ2YMgQk9oOAu6kZWQF58ej/am
 hqvsKzteojD4VGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0140C13AD8;
 Thu, 12 Sep 2024 15:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IAl5OPoD42ZSEgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 12 Sep 2024 15:08:42 +0000
Date: Thu, 12 Sep 2024 17:07:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: spoorthy s <spoorthy@linux.ibm.com>
Message-ID: <ZuMDuSqnzRCfmV6d@yuki.lan>
References: <49b1dbd9-4c51-414a-806c-1d5cc6b5e1c7@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49b1dbd9-4c51-414a-806c-1d5cc6b5e1c7@linux.ibm.com>
X-Rspamd-Queue-Id: 1CCBA21B01
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs shm-perms
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void compare_free_hugepage_memory(long free_end, long free_start)
> +{
> +=A0=A0=A0 if (free_end !=3D free_start)
> +=A0=A0=A0 =A0=A0=A0 tst_res(TFAIL, "Free hugepages after attaching multi=
ple threads =

> differ from initial allocation");

This line and couple of other lines are corrupted by the mail client you
have used.

There may be some hints on how to fix that at:

https://www.kernel.org/doc/html/next/process/email-clients.html

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
