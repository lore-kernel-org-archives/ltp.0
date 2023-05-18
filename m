Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197F6C7EE23
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 08:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81B763CDC23
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 10:38:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EF393CB2AC
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:38:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0837110009F7
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:38:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DD92226FE;
 Thu, 18 May 2023 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684399082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yqfnbgn6nvNoKjfeusvCdpwIsPR4LlK/Yq5Q34xHpAI=;
 b=0rsi28mAP2QI7eY2+gTwL7ndoGJ92xTTfCaNFCW9LbUxwXIBxk91G4u2P8+mNqTX+USr7f
 r3BtupyYS1TJR2t/N442Dk8VAJVhVgEdwQUICM16UeCi6Zo5CpmGT7lqmiE+jM1vX+VsBk
 gzLbLXa5SVcGXdMSJnkux6s0oDSqec4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684399082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yqfnbgn6nvNoKjfeusvCdpwIsPR4LlK/Yq5Q34xHpAI=;
 b=vfd/C0fc4770MOM6H4u+809IBb4vVSYcA4EvV5xulJ/2EUgyA7QDXDe5DnUavHC9u3LZuf
 f0P3ELJ1VcslLbAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 135751390B;
 Thu, 18 May 2023 08:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ukXbA+rjZWTCPgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 18 May 2023 08:38:02 +0000
Message-ID: <a2faae19-778f-a41f-a487-bd4faf67aee1@suse.cz>
Date: Thu, 18 May 2023 10:38:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-7-mdoucha@suse.cz> <20230517232054.GE8914@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230517232054.GE8914@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/7] KVM: Add STGI/CLGI intercept constants
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
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 18. 05. 23 1:20, Petr Vorel wrote:
> Hi Martin,
> 
>> +++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
>> @@ -39,6 +39,8 @@
>>   #define SVM_INTERCEPT_VMRUN 0x80
>>   #define SVM_INTERCEPT_VMLOAD 0x82
>>   #define SVM_INTERCEPT_VMSAVE 0x83
>> +#define SVM_INTERCEPT_STGI 0x84
> SVM_INTERCEPT_STGI is not used anywhere.

I know. Let's keep it anyway. But maybe I should also add SVM_EXIT 
constants in v2?

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
