Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEA0C4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 11:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545253CD5C5
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 12:39:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2E013CD565
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 12:38:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F3E551401169
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 12:38:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E1202281D;
 Fri, 11 Nov 2022 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668166738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEmm155eJ9BZOWb3XqsbH8qckd4c5RS3Lpg2KRD8VJc=;
 b=VuR+bM/na1Wj+ukRJwwcyHIh94dChpk9+A6tmAqJLjNw6tagpVGjq0rjAKeFBqO48vzNuv
 XOUSDD1CVkvbfNqzxfjMvYtRy36j6SAF5MR94mzn91lKewPAA0VZ6hD9T2oYoENqtaOvN5
 mZXfIZ9EKa1T++D7tiIzCVeYEaZJpy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668166738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEmm155eJ9BZOWb3XqsbH8qckd4c5RS3Lpg2KRD8VJc=;
 b=idcxDanuU8zCujA++LHmjJClNVPkNVat/1hpLdvRFGKQ1Q2zb2L7dOVIfCdv1Mz4eJ9dDu
 RKvh5jMdo3YKxsCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F36213273;
 Fri, 11 Nov 2022 11:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZdVuAVI0bmObLAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Nov 2022 11:38:57 +0000
Message-ID: <af0b15a0-b433-0e72-8d39-89dde3d7987d@suse.cz>
Date: Fri, 11 Nov 2022 12:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>
References: <20221103164550.7037-1-mdoucha@suse.cz>
 <CAEemH2di5wCY-M+EUGdovSRWU2zvminpuVpBBP_FiU3U8KDw0w@mail.gmail.com>
 <CAASaF6yv-EeEfqCFgwYk2Sw-NM_-yaQTOM8+zUQSKb8dw_DOxQ@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAASaF6yv-EeEfqCFgwYk2Sw-NM_-yaQTOM8+zUQSKb8dw_DOxQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Introduce new struct field for flags
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

On 11. 11. 22 10:47, Jan Stancek wrote:
>> For example TST_SR_IGNORE_RO, I was puzzled a while when
>> reading it in the below code, it can be thought of as ignoring the
>> READ_ONLY permission if just from the literal meaning.
>>
>> We need to find more precise names.
> 
> Would TST_SR_SKIP_RO be clearer?
> 
>>> +
>>> +#define TST_SR_REQUIRED (TST_SR_FAIL_MISSING | TST_SR_FAIL_RO)
>>> +#define TST_SR_IF_ACCESS (TST_SR_IGNORE_MISSING | TST_SR_IGNORE_RO)
>>
>> Here as well, especially these two will be more frequently used in testcase writing.
> 
> Maybe TST_SR_COND_ACCESS - which slightly longer

Sounds good, I'll send v2 with both flag changes shortly.

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
