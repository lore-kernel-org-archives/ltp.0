Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B675C35FF0
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 08:08:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C0483C2E14
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 10:08:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 688D63C1BD4
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:08:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 40DD51A001E8
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:08:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 274721FFB6;
 Tue, 17 Sep 2024 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726560482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=FzCSW7BckHVIoFM4nqPVATIxzoJvjfANsCz+qD1NU6oz03KVt8NG21NvysXwbo1n39/u86
 C3Dc9xFvUA/9R/L2iRtp++ngI8cs3n693+yUe2nh5sbwXlo6VthNsc9M3awAkYdJhyd4S7
 S2MZndLpi/STO5jsS09FbDneNMgzG10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726560482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=75oQ2b/21Rh8WXcOSZLm+XYl6us2zoH06ZLlLX1W4BtpTU6xTKLddYD1BwmE2oPOWEG9Jj
 IhRz3KkPj17/aOBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FzCSW7Bc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="75oQ2b/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726560482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=FzCSW7BckHVIoFM4nqPVATIxzoJvjfANsCz+qD1NU6oz03KVt8NG21NvysXwbo1n39/u86
 C3Dc9xFvUA/9R/L2iRtp++ngI8cs3n693+yUe2nh5sbwXlo6VthNsc9M3awAkYdJhyd4S7
 S2MZndLpi/STO5jsS09FbDneNMgzG10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726560482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=75oQ2b/21Rh8WXcOSZLm+XYl6us2zoH06ZLlLX1W4BtpTU6xTKLddYD1BwmE2oPOWEG9Jj
 IhRz3KkPj17/aOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D17A13AB6;
 Tue, 17 Sep 2024 08:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kmIwAuI46WaISgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Sep 2024 08:08:02 +0000
Date: Tue, 17 Sep 2024 10:06:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Message-ID: <Zuk4mkSmPti6pnuk@yuki.lan>
References: <cover.1725601646.git.nirjhar@linux.ibm.com>
 <5488fdbd9f26f1826fb083cfdbc357ac9ca954a4.1725601646.git.nirjhar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5488fdbd9f26f1826fb083cfdbc357ac9ca954a4.1725601646.git.nirjhar@linux.ibm.com>
X-Rspamd-Queue-Id: 274721FFB6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SINGLE_SHORT_PART(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] syscalls/<delete, init,
 finit>_module: Rename /proc/dummy to module specific path name
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
