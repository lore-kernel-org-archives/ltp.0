Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCD5C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 11:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54ED63C968E
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 12:28:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C04B33C1810
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:28:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C079F1400BDD
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:28:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 203C31F37E;
 Wed, 19 Jan 2022 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642591681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roygM69t8NULLF4hz25t3vizbnyOorlm6G/suPnrldw=;
 b=jTrVQoTV2EtJrDjEpZuIT7Gy8S+EdeZWAM9KQxOvfqc9+NQFPaGX+769eSfFi0dTOc7Mdh
 nSPPJGyiR6b+3gCtILsefpEZrYN8PLp+n4wLDDjfhUyEB+rScFo/o9+kQAJE1IcHU9Dsp6
 +A5uXtS02N4oVYv8UtLQA10bhnPQixk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642591681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roygM69t8NULLF4hz25t3vizbnyOorlm6G/suPnrldw=;
 b=6g9Vu+ptS7Fq4+4fAYuh92jTX2zZZtfNzhctXWPrKC4/waWBcGLQt+3pe/X6jOIAXUdjN9
 8WuQxajJPmtZ4sBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05FCD13B31;
 Wed, 19 Jan 2022 11:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +p90AMH152E+agAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 19 Jan 2022 11:28:01 +0000
Message-ID: <0bd9af6b-9750-134a-8740-8017103ca4ee@suse.cz>
Date: Wed, 19 Jan 2022 12:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220119111533.8356-1-mdoucha@suse.cz> <Yef0lBQ5aryeC5ew@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yef0lBQ5aryeC5ew@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite statx04 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 19. 01. 22 12:23, Petr Vorel wrote:
> Hi Martin,
> 
>> ...
> 
> I'd put this into commit message (can be done during merge).

Sure.

>> +	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
> Before merge we should cast to prevent "comparison of integer expressions of
> different signedness" warning:
> for (i = 0, expected_mask = 0; i < (int)ARRAY_SIZE(attr_list); i++)

It's better to fix that by changing the type of "i" to size_t or
unsigned int. But GCC could easily deduce that one of the values is a
constant well within the range of signed int and not bother us with the
warning...

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
