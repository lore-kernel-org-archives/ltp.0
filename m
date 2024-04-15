Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5FBC4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713176300; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7jtgEVAmFO0CgNGYv2UbqP54/CQP9fOj6HrcTv0VT9E=;
 b=TAfy1RQVOFIwsZrTUryGqFwn9FHtQHyKBQH5feyUzv99uUuQhWukjfQlkiAcl3ldfBywq
 nWm4R5beaIZ4F8QONpdLyXNOZNViTHse/LxV3x0inphCvkvPKoazdNK6SZ4gCS7m2hligFV
 qFhjKoOwBlXu765LbERK6WiZ1g3XpNc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42E863C1A85
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 12:18:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40BE33C0F50
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 12:17:58 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5496510009BA
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 12:17:57 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-343d7ff2350so2237364f8f.0
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713176277; x=1713781077; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4WR8ocvvTSMuFLpITK+1BaQROia32Ugzc33iKRCrwUk=;
 b=MgxMj1NQZgt5jden7tgEG/1FfPfH3F+Y9tVHhzJGVwkjcl/CFV+Q5TzgrD1+bt/oEL
 bLzLbPFKV0pKT0O8ZXIt+ZZtfQ3+IjWcENf2RHT18RUkSDhHDzxjeI9/eo9vJQKXfrYp
 EeN/D8u3DDCbvhSiXjO+dJN1UKJlk2vStwE9ZlTgJSwuMuAumTr3Lp9PCKCZyT0U6F3a
 C+iXzcMba7MJvNcuoLEyu6fucl/cPofQw+omKXCjwMABwUgd2w8dt5ukzTxgVQ//dvfc
 /QDyJoEeXoXjT7Twmo24p1cyqOWElZQQKkslW5/5tAXeHsrWRCF8YO1i0QGoxMt/hZW6
 ufJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713176277; x=1713781077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WR8ocvvTSMuFLpITK+1BaQROia32Ugzc33iKRCrwUk=;
 b=YnGfm6BCiIWwhXkNOwD3qxdb8pZVefxvp09FGCGsrhHEs6Ub+5dsO3FCaTcz37oqPN
 J6YM2YVx33zHO5f3OGeLdJrZdrfpoMlOegN0zI2jsTAnySRdNsjLp51TS6PiZn9rZqgj
 VrgMpyqlLNa3IsgUnFxQf90dJl/a0R6Od5nQabIxynS0eEi+/JcSE6X5yvKy+WpofRtq
 Z9uEdipC5xnEf0L17CDtLQfBlu4N8tYgFIybSJw/irM/iKuvR2531DHBAAI++LB6H6pf
 fyto0UGhd8r/01f2JYwmn9PKahZ1tz3Eoy1NRdrWPYvG0Jv9xRGUxUS3G8a8Pl5Sv4O5
 JzOw==
X-Gm-Message-State: AOJu0YyHOxfzHf41aartTFxKJ4U29wj46ZGPeOCo6p60puWwj1NDNxbE
 8QTU1a7IrT/VGZTSzLJcpn8qtd+Qx7D7Gd7JDB3EKd+yHxd9aC3lrQG3GnPEeg==
X-Google-Smtp-Source: AGHT+IHBsZm4WQhR8stpRnWazPvrz9KIln5LHlsQ8OXZzkhSH3T3lCSKvMg2zKfVvDjquoEOno3twQ==
X-Received: by 2002:a05:6000:1548:b0:341:72b8:83b9 with SMTP id
 8-20020a056000154800b0034172b883b9mr7208690wry.68.1713176276684; 
 Mon, 15 Apr 2024 03:17:56 -0700 (PDT)
Received: from wegao.93.165.106 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a5d560e000000b00343cc702c56sm11635720wrv.47.2024.04.15.03.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 03:17:56 -0700 (PDT)
Date: Mon, 15 Apr 2024 06:17:51 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zhz+z3qoMiwxCssg@wegao.93.165.106>
References: <20240118073215.10026-1-wegao@suse.com>
 <20240331021720.9527-1-wegao@suse.com>
 <20240403092827.GA419563@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240403092827.GA419563@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_fiemap01: New test for fiemap ioctl()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Apr 03, 2024 at 11:28:27AM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> > +static struct tst_test test = {
> > +	.mount_device = 1,
> > +	.mntpoint = TMPDIR,
> > +	.all_filesystems = 1,
> > +	.skip_filesystems = (const char *const[]) {
> > +		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
> 
> Why do you whitelist fuse? Which filesystem under fuse does not work?
I will remove fuse in next patch.

But i find fs_type_whitelist not contain "fuse", so this will lead 
func tst_get_supported_fs_type can not handle "fuse" filesystem, 
means add/remove "fuse" into skip_filesystems will not take any effect. 
Correct me if i have any misunderstanding.

static const char *const fs_type_whitelist[] = {
        "ext2",
        "ext3",
        "ext4",
        "xfs",
        "btrfs",
        "bcachefs",
        "vfat",
        "exfat",
        "ntfs",
        "tmpfs",
        NULL
};


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
