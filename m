Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552D7C77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 15:24:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D3183CD92C
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 17:24:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0EFB3CB8B9
 for <ltp@lists.linux.it>; Tue,  2 May 2023 17:24:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 687ED1A0065A
 for <ltp@lists.linux.it>; Tue,  2 May 2023 17:24:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2887F221E4;
 Tue,  2 May 2023 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683041040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CW2LmtNuVSk94mDGCMJ1mJ80jVCNsh4d9/7vaIxHDh4=;
 b=zmNqwLSpBWozv3WsgFDqblkqkj9YdB1XZJul6aUiQSjbiUCMHugcr7A/qB/Fc8IZEgsQuy
 W5QfK5czrPgcnazCSULSiL7uuPkMs+eozDD0QfQIt8ZSFFR3hmCYWD4F7G/QyyCJ5IwVwO
 NIFVSlNrRVnz1UsSSyNMx1F255/Ky/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683041040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CW2LmtNuVSk94mDGCMJ1mJ80jVCNsh4d9/7vaIxHDh4=;
 b=QPq4qeoLoFSA33UzVko5Z22yyv8ooaSf9wwviyeAHUoGDVBMTeOEUBFtQ6Gt3OJt7/tFNo
 DTzIsExRsdEGGQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9F9F134FB;
 Tue,  2 May 2023 15:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id erhcLw8rUWQGIAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 02 May 2023 15:23:59 +0000
Message-ID: <e61e2dd0-3ce6-e849-8ce8-2b9aeb236c69@suse.cz>
Date: Tue, 2 May 2023 17:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com> <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
 <Y3zlrBQ8fgJyNm7G@pevik> <Y4WMxqyVlAt0Sp3g@google.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y4WMxqyVlAt0Sp3g@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/1] Possible bug in zram on ppc64le on vfat
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
Cc: Jens Axboe <axboe@kernel.dk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
 linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 29. 11. 22 5:38, Sergey Senozhatsky wrote:
> On (22/11/22 16:07), Petr Vorel wrote:
>> Martin, thanks a lot for reruning tests. I wonder problems on /dev/zero is a
>> kernel bug or just problem which should be workarounded.
> 
> Hmm. Does CONFIG_KASAN show anything interesting?

Sorry for the delay. We've tried to reproduce the bug with CONFIG_KASAN 
enabled but the only affected arch is PPC64LE and KASAN is not available 
there at all. Our kernel maintainers confirmed that if we need KASAN to 
debug this, we're out of luck.

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
