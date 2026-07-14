Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D318C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784016451; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=zXqpPKynfv6T0CosS3Buz19xYRkrSVlc5Ky5s1OwcNg=;
 b=f4rdeIJkdJN4PNPytIiFUPDtWstO5BxZoblZ+OA6su5XCXskheqpSDBRxjISIdtHpQlEs
 4kdlii0Pazsc32QNN2M+v4+QuomeivLJvxvBTs0DTugTd3JIQ/b0/SPUbB0X1RZJRKD+SOk
 0m5AaRWtqvMdXfz1LgGj8R0/MI+Vjw0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCAA33E2C38
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:07:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E41563C17CE
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:07:12 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70CDA20096F
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:07:12 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso1183817f8f.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784016432; x=1784621232; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Hrc2JJG62uwx1k/HHKpRIPW3igSnROZrYmag2vCEXbc=;
 b=R53oYTuOoLsYYVZLvpkuzi+D3q9VccsGbEh/gQh0lfasSwfoBUPqMzRtkK4kwXDDP/
 HPgyW7wWMVomIoXVamU/6Uyq1ecZEnZaLaLcVv2PjVpFSM/mkHwkTXs1ntONpbq/2+OB
 kox8Sj/wh6F1TgbF5rocsqm2sQRttsQrXqAYcsCG6s5UUxdc9SRtDKxAh5qubQlivn6X
 JDD+5n10d2eErgdmkCADVHXuTVq0O0IWG/ts35P1rk+cIQN4txm8p9+xgOhpr14zXRps
 6+s9Hy3wiWVRiBbUdqrjVSZaUNNuPSJdx65SNECFvBuhgGHz8gezvpF/w8+OWeLptNX+
 WLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016432; x=1784621232;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hrc2JJG62uwx1k/HHKpRIPW3igSnROZrYmag2vCEXbc=;
 b=UhHA239qmQJyJpG1imiuindDus2Hz+bYPI9JQdwVu8dxULIWghoOk9b8MTM80UnLYd
 lGYAFdG3ON6Z76cLe3OX9acwM/9K9CCYYZlkRAxSSnXgtcGLnrfg+EaBNrtalQmH/nZe
 uprVCK2KaO4tP+7FgWbKxXmjwzfAZh621TpmGrSDlGOhO5DRrT9MbOSbqLSSUrfsxFAx
 kpFmVspMZqh8KS5AsjlQ6bGkMTb+4JiBmjDcvtXEZBET2JoSuf1i2I7/afHZjRewpg1V
 MWhBO259lKHOJXi5haVSyB3anVsRaRmhQeZhgKPXpoIo/nAU32EZHiHSxucmlYdEFkEP
 /3jA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6VkTDSLpqdwkUCfQakO5OBI05R6e9gjK+g2RWMgUFOc9cpZxkSDUn4Inx+/MTMYBbZ0A=@lists.linux.it
X-Gm-Message-State: AOJu0Yzbc5UGLgVzqxKvPOmcpHrfTS63NBehXcph7wLnWMCTB8KauCOA
 0EeOYWtpWkGBbzM/U/xXwoiwLp3SNPR6e5gLFUxw/L3eS6c31HmgGl8wjZjPDCR/aXDMg0rSgpw
 wCe5saT5GdQ==
X-Gm-Gg: AfdE7cmQIyW+DvgjFcqNZldHEGDP56KNh8m5nzdQGmUtOQ4nPHTSku0WAkopNQWm0iM
 O3AzQSFt+l7ZiZ6bleiwwJZO9DSr3qA9tiWJWZ6MaTevqNgnU0dZgyWVUDPbX5jIHJRXGeVBdoX
 DF93YJrD6MziZZhQwEsKagI8B5DQkZj+tOidGzSWJCVVF3lVjDJfkUvqZNpOKuwDWH71FmPil2u
 pLmZOIK9ucchKrfjrjr224B1FzUIcL9Cp0fTdh8D5BNG+EvPm0gZPpXa80hbVRK3QVE1oCgJ8Wp
 VbSs2o7KyMMovnsqsyuBk3nquEpnL396VcWWBnemIeV2HQjgUr/6LPUamAzgD7fg2E8dQNqtbgc
 m419RyTN812zNVdBPQELyiKvAt9nzsabhLVWKQ9zLC5AqnK3DYkDcuj53cC41ch/bEopGFOws+K
 eAZFCvab975nlbZRqyl4RAp2lXEWLcqa6wN102
X-Received: by 2002:a05:6000:4713:b0:476:dd2b:611 with SMTP id
 ffacd0b85a97d-47f4886e8b1mr1511353f8f.3.1784016431194; 
 Tue, 14 Jul 2026 01:07:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm6672266f8f.8.2026.07.14.01.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:07:10 -0700 (PDT)
Message-ID: <6a55ee2e.3d30ac2e.4abe5.ca02@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710070511.GB1157094@pevik>
Date: Tue, 14 Jul 2026 08:07:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/9] SAFE_MACROS: Add SAFE_POLL()
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Cyril,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> nit: it introduced 3 more formatting issues:
> tst_safe_macros.c:834: CHECK: Alignment should match open parenthesis
> tst_safe_macros.c:841: CHECK: Alignment should match open parenthesis
> tst_safe_macros.c:844: CHECK: Alignment should match open parenthesis
> 
> We can disable PARENTHESIS_ALIGNMENT if we don't care about this formatting.

Yes please, this rule is really annoying and producing lots of
non sense issues. As well as the "`(` should not be at end of line" rule.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
