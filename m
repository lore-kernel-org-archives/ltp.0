Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2A0C54E71
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 10:39:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D17D33D2792
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 12:39:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03B223D272A
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 12:39:05 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7176A1402FBF
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 12:39:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DC0F1FBED;
 Wed, 28 Aug 2024 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724841543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Et7WtT1cDmNJ0huU9w473Ep4G+P2YOf6Te1HA86wFR0=;
 b=ZNeXd6/HyNzMHQzfjuy+G/7YepSnq3K9WsKk/pMbC3lG4RwxwRezfsyq8q05k8UCc+7fxd
 zxYPOsA/E4KTiSIk9ssHgepspwh6uE+Bta+eO2pbBL+4sKSFa7Oppk0u+1Ff8+5F7rciJP
 Cbw2OIPFk1R9PObb/YjiS2FIfHThEVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724841543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Et7WtT1cDmNJ0huU9w473Ep4G+P2YOf6Te1HA86wFR0=;
 b=8vRFAMNBZketU4Ad7IPRLZMEfRPFq5qnoAzug5u89rNo/mclgJ7lRiCNXfKLUjdjF39+k7
 RMxsxWvuORmcuGAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724841543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Et7WtT1cDmNJ0huU9w473Ep4G+P2YOf6Te1HA86wFR0=;
 b=ZNeXd6/HyNzMHQzfjuy+G/7YepSnq3K9WsKk/pMbC3lG4RwxwRezfsyq8q05k8UCc+7fxd
 zxYPOsA/E4KTiSIk9ssHgepspwh6uE+Bta+eO2pbBL+4sKSFa7Oppk0u+1Ff8+5F7rciJP
 Cbw2OIPFk1R9PObb/YjiS2FIfHThEVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724841543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Et7WtT1cDmNJ0huU9w473Ep4G+P2YOf6Te1HA86wFR0=;
 b=8vRFAMNBZketU4Ad7IPRLZMEfRPFq5qnoAzug5u89rNo/mclgJ7lRiCNXfKLUjdjF39+k7
 RMxsxWvuORmcuGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82B28138D2;
 Wed, 28 Aug 2024 10:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8fudH0f+zmZfbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 28 Aug 2024 10:39:03 +0000
Date: Wed, 28 Aug 2024 12:37:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Zs7-A5S_ivFlosrj@yuki.lan>
References: <202408211026.636ade1a-oliver.sang@intel.com>
 <767d1908-dc30-42ae-9a8a-d2ad42a4d491@redhat.com>
 <8bde28af-3401-4d72-b821-d8cf01bbcd64@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8bde28af-3401-4d72-b821-d8cf01bbcd64@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [mm/migrate] b28dd7507f:
 ltp.move_pages04.fail
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
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, lkp@intel.com,
 Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 ltp@lists.linux.it, Matthew Wilcox <willy@infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kernel test robot <oliver.sang@intel.com>, Sven Schnelle <svens@linux.ibm.com>,
 Zi Yan <ziy@nvidia.com>, oe-lkp@lists.linux.dev,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Okay, and it even looks like the test caught the unintended change for 
> "unpopulated memory", but instead we decided to change the test to 
> expect the other return code ... because there was some confusion about 
> "zero page".
> 
> Long story short: the test needs to be fixed.

Will do, but we need the patch to land into some kernel version first so
taht we can add the range of kernels where the kernel wrongly returns
EFAULT.

Or alternatively if you are going to backport this to stable trees we
can revert the test change that expect -EFAULT so the test expects only
-ENOENT.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
