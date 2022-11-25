Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A76C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 14:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1560E3CDCCE
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 15:26:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFE863CC8E3
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:26:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B2581600E4A
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:26:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D58E51FD64;
 Fri, 25 Nov 2022 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669386377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmmTfXJvk7sOoHObgnABQfoNpSbXXdlqfqFuMvcn0Wk=;
 b=2i6r1hX67GzH5UkAtSy2Gt2Jxk9TChNLFhFytLpJ3YhqkeZSZZ1uXm0hCQIpKFsAUYG70t
 XI9XJD4lEu+k4iR+3aUxoQIOJ9jUMRRPV4NSmcB3Z4f3Lnj1xlX8oMhk/KWMbGA6R34epn
 mxok8AzePvjSfQKUqyWLYvse7QoaS1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669386377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmmTfXJvk7sOoHObgnABQfoNpSbXXdlqfqFuMvcn0Wk=;
 b=4/MQORm3b5FuouqkBzFnI4U9ryutnktNWh9Ko7LZh7RFkBCnfU5VQbmRzU6aJXMQhU8gBu
 1izsLz7Qh/6etUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADA081361C;
 Fri, 25 Nov 2022 14:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dENWKYnQgGNOagAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 25 Nov 2022 14:26:17 +0000
Message-ID: <aedafbef-fc19-d552-9459-0878d9a6be8a@suse.cz>
Date: Fri, 25 Nov 2022 15:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz> <Y4DPu7c+a939n2D5@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y4DPu7c+a939n2D5@yuki>
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
Cc: ltp@lists.linux.it, David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 25. 11. 22 15:22, Cyril Hrubis wrote:
>> Manpage says that the last argument of execlp() must be (char*)NULL,
>> including the explicit typecast.
> 
> I wonder if this is actually valid. Do you know in which way is
> different ((char*)0) from ((void*)0) ?

I think the point is that there's no guarantee that NULL will actually 
be defined as (void*)0. It can be defined as a plain integer instead. 
And it *IS* defined as plain integer when the header is #included in C++.

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
