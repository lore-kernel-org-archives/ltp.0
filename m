Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F21EC433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 15:04:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F38C43C9340
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 16:04:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E87C03C015C
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 16:04:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0C04614010D6
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 16:04:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14BFE1F397;
 Tue, 15 Mar 2022 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647356675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErvCGCxbxZuvbzhrVmpOxCErKkVm/5f31Ec+XXECqH4=;
 b=ERbzpohSaV5OlZFsxPqTya5PBEVWiLVyhr+rZ0/GR7WmncXEp7QPGF3eyYM9C9UBJyO3Vv
 TKlfIEFwzViU/7I1byOkeCj8c6mMQpvXU3CsqB8EOJ9R/nqQ5NAA49nxh+S5JFIh1ccKyj
 7EuKkwl8VPg1Ubf34bYakzrs7+cmFXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647356675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErvCGCxbxZuvbzhrVmpOxCErKkVm/5f31Ec+XXECqH4=;
 b=bmLld/l4aK0XcIE2AE2felaHbs7GQlQYUnOo+9MgeB3puhMDgUhGRJaylUw7NZLa64o+Jz
 F8dfsUpqBS8kWaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02D8E13B66;
 Tue, 15 Mar 2022 15:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5po9OwKrMGIiGwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 15 Mar 2022 15:04:34 +0000
Message-ID: <f7972d11-de50-d9bc-3abc-dcba53dc3936@suse.cz>
Date: Tue, 15 Mar 2022 16:04:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220309164954.23751-1-mdoucha@suse.cz>
 <20220309164954.23751-2-mdoucha@suse.cz> <87o8275lbi.fsf@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <87o8275lbi.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for CVE 2021-38198
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

On 15. 03. 22 15:19, Richard Palethorpe wrote:
> Hi Martin,
> 
> Martin Doucha <mdoucha@suse.cz> writes:
>> +	if (isdigit(buf[0])) {
>> +		sscanf(buf, "%d", &ret);
> 
> checkpatch complains that the return value is not checked. Also it wants
> you to use tst_parse_int.

if (isdigit()) above ensures that the return value does not matter. But
I'll change it to tst_parse_int() in v2.

>> +static void disable_tdp(void)
>> +{
>> +	if (!access(TDP_MMU_SYSFILE, F_OK)) {
>> +		/* FIXME: Is this sufficient to disable TDP? */
> 
> What happens if this doesn't work and TDP is enabled? I seem to have it
> enabled and the test still passes even if I comment out the call
> to disable_tdp.
> 
> I'm wondering whether it will be easy to tell if a test failure is due
> to TDP or if it can result in silent false negatives?

AFAIK, the kernel bug was fixed before the tdp_mmu sysfile was
introduced. So somebody will have to revert the fix and run the test on
custom kernel to answer that question.

The bug is not reproducible with TDP enabled.

>> +	.save_restore = (const char *const []) {
>> +		"?/sys/module/kvm/parameters/tdp_mmu",
> 
> This needs updating to use struct tst_path_val.

Yes, the patch was sent before the .save_restore structure was changed.

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
