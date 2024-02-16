Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4988EC48260
	for <ltp@archiver.kernel.org>; Fri, 16 Feb 2024 12:13:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5AED3D0DED
	for <ltp@archiver.kernel.org>; Fri, 16 Feb 2024 13:13:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC3A93C06DF
 for <ltp@lists.linux.it>; Fri, 16 Feb 2024 13:12:49 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E776F206C43
 for <ltp@lists.linux.it>; Fri, 16 Feb 2024 13:12:48 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EF231FB68;
 Fri, 16 Feb 2024 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708085567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWDwi0l6syuVcdiNqDE+sBz4A2r6dnmKg5eCCYBSfmc=;
 b=e8+NeFco+Q6uP33OvxOAdig8NF0zkH47fByhKjhVV8FHEkXij2wgFjPBMHaKde3IOmp6l4
 5reDgu88GoGtewRxBVgTSnMFCTNl3fJUUSPlzziWROEXQB96HDt2Bb/NcSLTfwR+IqmpNb
 +Ndfm8FEcCDzUvXw03Txt2uXFK9v8qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708085567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWDwi0l6syuVcdiNqDE+sBz4A2r6dnmKg5eCCYBSfmc=;
 b=+ZimcCiw3UFiNM0s07Cm+xzLe/+IjwQgfanQ1NUy9Z6zql3q02cbLdpDGTX8xWX1uxYs71
 8y7pj+eSInkP+hCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708085567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWDwi0l6syuVcdiNqDE+sBz4A2r6dnmKg5eCCYBSfmc=;
 b=e8+NeFco+Q6uP33OvxOAdig8NF0zkH47fByhKjhVV8FHEkXij2wgFjPBMHaKde3IOmp6l4
 5reDgu88GoGtewRxBVgTSnMFCTNl3fJUUSPlzziWROEXQB96HDt2Bb/NcSLTfwR+IqmpNb
 +Ndfm8FEcCDzUvXw03Txt2uXFK9v8qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708085567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWDwi0l6syuVcdiNqDE+sBz4A2r6dnmKg5eCCYBSfmc=;
 b=+ZimcCiw3UFiNM0s07Cm+xzLe/+IjwQgfanQ1NUy9Z6zql3q02cbLdpDGTX8xWX1uxYs71
 8y7pj+eSInkP+hCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AEFB13343;
 Fri, 16 Feb 2024 12:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 1lChHD9Rz2VUHQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 16 Feb 2024 12:12:47 +0000
Date: Fri, 16 Feb 2024 13:12:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
Message-ID: <20240216121241.GD903763@pevik>
References: <20231106093031.1844129-1-liwang@redhat.com>
 <20231106093031.1844129-4-liwang@redhat.com>
 <20240216120120.GB903763@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240216120120.GB903763@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.46 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.16)[88.78%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] hugemmap34: Test to detect bug with
 migrating gigantic pages
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

> Hi Li,

> FYI hugemmap34 fails on x86_64 and s390x various SLES kernels (tested: x86_64
> from 4.4 to 6.4, s390x from 4.12. to 6.4):

Also Tumbleweed with 6.8.0-rc4 fails

hugemmap34.c:85: TBROK: mmap() failed: EINVAL (22)

(no code modification - with MAP_HUGE_1GB).
But in CI I reproduced also tst_hugepage.c:119: TCONF: nr_hugepages = 0, but
expect 2. Not enough hugepages for testing.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
