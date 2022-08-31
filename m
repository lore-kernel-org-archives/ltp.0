Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B407ECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 12:45:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B5373CA73C
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:45:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42E8B3C1351
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:45:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABDA7200923
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:45:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDB3722164;
 Wed, 31 Aug 2022 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661949906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=958Nlw/1LVDts1w0F4anctpVQMHvpBX2JGbpDL85jKM=;
 b=sTD9HgzkfVRKo3Zcs8d/eOJQm1WxijfsYl3RyfRivWD1fEKd6Vf6FV/InJnEj3dbZhlQx+
 AT8cAwV8wo805jIhp5vcUSipkpA9yiahSCIEBGZ7Nn6OknRgajpza3QQ763bN0SBhkrnsz
 fGfTuKcJkxm/WvSJCBriBMtCmP/IoB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661949906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=958Nlw/1LVDts1w0F4anctpVQMHvpBX2JGbpDL85jKM=;
 b=ocWs2dGHp2oRfK79H3heyGp6rGRyDQPhusVfV1cFX6d5gcGUWxNt4AVa3E+7RqI2+t1Tyw
 QXHJldSUlGDWxJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C900C13A7C;
 Wed, 31 Aug 2022 12:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zJCqL9JXD2MbIwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 31 Aug 2022 12:45:06 +0000
Message-ID: <45d76082-49f3-74bb-fd3c-6f5fd2d6136f@suse.cz>
Date: Wed, 31 Aug 2022 14:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-4-mdoucha@suse.cz> <Yw4jYgDzNj9BAqOf@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yw4jYgDzNj9BAqOf@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/10] ksm: Add max_runtime to tests
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

On 30. 08. 22 16:49, Cyril Hrubis wrote:
> Hi!
>> ksm02, ksm04 and ksm05 take 10+ seconds to finish. Set max_runtime to avoid
>> random timeout issues.
> 
> I wonder if we can do better.
> 
> I guess that the actual runtime does depends on the size of the RAM
> because we wait for at least two finished full scans for ksmd. I guess
> that for large enough machines we would end up with minutes of runtime.
> 
> So I guess that it would make more sense to treat the max_runtime as a
> upper bound and set it to large enough number as we do for AIO testcases
> (30 minutes) and then make the wait_ksmd_full_scan() runtime avare so
> that it exits when the runtime is exhausted. With that we would get a
> clear message that we timed-out in the loop that waited for the ksmd
> scan.

Alternatively, we could measure 1 full ksmd scan in setup() and then set 
max_runtime dynamically. Each call of create_same_memory() would need 
roughly 16 scan times. Time spent in ksm_child_memset() is included in 
that estimate.

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
