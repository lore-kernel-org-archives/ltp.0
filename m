Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFBBCA5534
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 09:45:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 909FD3CB2F1
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:45:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 730B53CB29F
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:45:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 74D4A601BA7
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:45:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7F171F45B;
 Wed, 13 Sep 2023 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694598320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8UwqQkHu9tyVwDwM3hpvncAEQXvCBONStZ4P66E6QE=;
 b=vCRDlTrHzhpWjZzHD+k9xrIt8VtlfBHH8d9kc3jMG1csKPDecUqIUvKYijvu+RFS+7X+zw
 bK07IGR8ysjY9lpfi5lq6VGFMnyxxbYgG17U5LBLh40QCzrzPggCuZxyAmsh9GX2TvWxVM
 ZAbzCc/C6lxFLF4YICICFwTCyUn+/x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694598320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8UwqQkHu9tyVwDwM3hpvncAEQXvCBONStZ4P66E6QE=;
 b=NpFLZgnf1MSltldH6ISzB9ggI+AQOBaj9U7KoAA1vB/cVN5a1l3tQFVCWdH402NFa3Zf7i
 4wdN/TgiFzJnHsDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5D2B13582;
 Wed, 13 Sep 2023 09:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id esCdJ7CEAWUXTQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 13 Sep 2023 09:45:20 +0000
Message-ID: <f81446da-805e-0db0-39c2-afbc63ea396c@suse.cz>
Date: Wed, 13 Sep 2023 11:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <ZQF5J0UJ25_QLwcQ@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZQF5J0UJ25_QLwcQ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 13. 09. 23 10:56, Cyril Hrubis wrote:
> Hi!
> As usuall we are supposed the release LTP at the end of the month. In
> order to get at least two weeks of pre-release testing I would like to
> freeze the git starting next week. I will try to review and merge as
> much as possible till the end of this week. If there is anything that
> you think should go into the release let me know so that I can have a
> look.

Hi,
I'd like to include my tcindex01 simplification patch in the release.

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
