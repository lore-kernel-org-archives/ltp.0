Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A02ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:04:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD22D3CAC04
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:04:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0B193C9111
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:04:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EB248200E08
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:04:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C531B33969;
 Wed, 14 Sep 2022 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663146284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwZnyKoEjaM+zXKheCAop3niXhk4OlVPKkYX/usKhxg=;
 b=NkAwQAHEcVchzBdnRVHNnmqyZwOnHvBn92RB7T2E1T2ubRn7zQ5d109kXyOd1KoB9FR7cX
 Pmx1KDrbbkzeiD4XqUatC8qqnRTRykuOaCDFq9ZgzfNk3wCTWfZJ4xfed0kg+R3m1WnUeJ
 MIU3iyhR/DiZa5AZocdEmeQqhmCGQCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663146284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwZnyKoEjaM+zXKheCAop3niXhk4OlVPKkYX/usKhxg=;
 b=Q8i8vAZXFc+bkN6OtJ+FQOibbBCNBeas0TxIRvcC492EVRIrG3Ijjnp+GqQJPG8Q3OQcsx
 1XBSf63eTc+AWSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABA9C13494;
 Wed, 14 Sep 2022 09:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZlTFKCyZIWMZHwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 14 Sep 2022 09:04:44 +0000
Message-ID: <d35ab5f4-3320-1942-e6d2-d21aa3ac29e5@suse.cz>
Date: Wed, 14 Sep 2022 11:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Edward Liaw <edliaw@google.com>, ltp@lists.linux.it
References: <20220913202853.1808453-1-edliaw@google.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220913202853.1808453-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kvm: main returns int
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
Cc: kernel-team@android.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 13. 09. 22 22:28, Edward Liaw via ltp wrote:
> ---
> I think the test framework expects main to return int, is this correct?

No, the test framework does not expect any return value from main(). 
This is also written in KVM test documentation in the last paragraph of 
"Basic KVM test structure":
https://github.com/linux-test-project/ltp/wiki/KVM-Test-API

Redefining the return type to int will not break anything but the value 
will be ignored. Test results are passed through a special memory buffer 
using tst_res() and tst_brk() functions.

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
