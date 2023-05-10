Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E811DC7EE23
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 13:00:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 721423CD6C0
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 15:00:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CAFF3CD65D
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:59:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 081FC1A0091E
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:59:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 329F4219E7;
 Wed, 10 May 2023 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683723587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbqYBjNTnH5FOBjw1Ty0ftvqLgUzBfDc4Y6a+GwSZ0M=;
 b=dfSY7fDDwgy1rag1vA61Wwk0ARRHWIWXYg1K01YCSzG+2ML9NvKQ4sD+CPkfJTiTxNKboz
 KonM1UAYfshZ9XP1KakbWku2Rpompv7VN38Y+nB2BwWRNUPZflRqpHw7hnhH/SQGc3HdM0
 j6aPyMifMNXgxeXcYOeCB2/2UjmIa20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683723587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbqYBjNTnH5FOBjw1Ty0ftvqLgUzBfDc4Y6a+GwSZ0M=;
 b=Y8PvXK+Hv7AF+XpDoun2N/pakb9OvCPeesJtY5ZPJVLJKS3aOiot7LK9gE+Edi5XNpmVG/
 gYlUWOurGukoTwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EC0213519;
 Wed, 10 May 2023 12:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PDGyBkOVW2R4AgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 10 May 2023 12:59:47 +0000
Message-ID: <4f65c4c5-3278-8e64-5263-43b160547c6b@suse.cz>
Date: Wed, 10 May 2023 14:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <ZEjsKC6ESB1+mM0H@rei>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZEjsKC6ESB1+mM0H@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 26. 04. 23 11:17, Cyril Hrubis wrote:
> Hi!
> I would like to start with LTP pre-release preparations a bit sooner
> than usuall, since quite a lot of things have accumulated in May, e.g.
> there is a SUSE Labs conference right in the middle of the month.
> 
> I would like to start with reviewe of patches that should go in now,
> freeze the git somewhere at the end of the first week of May and aim for
> a release somewhere in the middle of the month. Does that sound Ok to
> everyone?
> 
> Either way if you have patches that should land in the upcomming
> release, please point them out now, so that we have a chance to review
> them.

Hi,
I've sent two patches fixing new failures in the rewritten 
kernel/containers tests. The failures are caused by getpid() return 
value being cached in older glibc versions because child processes 
created by SAFE_CLONE() cannot update the PID cache. Thus getpid() will 
keep returning the parent PID instead of the correct one. Newer glibc 
versions are not affected.

The patches:
- Add tst_getpid() helper function
- containers/pidns*: Fix PID checks

Please merge them before release.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
