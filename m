Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8453C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:11:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3C060EE0
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE3C060EE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F7AE3C927A
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 16:11:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C9EA3C1DB4
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 16:11:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C6BF310008F8
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 16:11:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EA591FD84;
 Mon, 13 Sep 2021 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631542284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axWbd74v4/Ttbi6THeABUUJ0RviqyDrPiYFhz5axysM=;
 b=qP2kimGUSjpAHq3RqkNmglHtzFKm6CsBTI4SaU50TJkH5PzEzv/Xe5AGnhXeVPmwBkDziY
 pYPS5hsIN9fXDWiufxL86CV8vI4wgarXZ7gmAeeCJnQ7aG1biD6tPhutBhp0M6LLUp2bi9
 NExdTKmJZx/MvMwlLIRgJdvMcvM7AIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631542284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axWbd74v4/Ttbi6THeABUUJ0RviqyDrPiYFhz5axysM=;
 b=AHWxhzHvLDPaLK0qe7JvSGItJX7Ju4yHpzUqLoQDINj42ru9WPKYbrkhVYdTpMLbttpFw7
 5SOdps8d5YYmx8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECB9713AB2;
 Mon, 13 Sep 2021 14:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sFevOAtcP2G9WwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 13 Sep 2021 14:11:23 +0000
Message-ID: <3b789dc4-5232-a6d6-d864-7f75c5a0a030@suse.cz>
Date: Mon, 13 Sep 2021 16:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To: pvorel <pvorel@suse.de>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <287a9879ef8b3342cb88225e4e319733@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913141123.PBAuvZ9oHjYjnNzcdATmZoh1G-k34SG8PKO_8MII5os@z>

T24gMDkuIDA5LiAyMSAxODozMiwgcHZvcmVsIHdyb3RlOgo+PiAtwqDCoMKgIGlmIChnZXRwd25h
bSgiYmluIikgPT0gTlVMTCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdHN0X2Jya20oVEJST0ssIE5V
TEwsICJiaW4gbXVzdCBiZSBhIHZhbGlkIHVzZXIuIik7Cj4+ICvCoMKgwqAgaWYgKFRTVF9FUlIg
IT0gdGMtPmV4cF9lcnJubykgewo+IG5pdDogY2hlY2twYXRjaCBjb21wbGFpbnMgKFRTVF9FUlIg
c2hvdWxkIGJlIHNlY29uZCkKCmNoZWNrcGF0Y2gucGwgd3JvbmdseSBhc3N1bWVzIHRoYXQgVFNU
X0VSUiBpcyBhIGNvbnN0YW50LgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oK
UUEgRW5naW5lZXIgZm9yIFNvZnR3YXJlIE1haW50ZW5hbmNlClNVU0UgTElOVVgsIHMuci5vLgpD
T1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVwdWJsaWMK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
