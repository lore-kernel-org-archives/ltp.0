Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EC5C77B7E
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 08:20:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 827143CD005
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 10:20:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17D543C4BFF
 for <ltp@lists.linux.it>; Mon, 29 May 2023 10:20:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BDFC140045C
 for <ltp@lists.linux.it>; Mon, 29 May 2023 10:20:21 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41E1C1FD64;
 Mon, 29 May 2023 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685348421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0J9s2eTmyk7ahyh61tov5ZA/27xNTxqvMknVYmYo/A=;
 b=YzupmfiALwHX9B2bPVVOENTwk3qzZOOF7obvI3ozi+aMl3y/W/cLulwo/A1nK5Rgk3gEAJ
 PGm8OAzOkMklJXM7HMN8fcYkO0EvBoHV/MNs3w5X/EgPCVQuXM/oeTwI0s3ORtU3ty/l1K
 PJAnHSsAWVngKQU3LloZjvGhPR9Atvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685348421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0J9s2eTmyk7ahyh61tov5ZA/27xNTxqvMknVYmYo/A=;
 b=F403kPATxF/nEpOqGxn62kvlWi/W3AcX16JKCev6uo8Cnq623cwA9TgSwM4HlpxiCUZnox
 3NtyrHp+GbY4TtAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 28190134BC;
 Mon, 29 May 2023 08:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id G/beCEVgdGTBCwAAGKfGzw
 (envelope-from <mdoucha@suse.cz>); Mon, 29 May 2023 08:20:21 +0000
Message-ID: <0023ff26-0798-6f37-4bb8-e733bfed1fcb@suse.cz>
Date: Mon, 29 May 2023 10:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Petr Vorel <pvorel@suse.cz>
References: <20230526133435.7369-1-mdoucha@suse.cz>
 <20230526133435.7369-5-mdoucha@suse.cz> <20230529055110.GC6579@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230529055110.GC6579@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/7] KVM: Add async communication helper
 functions
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
Cc: Nicolai Stange <nstange@suse.de>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 29. 05. 23 7:51, Petr Vorel wrote:
> Hi Martin,
> 
>> Test programs using these functions must have at least two host threads.
> IMHO we don't have flags to require this. I guess KVM hosts nowadays should have
> more than 2 threads (these tests are for bare metal), thus we don't have to note
> this also in the code, right?

We have tst_test.min_cpus, used e.g. in kvm_svm03. But this is a note to 
programmers that they must use pthreads, otherwise tst_kvm_wait_guest() 
will always time out or lock up. The signaling can work even on single 
CPU unless you somehow manage to break task switching in the host kernel 
(like in kvm_svm03).

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
