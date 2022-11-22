Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91AEC4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 14:56:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EBA93CCAE6
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 15:56:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C55C73C01D2
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 15:56:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9C726001EA
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 15:56:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8ACF91F85D;
 Tue, 22 Nov 2022 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669128985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+loFO6tN5YXsk0bWjK2r+zKhS9ssoaTjODd0fLpHxXw=;
 b=sfmdqwbLKiTiB7Qi4AyDhjDIvCEMbXR1ZfivjEs/BqcOHbuhw+kprIf2xHCaCTwObQH8a5
 CKtGZ10w9JYjpD8IToot/jXIPHYlpgW+5ZS0wbEgEuQpU+1AM+/uz+jrOhnvYaznSjFawR
 lulkdeUJ9jy+oIMCVvY3OEkd0qOvieo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669128985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+loFO6tN5YXsk0bWjK2r+zKhS9ssoaTjODd0fLpHxXw=;
 b=y42N2ZaNchVaRcELYmUf0n2LuOWXFda2EadO5JNkazxeFEBiX8E/BXEGx+KtlEgs/tzmrX
 8ds0XUjamiBkMUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5594413B01;
 Tue, 22 Nov 2022 14:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e3sDFBnjfGMdBAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 22 Nov 2022 14:56:25 +0000
Message-ID: <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
Date: Tue, 22 Nov 2022 15:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y22b3wWs2QfMjJHi@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 linux-kselftest@vger.kernel.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 11. 11. 22 1:48, Sergey Senozhatsky wrote:
> On (22/11/10 15:29), Martin Doucha wrote:
>> I've tried to debug the issue and collected some interesting data (all
>> values come from zram device with 25M size limit and zstd compression
>> algorithm):
>> - mm_stat values are correct after mkfs.vfat:
>> 65536      220    65536 26214400    65536        0        0        0
>>
>> - mm_stat values stay correct after mount:
>> 65536      220    65536 26214400    65536        0        0        0
>>
>> - the bug is triggered by filling the filesystem to capacity (using dd):
>> 4194304        0        0 26214400   327680       64        0        0
> 
> Can you try using /dev/urandom for dd, not /dev/zero?
> Do you still see zeroes in sysfs output or some random values?

After 50 test runs on a kernel where the issue is confirmed, I could not 
reproduce the failure while filling the device from /dev/urandom instead 
of /dev/zero. The test reported compression ratio around 1.8-2.5 which 
means the memory usage reported by mm_stat was 10-13MB.

Note that I had to disable the other filesystems in the test because 
some of them kept failing with compression ratio <1.

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
