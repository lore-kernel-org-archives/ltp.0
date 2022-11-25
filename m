Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98675C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:25:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9369F3CC89E
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:25:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE3883C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:25:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 729AD600C60
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:25:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C599C1F8D5;
 Fri, 25 Nov 2022 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669371938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLKob9VgdwRdhx9z5uuQNEw0MEbSNu9N+vZ61vTtcCk=;
 b=2KiNxSb1VWS5Zirw0zh/lweY6XToMLjgigNcdAnN64CMFC92jyi5l1gqec9b4CzjCmX44q
 btMVKnWIVEiPNA9QgVcIiEGvGFGyuLg6oRWbequVrSpJEOgwTApszhQGtXnuNwQRcpuZU9
 RBFb8+gcL4ugRh2ZgSwrWeJXVmxTVNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669371938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLKob9VgdwRdhx9z5uuQNEw0MEbSNu9N+vZ61vTtcCk=;
 b=igtb4FHjFcixNnEc4I2dYzjQbx7Iec7U1Wp9mRGJiupYMiRyUYTlAemvpc+2b6CU3eiDbR
 sjHTHf/b2gGEW6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADB2113A08;
 Fri, 25 Nov 2022 10:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KgSxKSKYgGMKaQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 25 Nov 2022 10:25:38 +0000
Message-ID: <af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz>
Date: Fri, 25 Nov 2022 11:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Petr Vorel <pvorel@suse.cz>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz> <Y4CTrrCb4jtQay9y@pevik>
 <da91a3a8-4609-c128-1c73-8b35dfb2b7c9@redhat.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <da91a3a8-4609-c128-1c73-8b35dfb2b7c9@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 25. 11. 22 11:20, David Hildenbrand wrote:
> See my other mail, it's the case on all instances that pass NULL (and I 
> don't really see the need to do this when working with NULL.

NULL may be defined as simple integer 0. When int is 32bit and pointers 
64bit, this will cause trouble in variadic functions such as execlp(). 
You do not need to remind us that LTP tests have lots of bugs, we know.

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
