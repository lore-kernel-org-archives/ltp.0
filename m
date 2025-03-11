Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA055C282EC
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 21:42:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D07E03CA3EF
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 22:42:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01E0A3CA336
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 22:42:01 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CFF316002E8
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 22:41:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58B6C1F388;
 Tue, 11 Mar 2025 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741729319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s3toZruWSaFw7YvDgAvzYi1pZFYKA3g0p+Xy3IAwSo0=;
 b=XiW5MnJRVbyyOCp3EtCyhUh52V8Y8RBfh9+QpLTPRlG/s1c2ow0wBZof7RQe6wC0CHF1Xo
 Mhv+QKWPaOztb8vZHUqwings1pAdrJZjd1bGU1OGhCvjBRaT6ojPeA1XpqN9PMruFV3d4E
 Pvriw5A74XXtCcxxYKNMzZh6mkBBErM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741729319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s3toZruWSaFw7YvDgAvzYi1pZFYKA3g0p+Xy3IAwSo0=;
 b=V0bGNMuVHN0WTUCWkh+qpEtV3Gz0ODH68BRI7IMS34XReXNltqan0clnBZH2DxizJmv7RO
 1AY+ekJDcIOSvnCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XiW5MnJR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V0bGNMuV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741729319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s3toZruWSaFw7YvDgAvzYi1pZFYKA3g0p+Xy3IAwSo0=;
 b=XiW5MnJRVbyyOCp3EtCyhUh52V8Y8RBfh9+QpLTPRlG/s1c2ow0wBZof7RQe6wC0CHF1Xo
 Mhv+QKWPaOztb8vZHUqwings1pAdrJZjd1bGU1OGhCvjBRaT6ojPeA1XpqN9PMruFV3d4E
 Pvriw5A74XXtCcxxYKNMzZh6mkBBErM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741729319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s3toZruWSaFw7YvDgAvzYi1pZFYKA3g0p+Xy3IAwSo0=;
 b=V0bGNMuVHN0WTUCWkh+qpEtV3Gz0ODH68BRI7IMS34XReXNltqan0clnBZH2DxizJmv7RO
 1AY+ekJDcIOSvnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BC1F134A0;
 Tue, 11 Mar 2025 21:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ivclEieu0GdqVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Mar 2025 21:41:59 +0000
Date: Tue, 11 Mar 2025 22:41:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250311214158.GA74256@pevik>
References: <20231027174322.710674-1-pvorel@suse.cz>
 <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
 <20231030072819.GA9167@pevik>
 <CAEemH2eUQxxQAh-Ln_hyzu_C_AL36fXsjbKZJqC3rcHsASgQgQ@mail.gmail.com>
 <20231030142055.GA21733@pevik> <20250307234554.GA347736@pevik>
 <CAEemH2dRoh_NpQyXNbhKB999hGmNuca2WNr3rg23HpR598O65Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dRoh_NpQyXNbhKB999hGmNuca2WNr3rg23HpR598O65Q@mail.gmail.com>
X-Rspamd-Queue-Id: 58B6C1F388
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object
 syntax
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
Cc: ltp@lists.linux.it,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> > Finally merged :).
> > (Obviously I forgot to merge back then although I set this in patchwork as
> > accepted.)


> Well, thanks!! I'm wondering how you find this one being missed, it's been
> so long:).

Trying to tidy up messy branches in my fork :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
