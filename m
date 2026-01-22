Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570C4C44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769084345; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RrQkvRUlom4Fd9ydDCdVa1tvS7tJqRizrwVihXx62vU=;
 b=EocOdxyjYFmefQitt/ukD6OnZF99YfjWxfqp6Fzpj4At0n/Y/Bds30eIDs1IxSJrjdfqJ
 A+TTG7TVmDpv+9K6SylOe3iU5lTTwyisf9P5ga7y730v5QlxYEYlNgBk7JrmPbImRteGK4v
 +qwRTjZKBqH/Dd3iO5GiARVIJ1fsvAM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E72983CB40D
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:19:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C53D43C015D
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:18:41 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 561D9200B36
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:18:41 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so750599f8f.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 04:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769084321; x=1769689121; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fO+DpWOWnGcbdfDs+MfIJhRgdleHQ/NMq0/yMtnV11k=;
 b=gKFVMiaW1aYxgXmrm7Qb99L+1iaDmwuhwTAMUL68Zg0G7nUddNJ7TfMQ7BCqSGFVpL
 nl4GT4dznYwFxsfeMob6Wy/eldlrbYPRxQGUAfMCiTe/LljGZuRDRYtQsgJZefJpAUpU
 irivLabPgYpB8mU7A9QRISgfxRFgDF5VO5H4BolNBbNLMzpFGVTAqdT1cIW01Rf0ebNM
 JqcQjbViqBXfK+DOM92OFNhe9fMEoF8ZM5llTQs/D4n5HwHf55TgXZh84WXmatllivHN
 urrB7MCX8tfFZ4knARZXe8nNAoA9G0IwdBAROkoy8nXElkDTvHxoinnc2t07CEfYRoQZ
 +7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769084321; x=1769689121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fO+DpWOWnGcbdfDs+MfIJhRgdleHQ/NMq0/yMtnV11k=;
 b=JebKQwALzSkl/YGZFpjT1lmFX4v3CB3i4OkhM/3sdDqTE6hC+NNGdBI0jqQV5CIUvN
 Ax8Q3T8F78LlGO38zzUJnssbOdLU++/FBcWd9aTqf5mRT2iNBpTktauAcCRRrrxbeUIl
 i4o5sNUjmjQfszeKAnHzStYSUbymbDgOwCICz/ZvD5ZAH/jhZVrdDjgUXW2rCtGuVmcM
 qFs0+YUfRowi3jfssYXwsP5Yby1LUUPFAAa5oktlytBxs0x4je4xvBZnVEu+t5cYg13E
 LC7zxx8CoIoZiJ+9Wx3lJWhfiO6Lz8q7fJU75OqBQ1NHm5BRHitwwaBDUOUkzsBv9zcz
 FiBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu8T8nv87E+TgUxtk/Lagm3ipnr1C7sq9p0Cs/aVoDX13gU5qN7KGyjobqZzT4ZjYcQKM=@lists.linux.it
X-Gm-Message-State: AOJu0Ywv8eOFZZ8kvVz2hbiHIDQXQyDQ1V67XQ/pkgz5I05GSmxZpH1I
 nPi3Ud5G/WknUgAxoX+5wS6YE3ggouvrpo3Vsw7C9PChuAYic6mdEeHBtpUdbpLJOQ==
X-Gm-Gg: AZuq6aI0jhSt+nxYUQmBW01QzLW6Wjb3LENB4nPyKNyEtsduDhHauGcqSk+YD7jTlIJ
 fyFq4dJU8eSdunTeQlOzBSc3nA+FD6fCczJg7aLBoLXhOaXL4OW1xnUTcf0uuc6YQGtCjV6S9A8
 J52bVZLrY1zP1AIDgWdGJy46yrSYo/q5gZowXHqXE4AHhm6bjv9WDDqe5qzFoypcZV32drMppOm
 zGcZUi9slyDLCc77cdTPBte9XgVaNzAn4AoG8NaR6o8YdYjeD2kBTx111RWkpU9Bv32XPM+bTNM
 /dHd7FWol2jO0o0j2zw+lf8SP3xXFPjL8cVona/mm1IA4W4dut9Nofl3FHdzIXF9wbYrpl92xBE
 PWMS/XYOEt9JFhrPs3enZs2uWl+iTxxNuXDRK5IUt4q7a4t1aaavyT6vGSM+TFOZSuftC91sJRX
 Whdbb7RWd1JreuECgL5goXHtPgMAmo
X-Received: by 2002:a05:6000:2f83:b0:432:5b81:480 with SMTP id
 ffacd0b85a97d-4356a03d2demr32712232f8f.24.1769084320481; 
 Thu, 22 Jan 2026 04:18:40 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435966322a2sm15362249f8f.38.2026.01.22.04.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 04:18:40 -0800 (PST)
Date: Thu, 22 Jan 2026 12:18:38 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aXIVnsZ54238nLbs@autotest-wegao.qe.prg2.suse.org>
References: <20260122111810.91411-1-liwang@redhat.com>
 <20260122120604.GA64562@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122120604.GA64562@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vma05: fix the needs_cmds format
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

On Thu, Jan 22, 2026 at 01:06:04PM +0100, Petr Vorel wrote:
> Hi Li,
> 
> > Fixes: 39a28444272 ("lib: Add support option for .needs_cmds")
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Wei Gao <wegao@suse.com>
> > ---
> >  testcases/kernel/mem/vma/vma05.sh | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> > index 34a82162c..b9654e80c 100755
> > --- a/testcases/kernel/mem/vma/vma05.sh
> > +++ b/testcases/kernel/mem/vma/vma05.sh
> > @@ -26,7 +26,14 @@
> >  # {
> >  #  "needs_root": true,
> >  #  "needs_tmpdir": true,
> > -#  "needs_cmds": ["gdb", "uname"],
> > +#  "needs_cmds": [
> > +#     {
> > +#       "cmd": "gdb"
> > +#     },
> > +#     {
> > +#       "cmd": "uname"
> > +#     }
> > +#   ],
> 
> Good catch, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 

Thanks!
Reviewed-by: Wei Gao <wegao@suse.com>
> Kind regards,
> Petr
> 
> >  #  "save_restore": [
> >  #   ["/proc/sys/kernel/core_pattern", "core", "TBROK"],
> >  #   ["/proc/sys/kernel/core_uses_pid", "0", "TBROK"]
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
