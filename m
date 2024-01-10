Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96322C47073
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 17:59:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEE293CE4F2
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 18:59:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C24853C2674
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 18:59:37 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 39F661A007E5
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 18:59:36 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A61ED222B2;
 Wed, 10 Jan 2024 17:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704909483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/wzPaeWBHWMKlwcls44EOJXdWO/Vw7KrHidfljdwdJs=;
 b=UerlZwEr/VT41tzeM27bBYXASB3i7U0/PYHk1K/jWyhbqa8IfNQIoSlgjh8d1X3EKkIyZm
 sO9zgqnBgBoKRwVTfsCfGjekyCybqW87M6QfrIEA894HNFxgSozMyFZ0Db4+tarTdQQUQb
 AMcklFyz9LTfBFs79/exGUDOkP93+5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704909483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/wzPaeWBHWMKlwcls44EOJXdWO/Vw7KrHidfljdwdJs=;
 b=+wi9X1mIYcpua8wEs1Wi9YNpO8LVjZYDI2dUihZbHImCpmYdNxiDy6KDyPD5owsXCvWEPz
 Dh9s43F1CBt2B0CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704909483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/wzPaeWBHWMKlwcls44EOJXdWO/Vw7KrHidfljdwdJs=;
 b=UerlZwEr/VT41tzeM27bBYXASB3i7U0/PYHk1K/jWyhbqa8IfNQIoSlgjh8d1X3EKkIyZm
 sO9zgqnBgBoKRwVTfsCfGjekyCybqW87M6QfrIEA894HNFxgSozMyFZ0Db4+tarTdQQUQb
 AMcklFyz9LTfBFs79/exGUDOkP93+5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704909483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/wzPaeWBHWMKlwcls44EOJXdWO/Vw7KrHidfljdwdJs=;
 b=+wi9X1mIYcpua8wEs1Wi9YNpO8LVjZYDI2dUihZbHImCpmYdNxiDy6KDyPD5owsXCvWEPz
 Dh9s43F1CBt2B0CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DF328139C6;
 Wed, 10 Jan 2024 17:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id QMlAL6ranmUAFgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 17:58:02 +0000
Date: Wed, 10 Jan 2024 18:59:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Pengfei Xu <pengfei.xu@intel.com>
Message-ID: <20240110175931.GA1766165@pevik>
References: <cover.1704868967.git.pengfei.xu@intel.com>
 <f60daf00d0de49e54a5389c73c90994e7711a7d1.1704868967.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f60daf00d0de49e54a5389c73c90994e7711a7d1.1704868967.git.pengfei.xu@intel.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UerlZwEr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+wi9X1mI
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[38.80%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A61ED222B2
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] keyctl05: increase dns_res_payload data
 due to kernel code changes
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

Hi Xu,

Good catch, merged.

BTW any change how to trigger autoload of dns_resolver ?

# ./keyctl05
...
keyctl05.c:99: TCONF: kernel doesn't support key type 'dns_resolver'
...

# modprobe dns_resolver
# ./keyctl05
...
keyctl05.c:143: TPASS: updating 'dns_resolver' key expectedly failed with EOPNOTSUPP
...

We consider modprobe as the last result.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
