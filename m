Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5D3C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 108A13CC88E
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:37:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F043C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:37:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4748C200C7A
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:37:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 50A6D21AB2;
 Fri, 25 Nov 2022 10:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669372640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJ+pcKbPGerYjhvD87toxGRjNzFOvMPgpM+vMj5Ydn4=;
 b=HQEZPyMAcCzmomGBdPihFhSOaS1IVOLxw73h5Q0+yfFm7TDvx3cHqUKOB26IiNqhU60VLw
 c1xb5S66H4Z757tGvdACFd+Tc0xZjxqXWy+MNwnUFxutyTyk6Qu8Gkv5SMbWne7muIEvFC
 PnKIBjJEHi+6ORZCUvjIgl2dw4RRVV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669372640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJ+pcKbPGerYjhvD87toxGRjNzFOvMPgpM+vMj5Ydn4=;
 b=cwhpMFvN2/28LDasf1aAQ0fInTPawHtc9hv2trV62NxmOvDxRhgQ6E6yzSatCursi5QS8d
 +cvLmon43APtnpDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D31B13A08;
 Fri, 25 Nov 2022 10:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iBUuCuCagGNvbwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 25 Nov 2022 10:37:20 +0000
Message-ID: <30abc28c-be3c-0f9e-0c2e-6614fdd30e0c@suse.cz>
Date: Fri, 25 Nov 2022 11:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, ltp@lists.linux.it
References: <20221123103547.54246-1-david@redhat.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20221123103547.54246-1-david@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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

On 23. 11. 22 11:35, David Hildenbrand wrote:
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
> +	TEST(ioctl(uffd, UFFDIO_API, &uffdio_api));
> +	if (TST_RET < 0) {

One more thing, checking just the ioctl() return value here is not 
enough. You need to check that uffdio_api.features still includes the 
UFFD_FEATURE_MINOR_SHMEM flag after the call. PPC64 does not seem to 
support it on kernel 5.14 and the ioctl() still succeeds there.

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
