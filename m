Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5281C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 17:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF4E3CDCCF
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 18:09:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 151903CDCB1
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:09:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2F5711A0121A
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:09:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21B8021B12;
 Fri, 25 Nov 2022 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669396175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtHInUo7KO4Fj5DZmbmZ1RhBeeRmZQR+3ptsYaUeoho=;
 b=shvDR9ECnbsc5cgGG5RKVz5RQrQyS3CIRcQyWVJ6oyoq8jidePZXChW1NAQZF0tn32edIM
 xeMRetBiYVyFx/xPl9F57l2AlUVASH74xBvrbsdOOza+htnHdosK8pXn9JDl1CunYz2AJM
 IWoHaH6wfmcxOOswj/q5lBPhKRpcm64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669396175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtHInUo7KO4Fj5DZmbmZ1RhBeeRmZQR+3ptsYaUeoho=;
 b=Lkls1rOIyuGfMDE8Oph34cZkZJC85aJZaCLX4vsltIzvWvDh3ao5T9QrR80gU0GlMEDit9
 pboTmak2tQagOADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E81013A08;
 Fri, 25 Nov 2022 17:09:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1PWhAs/2gGMpOwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 25 Nov 2022 17:09:35 +0000
Message-ID: <8fb62925-43ff-92d2-d310-b78d24b06d21@suse.cz>
Date: Fri, 25 Nov 2022 18:09:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221125153453.19323-1-mdoucha@suse.cz> <Y4D066q2R/0S2xFe@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y4D066q2R/0S2xFe@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Implement tst_setup_netns() helper function
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

On 25. 11. 22 18:01, Petr Vorel wrote:
> Hi Martin,
> 
>> +void tst_setup_netns(void)
>> +{
>> +	int real_uid = getuid();
>> +	int real_gid = getgid();
>> +	int nscount = 1;
>> +
>> +	if (!access("/proc/sys/user/max_user_namespaces", F_OK)) {
> Out of curiosity, this can happen only on old kernel, which does not support
> user namespaces (kernel < 3.8) ? I guess there must be other case,
> I suppose you would not bother about 3.8, right?
> 
> Also asking that if not readable we don't TCONF (int nscount = 1).

This is very much still happening on kernel 4.4.180 even though user 
namespaces are supported and enabled by default. That's why 
tst_setup_netns() fails with TCONF only when max_user_namespaces sysfile 
exists, is read-only AND the value inside is zero.

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
