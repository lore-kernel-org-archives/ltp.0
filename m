Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7781CE77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:03:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8334F3ED58F
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:03:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB6F93ED58F
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:03:38 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C6FA9652038
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:03:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A9E332115A;
 Wed, 18 Dec 2024 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WvF0938p90KlY+HTm2r26tKYHXNJQ/1srwgiwXPjtiM=;
 b=XWFvhypdR3cn29+mIXT0A1n8LxHvzLGO7tQ3bs9ki6pjEa23552MHCVZM9nMwV3ZcbSTm6
 wRpmwukt9WSw4KVEJ3LISq1qbtqYl8E/oUDa1p5rdtp533L3gEO8vja7oBdGkiTji+EsPa
 DM1PVMHpZ1afS33uZkA03JP9awsH7Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WvF0938p90KlY+HTm2r26tKYHXNJQ/1srwgiwXPjtiM=;
 b=tx4srOXZHwFYsH6ybjRcnfagRXFQQrlivKzB/CL1jvWMqSh78mnBJSd1/FuHLczztMRFdw
 7sINOAeiYqBdqwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WvF0938p90KlY+HTm2r26tKYHXNJQ/1srwgiwXPjtiM=;
 b=XWFvhypdR3cn29+mIXT0A1n8LxHvzLGO7tQ3bs9ki6pjEa23552MHCVZM9nMwV3ZcbSTm6
 wRpmwukt9WSw4KVEJ3LISq1qbtqYl8E/oUDa1p5rdtp533L3gEO8vja7oBdGkiTji+EsPa
 DM1PVMHpZ1afS33uZkA03JP9awsH7Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WvF0938p90KlY+HTm2r26tKYHXNJQ/1srwgiwXPjtiM=;
 b=tx4srOXZHwFYsH6ybjRcnfagRXFQQrlivKzB/CL1jvWMqSh78mnBJSd1/FuHLczztMRFdw
 7sINOAeiYqBdqwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 562EE132EA;
 Wed, 18 Dec 2024 19:03:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O3thDogcY2eldgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Dec 2024 19:03:36 +0000
Date: Wed, 18 Dec 2024 20:03:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241218190334.GB75387@pevik>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-7-e293a8d99cf6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112-lsm-v1-7-e293a8d99cf6@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] Add lsm_set_self_attr01 test
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

Hi Andrea,

> Verify that lsm_set_self_attr syscall is raising errors when invalid
> data is provided.

As I wrote at 2nd patch [1], booting with lsm= breaks all but
lsm_list_modules0[12].c. E.g. in this patch:

# ./lsm_set_self_attr01
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:1893: TINFO: LTP version: 20240930-146-gccd20cd77
tst_test.c:1897: TINFO: Tested kernel: 6.10.0-rc7-3.g92abc10-default #1 SMP PREEMPT_DYNAMIC Wed Jul 10 14:15:11 UTC 2024 (92abc10) x86_64
tst_test.c:1728: TINFO: Timeout per run is 0h 00m 30s
lsm_common.h:51: TINFO: selinux is running
lsm_common.h:51: TINFO: apparmor is running
lsm_common.h:51: TINFO: smack is running
lsm_set_self_attr01.c:110: TBROK: Can't read LSM current attribute

FYI lsm= bot parameter causes setup (at least on Tumbleweed kernel config):
$ cat /sys/kernel/security/lsm
lockdown,capability,ima,evm

Kind regards,
Petr

[2] https://lore.kernel.org/ltp/20241218185508.GA77804@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
