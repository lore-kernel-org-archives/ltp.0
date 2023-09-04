Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8DFC83F33
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 12:09:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 742DA3CEBFB
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 14:09:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 201FB3CB899
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 14:09:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63FDB200BA1
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 14:09:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0C21F38C;
 Mon,  4 Sep 2023 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693829348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBkJyftbbOvG1ISQlH6H4oclfkKIjFabeditGVuRWZM=;
 b=Q4lGM5nhwVC0NeiisQkGJJo+8Ho1AbYTT0DtRAB4BUiHPbIdGaEx/1gV5yLQYooxEn+Y4P
 CqiiHe6vkfOoW214ohscgED+V8HdgdMJGaxySkCUsAUu31qzytk885czFOHoGnxwwOszWZ
 9xwJC6PJw8vQN6f086crrfmVKM5qPyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693829348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBkJyftbbOvG1ISQlH6H4oclfkKIjFabeditGVuRWZM=;
 b=yNhWyOntJDyWeYV63BL5fDDBSbdGS6PYwirU6INWCkwoi/8+Q7cWRimAhbHL2iKLXhvglz
 ShFUblU2ciawPsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6148513425;
 Mon,  4 Sep 2023 12:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id y1XPFeTI9WQNXwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 04 Sep 2023 12:09:08 +0000
Message-ID: <c6a1d445-af46-3b9f-83ac-b82306d197d9@suse.cz>
Date: Mon, 4 Sep 2023 14:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Nageswara R Sastry <rnsastry@linux.ibm.com>
References: <20230904065643.32590-1-rnsastry@linux.ibm.com>
 <ZPWpRFy4-T0vVzWv@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZPWpRFy4-T0vVzWv@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_lockdown.c: Add PPC64 architecture support
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

On 04. 09. 23 11:54, Cyril Hrubis wrote:
>> +	#if defined(__powerpc64__) || defined(__ppc64__)
>> +	SAFE_READ(1, fd, data, 4);
>> +	#else
>>   	SAFE_READ(1, fd, data, 5);
>> +	#endif
> 
> Here as well, the ifdefs has to start at first character in the line:
> 
> #if ...
> 	SAFE_READ(...);
> #else
> 	SAFE_READ(...);
> #endif
> 
>>   	SAFE_CLOSE(fd);
>> +
>> +	#if defined(__powerpc64__) || defined(__ppc64__)
>> +	tst_res(TINFO, "SecureBoot: %s", data[3] ? "on" : "off");
>> +	return data[3];
>> +	#else
>>   	tst_res(TINFO, "SecureBoot: %s", data[4] ? "on" : "off");
>>   	return data[4];
>> +	#endif
> 
> However all of these cases we can just define a few constants instead of
> cluttering the code with ifdefs.
> 
> #ifdef ppc
> # define VAR_DATA_SIZE 5
> # define VAR_DATA_OFF 4
> # define KERNEL_KCONFIG1 "CONFIG_SECURITY_LOCKDOWN_LSM"
> # define KERNEL_KCONFIG2 "CONFIG_SECURITY_LOCKDOWN_LSM_EARLY"
> ...
> #else
> # define VAR_DATA_SIZE 4
> # define VAR_DATA_OFF 3

I'd also recommend using named constant for read size and offset. But we 
only need one constant. The read size will always be VAR_DATA_OFF+1. We 
don't care whether there's any additional data after the the byte we 
want to check.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
