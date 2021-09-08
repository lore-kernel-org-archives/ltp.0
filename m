Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC35AC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 08:50:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84846115C
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 08:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E84846115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2DC93C914B
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 10:50:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1E483C222D
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 10:50:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BF3C710011AA
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 10:50:00 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D00AE1FD2D;
 Wed,  8 Sep 2021 08:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631090999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lh8VNLMuvevp2QJZue+gkUW0QXTwVrBMNproJ8y+Oqw=;
 b=otIb9XR7ESfOmgXskioc2Vz/UmBRoPfZ6aJ64HhF07/KYbk8STkuPyrSMeP56natHTCo0/
 zSw4bXikE5kS1qEgwg9S9b7IgX4TOqw7XJVdfASQAvwVqLhJ8LY6Mc5jvtOeJLbzXDxe2f
 OGRmHLkqu7Y7YGn5ZvPIPUH6hv+WII8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631090999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lh8VNLMuvevp2QJZue+gkUW0QXTwVrBMNproJ8y+Oqw=;
 b=kl8FFvx0efWAKPKnA1bn2ifo9pRzGLyvCgNS/+nL+s4u/zznTbhdzpKsMnc7Rq+ffUzO6t
 VXbyl+0JCeuocaCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B9A4C13A64;
 Wed,  8 Sep 2021 08:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 7tRCLDd5OGFrWgAAGKfGzw
 (envelope-from <mdoucha@suse.cz>); Wed, 08 Sep 2021 08:49:59 +0000
Message-ID: <5b7f4a92-983f-2a7b-21f3-f9e2110bc0c2@suse.cz>
Date: Wed, 8 Sep 2021 10:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 Cyril Hrubis <chrubis@suse.cz>
References: <1630897958-2160-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <613864D4.5030400@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <613864D4.5030400@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] runtest/cve: Fix wrong cve tag
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210908084959.LoJwHwd0cLdPSVNg_-BAZYWAuhBS7UeKhUYZbeqYaxg@z>

On 08. 09. 21 9:22, xuyang2018.jy@fujitsu.com wrote:
> Hi Cyril, Martin
> 
> In fact, Look the following url:
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3609
> 
> It said nothing and seems this cve number doesn't exist.
> 
> Do you know what happen?

This vulnerability is tracked under this CVE number in SUSE Bugzilla and
RedHat security portal:
https://bugzilla.suse.com/show_bug.cgi?id=1187215
https://access.redhat.com/security/cve/cve-2021-3609

I didn't check any "upstream" CVE databases.

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
