Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4620BD767D8
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 15:31:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69A223CC2C2
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 16:31:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C8EF3CC279
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 16:31:20 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D732514291B5
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 16:31:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC5521FF49;
 Thu, 31 Oct 2024 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730388679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhiPibr/8+/+yQf6I10Ict+pV92i7u/AJtgEwTUj148=;
 b=R7i7lzyeYVpEUaPJGq+D6pi1Dua3hIRJ7FhjJyjuTdNXzmDEbMWHthSUrYI82gpnACIzM7
 16km5s0rzkfbBBnexqRKNHRe8eyMtvu99BGuPYf5ibOgP9iTAaofik6etr2Ge74mJFgpEY
 DoTQQ1wE0a51GIUdBJfj8m+DGx+Tpnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730388679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhiPibr/8+/+yQf6I10Ict+pV92i7u/AJtgEwTUj148=;
 b=JcGx7gYh/C9sqCKyansw7G1iSMjBi0oL56Iv+cEW3VY1TS3xQVtqg8fssNvY1mcL25KEK/
 FSMyZqruHNJiAiDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dqxnnGz0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="X/YfoiYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730388677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhiPibr/8+/+yQf6I10Ict+pV92i7u/AJtgEwTUj148=;
 b=dqxnnGz0PwVNwoWmHpi9r3dpkk3PftIX3juRYtODkl0flomtY0lv4ocl/ebN9+bX+PDTDf
 3gWmwQZS+WOTO9A6VexHNeHu/4iguASRlMC3uUUXF0NQ5X5oDQffEtQBdN3H6ZCpvMkL5X
 lc2tQXFAp0YNS1UvufVtbbcmFSs0YJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730388677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhiPibr/8+/+yQf6I10Ict+pV92i7u/AJtgEwTUj148=;
 b=X/YfoiYZ9B493ROshd6AmnhcGCyVSg4RubrkuUqtGEmRk4I3qUTKNXLgFMWP2pPVgqM161
 6991P9F1/goKPcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5751136A5;
 Thu, 31 Oct 2024 15:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r/r7M8WiI2faIgAAD6G6ig
 (envelope-from <pvorel@suse.de>); Thu, 31 Oct 2024 15:31:17 +0000
MIME-Version: 1.0
Date: Thu, 31 Oct 2024 16:31:17 +0100
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <bf896dde-ba72-4db3-8355-92e600f1dd43@suse.com>
References: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
 <20241031-generate_syscalls-v7-2-f3e26c06814e@suse.com>
 <20241031135814.GB1049242@pevik>
 <bf896dde-ba72-4db3-8355-92e600f1dd43@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <522e58298e53ce6cec96d9a10df4f63a@suse.de>
X-Sender: pvorel@suse.de
X-Rspamd-Queue-Id: DC5521FF49
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] Add script to generate arch(s) dependant
 syscalls
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2024-10-31 15:52, Andrea Cervesato wrote:
> The kernel doesn't need to be compiled. That's done by the script via
> `make headers` command. I don't know why that is happening honestly.
> 
> On 10/31/24 14:58, Petr Vorel wrote:
>> That fails in generate_table on:
>> if [ $bits == 32 ]; then
> 
> That's because the right syntax should be (for bash):
> 
> if [[ "$bits" == "32" ]]; then

Ah, I should have caught this, I overlooked an obvious bashism. thanks 
for finding the problem.

I actually run checkbashisms before, but only when run with -f finds a 
problems:

$ checkbashisms -f include/lapi/syscalls/generate_arch.sh
possible bashism in include/lapi/syscalls/generate_arch.sh line 73 
(should be 'b = a'):
	if [ $bits == 32 ]; then
possible bashism in include/lapi/syscalls/generate_arch.sh line 83 
(should be >word 2>&1):
	gcc ${TEMP}/list-syscalls.c -U__LP64__ -U__ILP32__ -U__i386__ \
		-D${uppercase_arch} \
		-D__${arch}__ ${extraflags} \
		-I ${LINUX_HEADERS}/usr/include/ \
		-o ${TEMP}/list-syscalls &>/dev/null
possible bashism in include/lapi/syscalls/generate_arch.sh line 116 
(should be >word 2>&1):
	make -s -C ${KERNELSRC} ARCH=${arch} O=${LINUX_HEADERS} \
		headers_install &>/dev/null

"&>" is yet another bashism.

Ideally, not only checking with "checkbashisms -f", but also running 
script with dash (e.g. change shebang to #!/bin/dash) should catch most 
of the problems.


> 
> But in other shells sh compatible, probably I should use:
> 
> if [ "$bits" -eq "32" ]; then

Yes please.

> 
> 
> I'm gonna fix this.

Thanks a lot!

Kind regards,
Petr
> 
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
