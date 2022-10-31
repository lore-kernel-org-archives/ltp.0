Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D278EECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:00:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FCFF3CAAEF
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 15:00:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A4B93CABC5
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:00:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63CE71000456
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:00:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C3371F987;
 Mon, 31 Oct 2022 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667224801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nui9r6sKPdbLSnHgBV8iKvfv0xcWc+Ra7KC6pA1CXE=;
 b=DMEmgR0N1L4N/0Dwu7fuCaWImGzvxog6TrP9Q2yqkF4g5q4hZlSE7y4DcpIVu/kKHiR5E3
 P//xM8vmG1tTM5b1+8C0sXy1685Uqa3DKdY5XWcEjkRcshKDfV3K3fv3uH5D+qdZh/poAR
 RjaP0TPEUqwI11XvaYRbeod2dhWoKic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667224801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nui9r6sKPdbLSnHgBV8iKvfv0xcWc+Ra7KC6pA1CXE=;
 b=CvQZEC++zULOicV3GDdAALOurzFMUM4wzzEEv0HgtZ1JSd7bVVOEtdxUcfHtQozdBxdavt
 AtOut7f0e1wRP/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34B8D13451;
 Mon, 31 Oct 2022 14:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 51upC+HUX2OKbAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 31 Oct 2022 14:00:01 +0000
Message-ID: <96b14089-f1bb-e634-d74b-75fe92e58efa@suse.cz>
Date: Mon, 31 Oct 2022 15:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221027140954.4094-1-akumar@suse.de> <Y1+zeo9kmWOl2yE3@pevik>
 <ad63ddb5-b443-c0ee-fb1b-748bded5f151@suse.cz> <Y1/SkicyE3Mg9Fpc@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y1/SkicyE3Mg9Fpc@pevik>
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

On 31. 10. 22 14:50, Petr Vorel wrote:
>> No, UID16_CHECK(invalid_uid, setfsuid); is the correct test call. The test
>> is supposed to verify that trying to set invalid_uid will fail, and the only
>> way to verify that it failed is to call setfsuid(invalid_uid) again and
>> check that it returns current_uid.
> I'm somehow blind today. UID16_CHECK() in compat_tst_16.h calls
> UID_SIZE_CHECK(), which just checks the uid value. I don't see setfsuid() call,
> IMHO that's done in SETFSUID().

It doesn't make sense to call UID16_CHECK() on a value that we'll never 
pass to a 16bit syscall, does it?

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
