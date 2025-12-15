Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12153D41D74
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765784039; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8Uz8p9/vcEibs3KxTK7tEXjrciLRfm8jdTebuacN1sQ=;
 b=Ob1jjxoYQg0aUhYZfBx5SuBNcryWYAsid1lIyNG9V1fgqFb7eS4Qqi6+JscOYb9qge64I
 qFf1oIm0bowjKRgKDrNLtx9hCbIbCmqcjycpYws7CY1vAKJMmAwbEHo948xyiQdcgDwq/xR
 XCbzDKeplRFiN7DF6rM4jXxXAxN130o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 718973CF773
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 08:33:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D0703C02B4
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 08:33:36 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D50F61400075
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 08:33:34 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso796810f8f.1
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 23:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765784014; x=1766388814; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=modCWqVcj4nbJ2GZhndfgXBAgIBum57JVFl3OKZw/RY=;
 b=clhAs19DHEZlEAiBzxfSnnO9ec2AEC7uOMzOJsoVSFXJ+krxVt4X6xyQd9avKIjIH+
 pYQdOoHu2KNdSFqBuvlbfvLL8COGb/+iQTxjmUrqANkOL7yMCKcSiMV27CWoZSA8g5pH
 2HMg0z06zfmZksu+6UZzI78QeD/4JodsAAybPHHGmMhd7ZlUgIyi6IGlyMF8JAhfrUma
 ndj189sklcaZjGNzyTefO2KAqzBLZAyBM1DJxRPHZokhCQAzIQwvkD8KbccvoAOMVIcE
 6KxXyKRYA+pdP7JiuyPX6GjlSaXJyZ92u2rq1tZxVJyjHgnBxgL02P+tNVAiuR4kvrfm
 6VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765784014; x=1766388814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=modCWqVcj4nbJ2GZhndfgXBAgIBum57JVFl3OKZw/RY=;
 b=tglNYyS4riyJLt6xJ0dKezfrL8Tfos3iEx/b9WT5khxdJpvGG0zcCkrI86dRM250Tn
 colNzhsE0o9Y++vZWb21cD3RpbuqgGVfr+OHASqiPD8rnKFvl7NepOvXlNkOPq0s0kQQ
 CzIxpZ6wOEiWaY1HAUbQFbwiRoIdccOKUEQx5DNM4nDr3X5EA+cev2mN4keZrCut4LmH
 ZgkBNvqlHkrQI3Ciiu8aFTXCSvYoi2a3yrCYbRGy8bSwqvditMlJofiX12Dm3zaGNnTT
 +sZcsTg39s2dDzTylDa1QOMHhPHSu1xzzQUn16kNCEq7wb6c0KBPEcIH9HAOM3kMDjZP
 v/LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVieZ/0G5CmetXXKO/GgnIp87CnDSDaxtznRZNZvmgyDByD0NVrCFsGQbOstemDrjuycIY=@lists.linux.it
X-Gm-Message-State: AOJu0YwO1oXhQBUQniqvHYT/laTF96viU8TFAcC+vQkHIoWy+0vw31Qe
 TzbGt+yVg0F4hfOWhUotqk0E0lLJG+PcO/oxZhn4tnDEQJG6wextodOgc1eq5Q8LdA==
X-Gm-Gg: AY/fxX7Iy+73FlqWWOcbuli9SDobhf1Ku5FJKMX4roA+/1af07dQHkL8BAqDsQc+02C
 IFlofvIU5qOlykkaIC/myzienhcfknC4DPEC508ydinLVqw+Ra92HM3SPL4Unz/4WTc3vI+iTiA
 8PqN9MHCuGUfobkDpmwu0uq3JwWqqoatz1YTVzDUiZDcBw2PoWF5pSkyC6ohQD1318WiMbD6v9s
 bBRkSjaSxShUBUpTBvnlU0thNHy2DtwSkfyqnp3jmP64pznlmb+4eAUgm+p3yIkcFtc8vtNRyDO
 CN32KbcJklSC9uYHM6YgPhExvKUGZQ9DWbAAH37fk6H1KnQSa7SIxX3jcAqH75El3PSdQBjKwK6
 RqCbN1/ljTEZq5VBZfPLxkrAMDJBK0CKKSIBt+HcVl7FmYn0+pc56xH2tUrhPCmaaUMGxsZdOD7
 r7WaCz2YzSNZ0JIqIwQrQkKX4NfHyy
X-Google-Smtp-Source: AGHT+IFbigBsN3Hwt8Dr94UMVaQWw9M+Kf+Un1H0sb4zusUGbb76UYihGOVGq/75brqCbCVcCTi0cQ==
X-Received: by 2002:a5d:584c:0:b0:431:a0:7de0 with SMTP id
 ffacd0b85a97d-43100a07f2cmr589239f8f.35.1765784014040; 
 Sun, 14 Dec 2025 23:33:34 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f280cf30sm13169003f8f.3.2025.12.14.23.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:33:33 -0800 (PST)
Date: Mon, 15 Dec 2025 07:33:32 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com> <aTvu4GJBC_G5kSNi@yuki.lan>
 <20251212111618.GA125889@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251212111618.GA125889@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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

On Fri, Dec 12, 2025 at 12:16:18PM +0100, Petr Vorel wrote:
> > Hi!
> > > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > > index da5314c50..67553f65d 100644
> > > --- a/lib/tst_test.c
> > > +++ b/lib/tst_test.c
> > > @@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
> > >  	return tst_dev_fs_type();
> > >  }
> 
> > > +bool tst_cmd_present(const char *cmd)
> > > +{
> > > +	struct tst_cmd *pcmd = tst_test->needs_cmds;
> > > +
> > > +	while (pcmd->cmd) {
> > > +		if (!strcmp(pcmd->cmd, cmd))
> > > +			return pcmd->present;
> > > +
> > > +		pcmd++;
> > > +	}
> > > +	return false;
> 
> > Once again, we should tst_brk(TBROK, "Unexpected command '%s'", cmd) here since we asked for
> > something that we haven't checked for!
> 
> Good point. I'm sorry to overlook this in my review.
> 
> Also, strictly speaking tst_cmd_present() is only defined, not used. The commit
> is about changing .needs_cmds from char array (string) to struct tst_cmd.
> Therefore it could be in a separate commit. We don't have to be too strict, but
> given how many tests needed to be adapted adding tst_cmd_present() is somehow
> buried with other changes.

Thanks all for detail feedback. Let's me give some explaination why skip
tst_brk in above function:
tst_cmd_present will be used in latest ioctl_loop01.c and it should not
use tst_brk otherwise we will brk out of test in setup() too early.
The new support needs_cmds.optional in current patch is used for support 
tst_cmd_present scenario in ioctl_loop01.c.
Correct me if any mistake.

ioctl_loop01.c code:
static void setup(void)
{
        parted_sup = tst_cmd_present("parted");  <=====

.....
        if (parted_sup)
                SAFE_CMD(cmd_parted, NULL, NULL);  <===

        sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
}

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
