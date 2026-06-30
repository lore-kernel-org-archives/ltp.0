Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAB1C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:18:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 784833E222C
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 12:18:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695EC3C0F6F
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:18:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2133060215C
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:18:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F275275ABF;
 Tue, 30 Jun 2026 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782814711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=By8RH8Y2c++8vx2zCCfUkh14EALMcOJsnesL5Gq33NI=;
 b=oa5ZDRGocpj8v4+lQ8xwS7balAP/WrpRAM2bhU0E79RqKr8cVVs6covV9s6TzBrMJqZrQN
 +LAlLeMdalyDCT1OPSqpMdIIzWQCSLEmtFKisEgXwuDS5/9BFEHObNeWgJT7s6SPMG5N9l
 U/KmTg2tPpzFD7URGDn3G0jdhz/hiGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782814711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=By8RH8Y2c++8vx2zCCfUkh14EALMcOJsnesL5Gq33NI=;
 b=2HiEd3+dq2SfEZNHdXG5auBA4HIctroXmKg8K43OXlIskqp62BVubk74uV+2YRgC1jTupv
 c4TAADP08IHmptBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oa5ZDRGo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2HiEd3+d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782814711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=By8RH8Y2c++8vx2zCCfUkh14EALMcOJsnesL5Gq33NI=;
 b=oa5ZDRGocpj8v4+lQ8xwS7balAP/WrpRAM2bhU0E79RqKr8cVVs6covV9s6TzBrMJqZrQN
 +LAlLeMdalyDCT1OPSqpMdIIzWQCSLEmtFKisEgXwuDS5/9BFEHObNeWgJT7s6SPMG5N9l
 U/KmTg2tPpzFD7URGDn3G0jdhz/hiGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782814711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=By8RH8Y2c++8vx2zCCfUkh14EALMcOJsnesL5Gq33NI=;
 b=2HiEd3+dq2SfEZNHdXG5auBA4HIctroXmKg8K43OXlIskqp62BVubk74uV+2YRgC1jTupv
 c4TAADP08IHmptBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAEB8779A8;
 Tue, 30 Jun 2026 10:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fTABLPaXQ2qOAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jun 2026 10:18:30 +0000
Date: Tue, 30 Jun 2026 12:18:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260630101825.GA426574@pevik>
References: <20260417022949.2881047-1-zhanghongtao35@huawei.com>
 <6a437fbe.f31388b9.243dab.4184@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a437fbe.f31388b9.243dab.4184@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F275275ABF
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tpci: Unbind/rebind driver in
 test_assign_resources()
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
Cc: bhelgaas@google.com, liuyongqiang13@huawei.com,
 Hongtao Zhang via ltp <ltp@lists.linux.it>, krzysztof.kozlowski@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Merged after reducing the verbosity of the commit message.
> Thanks!

Hongtao Zhang, thanks for the fix.

> +			if (ret == 0) {
> +				if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {

FYI this could have been in single if, I fixed that in a follow up commit.
https://github.com/linux-test-project/ltp/commit/f7a5c86b648ca05402082e7a9136c85bb25d002c

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
