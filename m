Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D66C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 10:45:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52C763C21D8
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 11:45:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF9E33C1BB8
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 11:44:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C36791400DA7
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 11:44:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F006210F2;
 Tue,  8 Mar 2022 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646736293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULwHlhmyvwXKCQLWnu3ASaPAXLum2TvWTxwMvf8tG4Y=;
 b=z9IznIlNLMhJqwXDNkqyeUvSJYGLF9vIXo2q07SFRm/ta/F6EutIfu1e0CmfMJl9C9Ao8m
 hZAEVv9PiBsyfXcX2uoIlyd8yTz5uIORrWVwfolzynWkECoQdVgpP3TZ6xQhlm4YjR8446
 aHfw3t8EzcI7H8+hSI9eFXvrPywhgIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646736293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULwHlhmyvwXKCQLWnu3ASaPAXLum2TvWTxwMvf8tG4Y=;
 b=SVS+DqSpJkfuYfn5R+NR4I7onQBz429D5Dow9rSrDfQLog3elxGPqNm+FfDqKKrNOX3chu
 h09G3Nw971Pf50DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61ED513C62;
 Tue,  8 Mar 2022 10:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A8OaFqUzJ2IUTgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 08 Mar 2022 10:44:53 +0000
Message-ID: <3c946010-2f96-e8bb-e7ee-0d48d482d729@suse.cz>
Date: Tue, 8 Mar 2022 11:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 Petr Vorel <pvorel@suse.cz>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YiDK7g1pwLj2aXBD@pevik> <6221869A.9040109@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <6221869A.9040109@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 04. 03. 22 4:24, xuyang2018.jy@fujitsu.com wrote:
> Hi Petr
>> Hi Xu,
>>
>>> On centos7.9ga, I still hit another crash problem because of use-after-free in
>>> prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this
>>> case will crash after we print TPASS info.
>>
>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>>
>> LGTM.
>> I tested two old kernels, the one with patch survives, the other got reboot.
>>
>> BTW funny enough the affected system manages to print "TPASS: Nothing bad
>> happened, probably" before reboot :).
> Yes, it crash when timer expired, so it will print TPASS before reboot. 
> Also, I try sleep 10ms, but it still print TPASS and reboot after serval 
> seconds.

The timeout is controlled by req.tp_retire_blk_tov and the value is in
milliseconds. So usleep(req.tp_retire_blk_tov * 3000) should be enough.

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
