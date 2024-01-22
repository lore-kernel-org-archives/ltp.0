Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBB4C47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 18:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354E63CEF22
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 19:22:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D71F3CC7B7
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 19:22:37 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 94022601067
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 19:22:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D78EF1F396;
 Mon, 22 Jan 2024 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705947752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaVCB8+3tU2yB1N6/Gz/rGiR4N5jRqRk76Xyb+KxiJ0=;
 b=fh8fkEwxnk60U8Dt+EbI8jLFHO7WKUEAAPr8eAe8hbxxtCD3UvqwbR3LWixSgWGc2jMeX8
 YeEdQIbQAOH6DkgF+yF2d/g6v/mug+tTubdW9cw/oWnPDhZgIckOxcHcY29hY3k5uueioR
 pP2bWtp0DYbZOJxzi6l4J2lrGCv1NeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705947752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaVCB8+3tU2yB1N6/Gz/rGiR4N5jRqRk76Xyb+KxiJ0=;
 b=5R8W6+Ird1V1/xeTSg4luxrSb7gdtZmrw2O/PYxoyK4Mj1zM7hWMMrjnXIOSmqP225zqvz
 VU90mtsfyoVjMHAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705947751;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaVCB8+3tU2yB1N6/Gz/rGiR4N5jRqRk76Xyb+KxiJ0=;
 b=dKBiej0FtO2s9KhAh1heFGHai/IKxi9BNK+WlsTnxlGfaCpzJF14bcRSj902FfLIQ6vk4A
 NT38bxz9pV33kJDHuGvsRu2fbrCQ94ijTkvdNfEgn3wSmTk/7bptNhuLd55RBYKhLf4jMc
 m2zl153FfdXbuvtmZDY2c+9D/eM5Hh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705947751;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaVCB8+3tU2yB1N6/Gz/rGiR4N5jRqRk76Xyb+KxiJ0=;
 b=84pZ99Avtawlzlmunpg1wJuS1B9JU0nk9tEkCu+S4T61pOHuE+dSCFytLQDiUmFnF1yvWu
 IZ8EAAPSC5libEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8897313995;
 Mon, 22 Jan 2024 18:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z2kNHmeyrmVsIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 18:22:31 +0000
Date: Mon, 22 Jan 2024 19:22:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Pengfei Xu <pengfei.xu@intel.com>
Message-ID: <20240122182228.GA111853@pevik>
References: <cover.1704949719.git.pengfei.xu@intel.com>
 <48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com>
 <20240111100949.GA1895489@pevik>
 <ZZ/eCt9jeCNYMMff@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZ/eCt9jeCNYMMff@xpf.sh.intel.com>
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dKBiej0F;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=84pZ99Av
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.34 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_SPAM_SHORT(1.85)[0.617];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[34.79%]
X-Rspamd-Queue-Id: D78EF1F396
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] keyctl05: improve the dns_res_payload for
 boundary testing
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
Cc: Heng Su <heng.su@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu, all,

fix will be backported to stable series: 6.7, 6.6, 6.1, 5.15 and 5.10,
it's not applicable to 4.19 and 5.4 stable).

Therefore merged. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
