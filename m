Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB150C433FE
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 11:56:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87FBF3C943D
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 12:56:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26C3B3C93F1
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 12:55:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9C0441A0009C
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 12:55:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B892E1F37F;
 Thu, 17 Mar 2022 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647518152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmfMjwIIN8J/CaSenX8q0MjfOaUUUwQ51sAWr1Dqwms=;
 b=ZIffJ5ExqGEbUnN1OXboL42k5ht/TZi9LZzQxkXCzKldWIROPIwTTTFgDZr4c0JvSk6Z/8
 3gXAydtdv9kYIA62/z+oJlM4JeogoWIdtZRB9nMQiZkH2Pw1FAALkTMtx2NmkgTzapMiS6
 EyDiCGlMB5dcVQmCRxJ3NutJC2Mlt6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647518152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmfMjwIIN8J/CaSenX8q0MjfOaUUUwQ51sAWr1Dqwms=;
 b=bnMvcDg8kTtjKk0PAMd8RngR8ubScuvf4Z42h8vyBsWr5X7FaDeaGIFeKHoubK/F28mdQh
 zJXyYnLKVTOzZvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1E2913B4B;
 Thu, 17 Mar 2022 11:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PepLJsghM2K4ZAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 17 Mar 2022 11:55:52 +0000
Message-ID: <5dd61389-714f-69f4-73bc-d0a4ee6f1031@suse.cz>
Date: Thu, 17 Mar 2022 12:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220309164954.23751-1-mdoucha@suse.cz>
 <20220309164954.23751-2-mdoucha@suse.cz> <87o8275lbi.fsf@suse.de>
 <f7972d11-de50-d9bc-3abc-dcba53dc3936@suse.cz> <87fsnj5hi9.fsf@suse.de>
 <dd1485f7-1f0d-3360-451f-99656b0fbe9d@suse.cz> <874k3x58nw.fsf@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <874k3x58nw.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for CVE 2021-38198
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 17. 03. 22 8:35, Richard Palethorpe wrote:
> Martin Doucha <mdoucha@suse.cz> writes:
>> Yes, I've verified the reproducer on older SLE-12SP5 and SLE-15SP3
>> kernels. But none of them currently have the tdp_mmu sysfile so the test
>> had to use the Intel/AMD KVM module reload fallback.
> 
> I see, in that case I don't think it's important to check it.

It's still useful to test the reproducer on a known broken kernel with
TDP disabled via tdp_mmu sysfile instead of KVM module reload. That's
the control flow that'll be used on all future kernels so we should
check whether it really works.

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
