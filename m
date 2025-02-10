Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA28FC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 13:44:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FC133C98B5
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 14:44:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 444B03C1C56
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:44:08 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 675A363CB0A
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:44:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C8B5121111;
 Mon, 10 Feb 2025 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739195045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeDIVl6RxYy3lWEslvX8whLbqbM/ybugcuKgl9SZgOc=;
 b=AbmysEPUjiVF9PBjTfhFtkdM9GRoyNKjAkgvQsbrxLL5v6/CueISp9QKgabC75ugOpSmdd
 PIf72Yn4AZWYmOxOnLj0MS+ZQKk9MnT65oQLLEePdXh4nyd0MjlwtCiHsdJIAhP5rzNZOA
 DrmKOvAGu6NL/oTjamx+2rFKBhm7uOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739195045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeDIVl6RxYy3lWEslvX8whLbqbM/ybugcuKgl9SZgOc=;
 b=DqB8OiYhJGvX2Nofi4egEs4DH+zRSargXFUAzzdlOwcnbine6UYXpHdvg+tj4YZ022UsVs
 TwrF9fJCj0AKVoAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739195045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeDIVl6RxYy3lWEslvX8whLbqbM/ybugcuKgl9SZgOc=;
 b=AbmysEPUjiVF9PBjTfhFtkdM9GRoyNKjAkgvQsbrxLL5v6/CueISp9QKgabC75ugOpSmdd
 PIf72Yn4AZWYmOxOnLj0MS+ZQKk9MnT65oQLLEePdXh4nyd0MjlwtCiHsdJIAhP5rzNZOA
 DrmKOvAGu6NL/oTjamx+2rFKBhm7uOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739195045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeDIVl6RxYy3lWEslvX8whLbqbM/ybugcuKgl9SZgOc=;
 b=DqB8OiYhJGvX2Nofi4egEs4DH+zRSargXFUAzzdlOwcnbine6UYXpHdvg+tj4YZ022UsVs
 TwrF9fJCj0AKVoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C200413A62;
 Mon, 10 Feb 2025 13:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XPk+L6UCqmdsEQAAD6G6ig
 (envelope-from <pvorel@suse.de>); Mon, 10 Feb 2025 13:44:05 +0000
MIME-Version: 1.0
Date: Mon, 10 Feb 2025 14:44:05 +0100
From: pvorel <pvorel@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <Z6n59mHMpZxIMcZk@yuki.lan>
References: <20250210113212.29520-1-chrubis@suse.cz>
 <20250210113212.29520-3-chrubis@suse.cz>
 <01a16c47a0920ed4c60db277087f9ea7@suse.de> <Z6n59mHMpZxIMcZk@yuki.lan>
User-Agent: Roundcube Webmail
Message-ID: <a3395c69a6b9c9b8de6ef0f0fe6e35f3@suse.de>
X-Sender: pvorel@suse.de
X-Spamd-Result: default: False [-8.29 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/13] lib: Replace path_exist() with
 tst_path_exists()
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

On 2025-02-10 14:07, Cyril Hrubis wrote:
> Hi!
>> > Move and rename the path_exist() function from
>> > testcases/kernel/mem/lib/ to the to level library.
>> >
>> > This removes mem.h dependency from mem/cpuset/ test.
>> >
>> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> > ---
>> >  include/tst_fs.h                       | 10 ++++++++++
>> >  lib/tst_path_exists.c                  | 23 +++++++++++++++++++++++
>> 
>> The only thing I don't like is creating file for single functions.
>> My long term plan was to have fewer files with more functions.
>> I'm sorry I did not point this out in v1, thus feel free to ignore it.
> 
> Feel free to move this code to a file you find appropriate and merge 
> the
> patchset.

Cyril, please merge it as is.
After that, I send a patch for

Moving into newly created tst_fs.c these new API sources: tst_ioctl.c, 
tst_fs_setup.c, tst_fill_fs.c, tst_fill_file.c, tst_path_exists.c, 
tst_supported_fs_types.c.

And moving into newly created tst_fs_old.c these old API sources:
tst_fs_has_free.c (only dma_thread_diotest.c has not been converted into 
new API), tst_fs_type.c.

Having everything eventually in single tst_fs.c might be too much, but 
I'm not sure if it's worth to spent time to split tst_fs.h into separate 
headers (and then to corresponding c sources).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
