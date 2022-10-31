Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E90AECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:36:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB3503CABD6
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:36:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6CCC3C01CC
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:36:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03A2010006C6
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:36:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE5011F95D;
 Mon, 31 Oct 2022 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667223383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UW5RwbR3Zusou5OZyDo/ZBLQq8nbqVNqaS/2gnjG80=;
 b=ol4iifw8IcVuNKiOTSKcKu+PZTuFY14hU+tQpM7C6/2aJzDZHKyQueW4THkx2BBaWID+eS
 uCKA9JxCyVMlCXIIA6vreHyzBKZiSqMGbNoCT9mvdMl1/kMGC+CJaxs+7pxUb66079wQBN
 tkm41ZBJUV8rqqsWBde1MWZym6+MeZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667223383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UW5RwbR3Zusou5OZyDo/ZBLQq8nbqVNqaS/2gnjG80=;
 b=adtXSAFggdkM77rYixMxJE6Ls839Ikj50C+grEOYmvhtK9v7RMUd7PPVcuSApnwHyGAIVf
 KF1bXgPkBllAHVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9DD413AAD;
 Mon, 31 Oct 2022 13:36:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H0ZYNFfPX2NDYQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 31 Oct 2022 13:36:23 +0000
Message-ID: <ad63ddb5-b443-c0ee-fb1b-748bded5f151@suse.cz>
Date: Mon, 31 Oct 2022 14:36:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Petr Vorel <pvorel@suse.cz>, Avinesh Kumar <akumar@suse.de>
References: <20221027140954.4094-1-akumar@suse.de> <Y1+zeo9kmWOl2yE3@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y1+zeo9kmWOl2yE3@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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

On 31. 10. 22 12:37, Petr Vorel wrote:
> Hi Avinesh,
> 
>> a uid which does not have an entry in the /etc/passwd
>> file is not really an invalid fsuid for setfsuid(), so changing
>> the test to use -1 as an invalid fsuid.
>> And second setfsuid(-1) call is to verify that preceding call has
>> actually failed and there is no change in the fsuid.
> 
> Here was supposed to be
> Fixes: 85f0b8478 ("setfsuid02: Rewrite using new LTP API")
> 
> as the problem was introduced in your rewrite, right?

No, the original test was already broken, it just didn't do any real 
failure checks so it always passed.

> It also does not make sense to check invalid_uid, it should have been
> current_uid in 85f0b8478 (my bad not catching this):
> 
> UID16_CHECK(current_uid, setfsuid);

No, UID16_CHECK(invalid_uid, setfsuid); is the correct test call. The 
test is supposed to verify that trying to set invalid_uid will fail, and 
the only way to verify that it failed is to call setfsuid(invalid_uid) 
again and check that it returns current_uid.

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
