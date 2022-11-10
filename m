Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F7DC4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 14:30:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEFFC3CDD75
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 15:30:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 202F33CD693
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 15:30:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B69A41000924
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 15:29:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6532C22B1F;
 Thu, 10 Nov 2022 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668090599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSoHOmzTZ7gyugDunrFhNTTXk+eDJFT7wutdb5qE/V4=;
 b=yXF3lDzzMVRtYMe3I/VsD4IKEm75UaJ5QfI3RonL1KcnZUfc5xdfKFc+6i5UkElQYF0XPr
 eLcYy9cRJNaU5lh+l7wj843bJBbi9jRw3sSEzpoOFwGiQzWEIMwdKxwljGTABQITsExefl
 CPDsRYmO5RI6AjbLNaHnf+4ll4Ni3jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668090599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSoHOmzTZ7gyugDunrFhNTTXk+eDJFT7wutdb5qE/V4=;
 b=EgyI714T6tUZz1AjDUTvOwd/8MuzWjnjMmnnJQSzKTpLOXqVATmznpl+KRDKmOwaKSnp8O
 lU/jZqa3lka1YEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E0FC1332F;
 Thu, 10 Nov 2022 14:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nDlMBucKbWOvJAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 10 Nov 2022 14:29:59 +0000
Message-ID: <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
Date: Thu, 10 Nov 2022 15:29:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Minchan Kim <minchan@kernel.org>, Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y2l3vJb1y2Jynf50@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
 Sergey Senozhatsky <senozhatsky@chromium.org>, ltp@lists.linux.it,
 linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 07. 11. 22 22:25, Minchan Kim wrote:
> On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
>> Hi all,
>>
>> following bug is trying to workaround an error on ppc64le, where
>> zram01.sh LTP test (there is also kernel selftest
>> tools/testing/selftests/zram/zram01.sh, but LTP test got further
>> updates) has often mem_used_total 0 although zram is already filled.
> 
> Hi, Petr,
> 
> Is it happening on only ppc64le?
> 
> Is it a new regression? What kernel version did you use?

Hi,
I've reported the same issue on kernels 4.12.14 and 5.3.18 internally to 
our kernel developers at SUSE. The bugreport is not public but I'll copy 
the bug description here:

New version of LTP test zram01 found a sysfile issue with zram devices 
mounted using VFAT filesystem. When when all available space is filled, 
e.g. by `dd if=/dev/zero of=/mnt/zram0/file`, the corresponding sysfile 
/sys/block/zram0/mm_stat will report that the compressed data size on 
the device is 0 and total memory usage is also 0. LTP test zram01 uses 
these values to calculate compression ratio, which results in division 
by zero.

The issue is specific to PPC64LE architecture and the VFAT filesystem. 
No other tested filesystem has this issue and I could not reproduce it 
on other archs (s390 not tested). The issue appears randomly about every 
3 test runs on SLE-15SP2 and 15SP3 (kernel 5.3). It appears less 
frequently on SLE-12SP5 (kernel 4.12). Other SLE version were not tested 
with the new test version yet. The previous version of the test did not 
check the VFAT filesystem on zram devices.

I've tried to debug the issue and collected some interesting data (all 
values come from zram device with 25M size limit and zstd compression 
algorithm):
- mm_stat values are correct after mkfs.vfat:
65536      220    65536 26214400    65536        0        0        0

- mm_stat values stay correct after mount:
65536      220    65536 26214400    65536        0        0        0

- the bug is triggered by filling the filesystem to capacity (using dd):
4194304        0        0 26214400   327680       64        0        0

- adding `sleep 1` between `dd` and reading mm_stat does not help
- adding sync between `dd` and reading mm_stat appears to fix the issue:
26214400     2404   262144 26214400   327680      399        0        0

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
