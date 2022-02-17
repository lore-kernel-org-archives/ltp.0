Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890BBC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 08:10:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EF7E3CA0B7
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 09:10:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6A7E3C2E42
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 09:10:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B8E7A1A01759
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 09:10:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFE861F37D;
 Thu, 17 Feb 2022 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645085426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ze5h/utAx/bMXvFFqV3uPxIQK4i7ahu5altI3j2sTvk=;
 b=ruptivJ51gJQVtrrndo6uCq8bPbn/tW6Tj0WKIlYZha6BI+IrTve7nRtb2AaHYnz+zEP34
 uLadIPT7v6KRvAjxGcTauctbndSAMxMRf35JmdJJjlPX6mMqQnarX8RwkYEq+zZVFKKsb3
 2KNgHF3LiUiEQYWVldwmBe41srucXac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645085426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ze5h/utAx/bMXvFFqV3uPxIQK4i7ahu5altI3j2sTvk=;
 b=Bh0NJVer34aTSSZhe5T7UXJzJ3GqErkPHk0FXyoJ+OcgaJOB4xgP4YorzVpiGfGFVQWTBR
 2kZiPmzz+yiU+vAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B6BF13B85;
 Thu, 17 Feb 2022 08:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FcD1H/ICDmLCDQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 08:10:26 +0000
Date: Thu, 17 Feb 2022 09:10:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yg4C3NBVy87FlQSb@pevik>
References: <20220216111013.32056-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220216111013.32056-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite confstr01.c test using new LTP API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgo+ICAjZGVmaW5lIF9YT1BFTl9TT1VSQ0UgNTAwCj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4K
PiAgI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKCgpXaGVuIGlu
Y2x1ZGluZyBoZWFkZXJzIGxpa2UgdGhpcyB3ZSBnZXQgd2FybmluZyBkdWUgX1hPUEVOX1NPVVJD
RSA1MDAKCnJtIC1mIC1mIC1yIGNvbmZzdHIwMSAgKi5vICoucHljIC5jYWNoZS5tayAqLmR3byAu
Ki5kd28KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3NhZmVf
bmV0Lmg6MTUsCiAgICAgICAgICAgICAgICAgZnJvbSAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF90
ZXN0Lmg6MTAwLAogICAgICAgICAgICAgICAgIGZyb20gY29uZnN0cjAxLmM6MTk6Ci4uLy4uLy4u
Ly4uL2luY2x1ZGUvdHN0X25ldC5oOjMyOjc0OiB3YXJuaW5nOiDigJhzdHJ1Y3QgYWRkcmluZm/i
gJkgZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0
c2lkZSBvZiB0aGlzIGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24KICAgMzIgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpwb3J0LCBjb25zdCBz
dHJ1Y3QgYWRkcmluZm8gKmhpbnRzLAoKV2UgbmVlZCB0byBsb2FkIDxzdGRsaWIuaD4gYmVmb3Jl
IF9YT1BFTl9TT1VSQ0UgNTAwLgpJTUhPIF9YT1BFTl9TT1VSQ0UgNTAwIGlzIGZvciA8dW5pc3Rk
Lmg+LCB3aGljaCBkZWZpbmVzIHRoZXNlIF9DU19YQlM1KiBkZWZpbml0aW9ucywKdGh1cyBzYWZl
IHRvIGRvLgoKNTAwIChYL09wZW4gNSkgaXMgZm9yIFBPU0lYIDE5OTUuIElNSE8gd2Ugc2hvdWxk
IHVwZGF0ZSAoYXMgYSBzZXBhcmF0ZSBlZmZvcnQpLgpAQ3lyaWwgZG9uJ3Qgd2Ugd2FudCB0byB0
ZXN0IFBPU0lYIDIwMDggKDcwMCk/IE9yIGV2ZW4gMjAxNyAobm90IHN1cmUgaG93IHRvCmRlZmlu
ZSBpdD8pCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
