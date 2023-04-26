Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ACAC77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 08:09:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 546823CBB58
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 10:09:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 635663CB306
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:09:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C028C140098C
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:09:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F97A21A04;
 Wed, 26 Apr 2023 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682496581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbq1dRDd9V9LVfvtCVuNlO57xFB9SjFx9mo3E1UsR3g=;
 b=uSSnwp9HBxPQPY2iLJYWdW43rgFSomXag1HYOEkr4au7TGRmvB9fd/WgU4zoAl6yfg/jQR
 WmB/lPCNBq19C2sUwZDAK1XGyIVjpitxlT6dyHxYzcDxcFDZJdkr8jHQoKCPMINMzpxa9m
 6jmDD6H6BjWGtx6/9kKPH8RUZhkL9C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682496581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbq1dRDd9V9LVfvtCVuNlO57xFB9SjFx9mo3E1UsR3g=;
 b=S4o58HpbFjqWV76JFZlrGTqc6YXgaWAka/t6ic0/hKTZ+aMaR+4K6yfjpwlvSooqX7m67c
 Y3trj+KzieJntaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7043713421;
 Wed, 26 Apr 2023 08:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EB6dGkXcSGRcDgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 26 Apr 2023 08:09:41 +0000
Message-ID: <aceee5d2-9d31-ff77-3b41-55aefefbb1b4@suse.cz>
Date: Wed, 26 Apr 2023 10:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230421145746.5704-1-mdoucha@suse.cz>
 <20230421145746.5704-3-mdoucha@suse.cz> <ZEjZcgJMluP0eEie@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZEjZcgJMluP0eEie@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] KVM: Fix infinite loop in ptr2hex()
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

On 26. 04. 23 9:57, Cyril Hrubis wrote:
> Hi!
>> Contrary to the C standard, (x >> 64) is equivalent to (x >> 0) on x86.
> 
> As far as I can tell right shift larger than the left operand size are
> undefined, at least in C99.
> 
> Other than that the patch looks good.

You're right, sorry. Should I send a v2 with fixed commit message?

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
