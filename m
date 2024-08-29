Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C83C83F2E
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 14:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 457E23D280F
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 16:33:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DC933D20EB
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 16:33:00 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C83DE610226
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 16:32:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E5112191F;
 Thu, 29 Aug 2024 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724941978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgvBT/lMjv0ff6wv1Eg9swV/WKRHj1qSeWNebhjgOLE=;
 b=Ib6HJNkweLpoMNy9W+ktcnIfarHyScnBiHOx6IeKMXpW2Gq4QBRThgGCIiPK1ILP9GgRaB
 SiRi9FFczMaF9NUte0GpcZ23rNgWmGv1WfrgVIxQDgfBE95unB4H47p0kEW8orpRq/+M46
 dxEtOWVgq6V8xY5iphsktaQh9CnC7iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724941978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgvBT/lMjv0ff6wv1Eg9swV/WKRHj1qSeWNebhjgOLE=;
 b=HnkQ4ZRkz+qTUajSB8bGbE0s2bYu2jD9QSuBOJXfo/+nhkSo/IHe7qiLbfcyN35oYjQ8ca
 cUXPP7DlWiQnCIBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724941978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgvBT/lMjv0ff6wv1Eg9swV/WKRHj1qSeWNebhjgOLE=;
 b=Ib6HJNkweLpoMNy9W+ktcnIfarHyScnBiHOx6IeKMXpW2Gq4QBRThgGCIiPK1ILP9GgRaB
 SiRi9FFczMaF9NUte0GpcZ23rNgWmGv1WfrgVIxQDgfBE95unB4H47p0kEW8orpRq/+M46
 dxEtOWVgq6V8xY5iphsktaQh9CnC7iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724941978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgvBT/lMjv0ff6wv1Eg9swV/WKRHj1qSeWNebhjgOLE=;
 b=HnkQ4ZRkz+qTUajSB8bGbE0s2bYu2jD9QSuBOJXfo/+nhkSo/IHe7qiLbfcyN35oYjQ8ca
 cUXPP7DlWiQnCIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09AFD13408;
 Thu, 29 Aug 2024 14:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p6c4AZqG0GY6VwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 29 Aug 2024 14:32:58 +0000
Date: Thu, 29 Aug 2024 16:31:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <ZtCGVr8l_Eq5uVlu@yuki.lan>
References: <202408211026.636ade1a-oliver.sang@intel.com>
 <767d1908-dc30-42ae-9a8a-d2ad42a4d491@redhat.com>
 <8bde28af-3401-4d72-b821-d8cf01bbcd64@redhat.com>
 <Zs7-A5S_ivFlosrj@yuki.lan>
 <c6fb5f16-59bb-47a5-a2dd-3c4207d73614@redhat.com>
 <Zs8W3nQszwhbSiT9@yuki.lan>
 <4c190c79-401e-43a9-a4d1-e64f78110e0b@redhat.com>
 <Zs8Yg7nXZHG8U821@yuki.lan>
 <8a16ac0e-4a3f-48cc-a118-ea05c23d5d2b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a16ac0e-4a3f-48cc-a118-ea05c23d5d2b@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWELVE(0.00)[19];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
> >>> Also I think there is a third case that we do not cover either, what
> >>> happens when we pass an address that is not mapped at all, e.g. NULL? Do
> >>> we get EFAULT as well?
> >>
> >> Yes, that's documented as EFAULT and should behave that way. I can
> >> extend the test to handle that as well.
> > 
> > Ideally the test should be ported to the new test API as well, but I can
> > do that later on the top of your work.
> 
> I tried, and it all looked easy, until I realized that these tests use a 
> share code-base:
> 	testcases/kernel/syscalls/move_pages/move_pages_support.c
>
> That is also written using the old API. I assume mixing APIs might not 
> work as expected ...

The tst_resm() and tst_brkm() calls are redirected proplery in the case
that the test runs with a new API so generally it should work fine as
long as the cleanup callback is set to NULL for the tst_brkm(). That
was one of the design decision we took years ago, because we knew that
we are not going to reimplement thousands of tests instantly and that
the old and new API would have to live alongside for a decade.

I glanced over the code and I do not see anything in the
move_paves_support.c or in the kernel/lib/numa_helper.c that would break
when executed under the new library test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
