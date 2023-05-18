Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E5DC7EE22
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 08:29:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556C83CDC19
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 10:29:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43D073CB28E
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:29:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B16262000E1
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:29:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C86E1F74D;
 Thu, 18 May 2023 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684398580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0q8Gl+/vK82VyZD0yg2AaS8mW/lmodThDWkojUTlJrg=;
 b=Cp85wjudWGpFqWsSo0OooKPYAxnWiC8Ow09Ya48ttt4LEEaaLwmKYgOrRSQOako2DJzbnq
 lCdiDxhCZQtxpPOO/rpm3C+8FLZyM9FVhmIZOKi3+jD6oFjrgsdV8pTXY8yAvF5OJy7NAB
 QcN0umLB0bq3PNb430Q0PBGqTwHkDGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684398580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0q8Gl+/vK82VyZD0yg2AaS8mW/lmodThDWkojUTlJrg=;
 b=AS2Td7aKzrDNJFyxwPj9j6KDT6KLaBWlJQPsPHOB+uR+cl8ssdA2sTuweohr9hEjiXFauG
 IZxWPryIgliQnOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3824B1390B;
 Thu, 18 May 2023 08:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Jc+GDPThZWSeOgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 18 May 2023 08:29:40 +0000
Message-ID: <c2b0aa7c-8cca-e6a7-38aa-a96e65d9a7c0@suse.cz>
Date: Thu, 18 May 2023 10:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-3-mdoucha@suse.cz> <20230517223238.GB8914@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230517223238.GB8914@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] Add test for CVE 2021-3656
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

On 18. 05. 23 0:32, Petr Vorel wrote:
> Hi Martin,
> 
>> +++ b/testcases/kernel/kvm/kvm_svm02.c
> ...
>> +
>> +#ifdef COMPILE_PAYLOAD
>> +#if defined(__i386__) || defined(__x86_64__)
>> +
>> +#include "kvm_x86_svm.h"
>> +
>> +#define AVIC_REG_ADDR 0x280
>> +#define AVIC_TEST_VAL 0xec
>> +#define AVIC_READ_FAIL 0x12ead
>> +
>> +#define AVIC_INFO_MASK ((1ULL << 32) | 0xff0)
>> +#define AVIC_INFO_EXP ((1ULL << 32) | AVIC_REG_ADDR)
> 
> These five constants aren't used at all.
> Maybe copy paste from kvm_svm01.c ?

Yes, the AVIC constants are leftovers from copying kvm_svm01.c, sorry 
about that. Should I send a v2 after other patches get merged?

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
