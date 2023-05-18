Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2052EC7EE22
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 08:28:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C91E3CDC1D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 10:28:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 013DA3CB29C
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:27:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2B74E600801
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:27:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F2791F74D;
 Thu, 18 May 2023 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684398471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G42JUmhmz60od1HztAQvt/RGw8pFCo+d7rOWCOMYFZs=;
 b=e5KZB0oF/m6ZQH1cQTYpOnqp7oBJqHGzDP6tuabOMLEGr5Lm5Le36JNhKpGCiwXEK9s/rB
 BO+qeCFmrMCMqtS8ujw2+VZZ6YwWPMAG/Ow4d2c4z++PiqbBXBfz4HQpn2phBkfprTXZNB
 wf46Wptm2XyoGyTTrCuT+fiUzoX0H08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684398471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G42JUmhmz60od1HztAQvt/RGw8pFCo+d7rOWCOMYFZs=;
 b=MGOYriwyJCbAdOq91KXmUP7b8pIx2pb3BLL0qct3UHxr0MhKJ4cT45RLeWFy6wb3P0gkAl
 LvNw9bfPOChyGnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 332D91390B;
 Thu, 18 May 2023 08:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kkB8CofhZWSOOQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 18 May 2023 08:27:51 +0000
Message-ID: <f7f3ffc0-2455-b7ab-531b-04d7974c7164@suse.cz>
Date: Thu, 18 May 2023 10:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Petr Vorel <pvorel@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-2-mdoucha@suse.cz> <20230517220827.GA8914@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230517220827.GA8914@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] KVM: Add VMSAVE/VMLOAD intercept constants
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

On 18. 05. 23 0:08, Petr Vorel wrote:
> Hi Martin,
> 
>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>> ---
>>   testcases/kernel/kvm/include/kvm_x86_svm.h | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
>> diff --git a/testcases/kernel/kvm/include/kvm_x86_svm.h b/testcases/kernel/kvm/include/kvm_x86_svm.h
>> index 965d1e716..3eb832849 100644
>> --- a/testcases/kernel/kvm/include/kvm_x86_svm.h
>> +++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
>> @@ -37,10 +37,15 @@
>>   /* SVM event intercept IDs */
>>   #define SVM_INTERCEPT_HLT 0x78
>>   #define SVM_INTERCEPT_VMRUN 0x80
>> +#define SVM_INTERCEPT_VMLOAD 0x82
>> +#define SVM_INTERCEPT_VMSAVE 0x83
>>   #define SVM_INTERCEPT_MAX 0x95
> 
>>   /* SVM vmrun exit codes */
>>   #define SVM_EXIT_HLT 0x78
>> +#define SVM_EXIT_VMRUN 0x80
>> +#define SVM_EXIT_VMLOAD 0x82
>> +#define SVM_EXIT_VMSAVE 0x83
> It looks like these three aren't used anywhere.

Yes, the SVM_EXIT_* constants are not used. I originally wanted to use 
them in one of the checks but then decided against it. But let's keep 
them anyway since they'll be needed to handle the intercepts in future 
tests.

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
