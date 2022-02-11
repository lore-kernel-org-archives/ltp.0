Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8168C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 13:30:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7160E3C9F13
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 14:30:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0CC3C9B4B
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:29:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E2D10601EE9
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:29:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BBE21F3A2;
 Fri, 11 Feb 2022 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644586193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovV3ECxqjxV08mD3TcQtrFW3KsA+HppPMuwirIQt5RE=;
 b=pJA77T2VTavBvu8xHfkpTMTqDj1p36yNWL94fbMcP+4/gUhI4LWPjE/tGlQOnO3yLCvquE
 qKN5Chkwz+dH2ohZFRNiYhd62KOO0/s+sgd9It0FEVeTPcjI4lwJuf3/i1z0UeDw+VbwCe
 jAtLYC1yfnbMiiVsLrrMbhkuvzbU1yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644586193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovV3ECxqjxV08mD3TcQtrFW3KsA+HppPMuwirIQt5RE=;
 b=TsRenDYuZNFvwvtM6t9cfC7eaQOgOlk7kM/bbi+Kcurjw8QFmjSXAN7eo6er6SKMXUfyy5
 i/Su19XYt5m+2UAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07A6013C87;
 Fri, 11 Feb 2022 13:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 74TkANFkBmIvEAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Feb 2022 13:29:53 +0000
Message-ID: <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
Date: Fri, 11 Feb 2022 14:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220211114401.24663-1-mdoucha@suse.cz> <YgZcu4frLBaKVXL2@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YgZcu4frLBaKVXL2@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Terminate leftover subprocesses when main test
 process crashes
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

On 11. 02. 22 13:55, Cyril Hrubis wrote:
> Hi!
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -1495,6 +1495,9 @@ static int fork_testrun(void)
>>  		return TFAIL;
>>  	}
>>  
>> +	if (tst_test->forks_child)
>> +		kill(-test_pid, SIGKILL);
>> +
> 
> Maybe we can even print a message here if the kill() returns with 0,
> which would mean that there were any leftover child processes killed.

Feel free to add a message during merge.

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
