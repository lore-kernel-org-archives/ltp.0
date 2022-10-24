Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7426FC38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 09:03:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF7FA3C945D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 11:03:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA7CB3C0727
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 11:03:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4B489600681
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 11:03:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6AE101FA95;
 Mon, 24 Oct 2022 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666602200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKD7W8xMrOcd6/zLL+2D/+bowipK3eXNCC/TH/XNNG0=;
 b=NSyEEVZ4R4MxKNzNNxLXAk60Gl+tA9WYDbpbVA36ZoV/9Nfa7Prk63RQUJHly+Dp6OkfDj
 BGY8ZLFCRIzHPrp2NdFWgBzNs0o6kbW1TTbdqwPAEcUXiKKuoHoQCDuVXfLgLGAVmYchB/
 JopQnhSwL6t36IxlYpqqNB90IcYPKs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666602200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKD7W8xMrOcd6/zLL+2D/+bowipK3eXNCC/TH/XNNG0=;
 b=KDAxUNTKKz7EIAwEkep0STqIwDltY1SgMy/6yA8bGY39dpVEFfTeLTLwi1RyV0FIfuG6zj
 teDllTdDTWemtOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54D1313357;
 Mon, 24 Oct 2022 09:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id reTHE9hUVmN/YgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 24 Oct 2022 09:03:20 +0000
Message-ID: <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
Date: Mon, 24 Oct 2022 11:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Amir Goldstein <amir73il@gmail.com>
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 21. 10. 22 21:03, Amir Goldstein wrote:
> I don't have a vision of what you are proposing.
> Make a proposal and I will see if it is correct.
> 
> I must say I don't understand what it is that you are trying to improve.
> All the test needs to know is if the specific combinations of flags that
> the test uses are supported by the kernel/fs.
> 
> Trying to figure out which of the bits from a specific combination is
> not supported? how does that help users?
> Maybe in kernel 5.10 flag X is supported and in kernel 5.11 flag
> Y is also supported, but only in kernel 5.12 the combination X | Y
> is supported? Do you see why your generic function doesn't make
> much sense? or is just too complex to be worth the trouble
> for an informational print?

The function I'm trying to write is supposed to check whether a 
particular flag is implemented by the kernel. Whether a particular 
combination of implemented flags is also *allowed* is out of scope.

Note that the test I'm writing this for is fanotify14, which checks that 
various invalid combinations of flags will correctly return error. But 
since the error code for "this flag is not implemented" and "this flag 
was used incorrectly" is the same, I need to somehow get the fanotify 
feature set so that I can skip test cases which are not compatible with 
the running kernel. I don't really care about which specific flag is not 
implemented, comparing flags against a bitmask is just a quick and 
convenient way to check that running the test case makes sense.

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
