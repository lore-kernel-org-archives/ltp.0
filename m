Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C874C3DA7A
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 16:28:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 489813CB68B
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 17:27:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F17383C88EF
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 17:27:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E87E2009A0
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 17:27:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 509CA178DA;
 Thu,  5 Jan 2023 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672936068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IXPn2WvvwKu678BxjGd9+N/HCd9lhA01IcgWDmPRmE=;
 b=B4cBwE/Nvjlq72Ffi/fisioQ2TpyihaDLyN/9+8qO1bXt83A89gfS5GTkxw4iJPsghNLzi
 fWlvpbQFqJX0N3fEhBQv7SfPnrIk5TN1PT6vDe7/iL9YNkIi/W7+2IVsrvuaYTENHJD1kb
 HO26yfG8xSW+jogATwDqQdKBCSIGVzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672936068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IXPn2WvvwKu678BxjGd9+N/HCd9lhA01IcgWDmPRmE=;
 b=fJvzWDwmIM3YLZTIA3pIm09sw60iihv6pi6sspmu+XeZdeo67fcZtlzDqb1YZckMnwL8ud
 6boSfoTHPCfv9lDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 317E613338;
 Thu,  5 Jan 2023 16:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Qax+CoT6tmPBSAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 05 Jan 2023 16:27:48 +0000
Message-ID: <a94f5417-c580-8b05-dca6-3bb968ef5afb@suse.cz>
Date: Thu, 5 Jan 2023 17:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: Petr Vorel <pvorel@suse.cz>
References: <20230105134416.15853-1-mdoucha@suse.cz> <Y7bu3jaL+nLIc/+0@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y7bu3jaL+nLIc/+0@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ltp-aiodio.part4: Run DIT000 with only 1 reader
 process
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

On 05. 01. 23 16:38, Petr Vorel wrote:
> But I wonder why changing just the first dio_truncate will fix it
> (obviously not). Could we detect RT and force -n 1 for it?
> (utsname.version should have "PREEMPT RT"). Obviously only from version which
> got affected.

It'll fix only one of the three tests. But I like having some direct I/O 
stress tests for regular kernels so I've modified only one dio_truncate 
instance. The other can be skipped manually on RT kernels.

But let's add a warning to dio_truncate if it's running on RT kernel 
with too many children so that users know that the failure is sometimes 
expected.

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
