Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1859ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 13:41:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B0D53C9AEA
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 15:41:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CC263C0727
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 15:41:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 102A01A007AA
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 15:41:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C935A21940;
 Mon, 24 Oct 2022 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666618867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6b5JdtbmVgBwN6L88/yzf0duymq2PEomwP1L27p21vI=;
 b=2zBqbpmUdFetswgSgf3r9SzkIEvjaEfFnHTVPbXvjchQZheWwE/R3Qj8n3F5NdfzlIKpv4
 mnA9Y5zRKG5GfiohmMdFwsZYg/FRrvwmxMgYPsnNJjnpQCvSy48U2mxsIIshhB5eB/0AZI
 x+VC/qRFhHYZnB8XUfRh3vAu/QruqnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666618867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6b5JdtbmVgBwN6L88/yzf0duymq2PEomwP1L27p21vI=;
 b=tl7fIwiqIPBK3k2+iXmDXLti9Xy3+XiA6qk5CN3Xf054XDQs5uzOO/JzicXqxfeEuZhxoZ
 qHdNgCu1KyEV6hDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3B5B13357;
 Mon, 24 Oct 2022 13:41:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oPksK/OVVmM+BQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 24 Oct 2022 13:41:07 +0000
Message-ID: <a11efac8-0fb3-df82-6fab-a722630425f7@suse.cz>
Date: Mon, 24 Oct 2022 15:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
References: <20221024103836.6394-1-rpalethorpe@suse.com>
 <20221024103836.6394-2-rpalethorpe@suse.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20221024103836.6394-2-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cpuid/ptrace07: Only compile on x86_64
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 24. 10. 22 12:38, Richard Palethorpe wrote:
> Both cpuid.h and ptrace07 contain inline ASM for x86(_64). There is no
> need to compile any part of the test or cpuid.h
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Martin Doucha <martin.doucha@suse.com>

Hi,
for both patches:

Acked-by: Martin Doucha <martin.doucha@suse.com>

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
