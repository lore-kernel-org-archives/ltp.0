Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2E6C38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 13:28:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F94D3CA5AE
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 15:28:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76393C4FA0
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 15:27:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 603B21A00A49
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 15:27:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67A6B1FD66;
 Wed, 26 Oct 2022 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666790877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/81ubhsuKXlHZP9HUoYhiwyxhDLDAkkAU2islL6f4V0=;
 b=kkxKh92Gg+i4Aywfz9Dohh8SHxk4n60H6HWkuYXcGet2h2Xn9XAt0sdxhXZ6A3M0nVv7nm
 41Uvw4S6RoKTgqw2q9Rr43GmpP2AliPoiKLndi0NU3GpzKK7bRTvmt1x5IGzyy0eBDLAWY
 r70vC4mPQk1+w1EoIVxtYamztnhISrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666790877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/81ubhsuKXlHZP9HUoYhiwyxhDLDAkkAU2islL6f4V0=;
 b=Isx0RyamDEwk6ESQLNheg6fiZL+nI6mghx0cDrIvW8BAs5z7KbmJdJyXHVSvfVM5kzgBwU
 vIF1vr+cJS15XIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4640B13A6E;
 Wed, 26 Oct 2022 13:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fJ2FD901WWPvYQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 26 Oct 2022 13:27:57 +0000
Message-ID: <c2da7b52-7728-eb00-5c1d-87a35e7402cb@suse.cz>
Date: Wed, 26 Oct 2022 15:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Jan Stancek <jstancek@redhat.com>
References: <20221021155740.8339-1-mdoucha@suse.cz> <Y1MCbP1yjLOuoPLb@pevik>
 <CAASaF6ySEcVE=b-7nGy+FeLyg_6dNMjL6J_bivjZ6JYzSx5b=w@mail.gmail.com>
 <3f3dca4e-79d9-9e5b-293f-f27c6644dec8@suse.cz>
 <CAASaF6xHrcko8Wcq_UAaLY9hscYZAGrSSJe=P07HYoOFXaoTyw@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAASaF6xHrcko8Wcq_UAaLY9hscYZAGrSSJe=P07HYoOFXaoTyw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Check whether path is writable
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

On 26. 10. 22 13:29, Jan Stancek wrote:
> On Tue, Oct 25, 2022 at 6:13 PM Martin Doucha <mdoucha@suse.cz> wrote:
>> It does affect all 3 but slightly differently, depending on the "val"
>> field of the respective .save_restore item. The current implementation
>> behaves like this without root privileges:
>> - (no prefix): If val is NULL, the test will save the data, run the test
>> and trigger TWARN at the end.
> 
> Is this real scenario? Why is test saving sysfs value, which is then
> never changed?
> I would expect that in this case, you could drop save_restore entirely.

Some tests use simplified sysfile handling and only write a string 
constant passed in the .save_restore array. These have problem with lack 
of root privileges because the write happens in library code. Other 
tests write something non-constant in setup() or run(), these can handle 
read-only sysfiles themselves.

> The case 2) looks like it could apply to non-optional paths too. So maybe
> best option would be to drop "!" and "?" prefixes and turn them into flags/enums
> which can be then combined together.
> 
> "/proc/sys/kernel/pid_max", 0, val // TCONF if path doesn't exist
> "/proc/sys/kernel/pid_max", SR_MUST_EXIST, val // TBROK if path doesn't exist
> "/proc/sys/kernel/pid_max", SR_MAY_EXIST, val // if exists, save it
> "/proc/sys/kernel/pid_max", SR_CONST_VAL, val // if already has val,
> skip saving it
> "/proc/sys/kernel/pid_max", SR_MAY_EXIST | SR_CONST_VAL, val // if
> exists check it already has val, otherwise save it
> 
> What do you think? Would that make it easier to represent/implement all cases?

Sounds good, I'll prepare a patchset for that.

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
