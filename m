Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7130EC433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:29:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 248493CC681
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 13:29:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DFAD3C288D
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 13:29:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D1E5C1A002D7
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 13:29:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 163D821B50;
 Mon, 28 Nov 2022 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669638582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VI6L2RUEZ9Q4aDsnNGw0/n2bkmLqZxkmhga07glLC4I=;
 b=E01Kjplt5ZUNtjDl81MidyEEV4SvbwR4L3eK2Xeoe9qFRSTxes2S03Gog7psnnjHHPL8Wk
 OXlrX5+fEIckAe9MYD/TVpa1CCwv7l25l8kWnzIBoynllmYiP5aI9LK3q3fXadNq3embxl
 8I/0G7v75UUld7muZ4bsr1egC5gu5lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669638582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VI6L2RUEZ9Q4aDsnNGw0/n2bkmLqZxkmhga07glLC4I=;
 b=OixHkTETWSDkD4P1aikG203MmOA2pQ9rSXwtLa6St4vOfmrBlqI5VDdYlm9XMDZcNeQSIR
 vvshb8AwdysWpMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3EC41326E;
 Mon, 28 Nov 2022 12:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /6rEOrWphGPPYgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 28 Nov 2022 12:29:41 +0000
Message-ID: <7f71a2c3-a66b-b442-3785-3e251ce2f781@suse.cz>
Date: Mon, 28 Nov 2022 13:29:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, David Hildenbrand <david@redhat.com>
References: <20221128111833.98937-1-david@redhat.com> <Y4SiDZXCSqMafjIb@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y4SiDZXCSqMafjIb@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] userfaultfd: Fix and remove compile-time
 TCONF handling
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

On 28. 11. 22 12:57, Petr Vorel wrote:
> Hi David,
> 
> If I remember correctly the reason for runtime check was ppc64le
> missing userfaultfd minor fault support which needs to be check in runtime,
> right? [1]. At least this is how I understand Martin's suggestion [2] to replace
> compile time check with lapi. I'd state this reason at first commit message as
> it's not obvious.

The reason for runtime check is that the presence of the header file 
does not guarantee that the kernel supports UFFD API. The reason for 
LAPI is that we only care about actual kernel support, not build-time 
header files.

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
