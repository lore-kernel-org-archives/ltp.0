Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3698C531D0
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 23:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784850869; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=b3TN/m0uOQdM9t+YPUtODAtPQmxYTHLuAGq4TVFmhxA=;
 b=pu7i+vroxpoaZbs9SQKhQyTKdgAcIIlM7P5u9GhuGzUxpHga7ETZXgCXU1aiLxtbIe2/1
 m8Mr83waMDCtUG91WeQsD4OjpaOW7duGEgNW/1lBr/fzoUnkHUg7nGQp4xn/5RZjzptbtBc
 pgTCT2/qLM5gg6ZUC8ofx87wvDNXFEY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C591A3E93E3
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 01:54:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8F503E688E
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 01:54:09 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A3601A0099D
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 01:54:08 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso337381f8f.2
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784850847; x=1785455647; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SEpF369ihAeL6oDKP/w4/F6ucm38kgdv3gJLMiof4wI=;
 b=NlGX4KOvr3sluEe8NX+4AI7vjuBIYPe7OtTINse8EzbjETR4Loos3EXgJzXxfeeauI
 XPdUU81qM3OJjbdF3pT0EWWTKYIEHhgyOZ+B5CZgx6u5FLnhIsEB293d2aWExJyoE6Lb
 WZKCnQx3QjGyVy4baNcCRjPpiosUKCPPfqHJkEKjY6GaBC+vuMxAk703Sk/H+BgYj0PV
 eLOpqZkZQcDvcdkcz5RnsautP9u2BXF19OIiToYeFMynOD04Uo9kSMQigc+CySzMO1Ch
 FwrmpqPRlb7RRGjI3L09rpp0UsM32BDZAtHyXgwYisaCJYVQogf8uMb6eCsHnV23/zve
 IVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784850847; x=1785455647;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SEpF369ihAeL6oDKP/w4/F6ucm38kgdv3gJLMiof4wI=;
 b=iMIz++WYqv29S4HiuwGbgiLwZ3iV39QLyrVEmzAdW7aYUUHc8BFc0S5SYyp2OarziC
 4LWQcxUsGh6pTmgIbXVo3RyS/zGhq2Cjt7wWqqS/PEnRVYxk3eurjLspO+s6iMFw48jV
 2SnC7DOMQEyQWEJTWbBuk2jgzssCI8UJi4cEexLWcV2XDGap0CbxQfBZR181pgn4bPPC
 w33RG/9xJS2ZcQZU6ntGy/PqAhkEzwLFx712AGldrrGzswO4EQA6bx4rmRb/aytUjdBd
 SyboUolk+6fdeTOaWD0UnU5tQ43IDhz9z3YWyuGhU7Q8HJLJiHlYRyl2zcXdrlxsmkyF
 WuAw==
X-Gm-Message-State: AOJu0Yzdq2puiJkocrYGo0On9VSIc2j6eULLHq5pwVbpp+x9o4l5xUno
 BFYhnk9kNB/+gOuPIwMENeC3fg2Eis1tPyTwFCu5Q/AAI4CDh9UnUUgxICK3wQgoIPq77Lw0DG2
 4mBA=
X-Gm-Gg: AR+sD13BGY646/x2BUZSfLznG1ui4wFAQSassI0nAHulIEigc7G6dQFCDY2A6sV8CJl
 MQrVHNz7yqMpq18eo6s6Jlyd1lI69xjXIWdWyqYZCblGiTDcEGsxxSD8yKJxXgVH8luxkByfEFG
 QLLM5MFjtacBmeOPntNyBFHzH3XKvOn0YUoZZs8Yvks7WclDlIx7NUrT9paE3G3CQVmESevYKh7
 l0nkK/EU4B7GQo8JzBOg/HPZbgLNGeIJX8m9Z3dNPtrLnS16q0FUGwsGASFGBzu9IQ/MADyWWPy
 RXVozzwExbgp7uZlcICmENk4h+Wwm8Z+v5y9n5Q9mH/ONI2eG+bb4yQ4eeug31MOR8/tN6U3w00
 y9PUQRwJ3NAq69M7DvO80kUvSfyX8tLdT3zx0kP4/tTmHyzj/J5mx1EFcdllRZBW0yk1hU523XB
 djRQcWUf1QLn+peWb2w5s=
X-Received: by 2002:a05:6000:238a:b0:472:9bf7:2f58 with SMTP id
 ffacd0b85a97d-47f8dc863c4mr6816387f8f.36.1784850847450; 
 Thu, 23 Jul 2026 16:54:07 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm19253581f8f.19.2026.07.23.16.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 16:54:07 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:54:05 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <amKpnQVIE1jjhY79@autotest-wegao.qe.prg2.suse.org>
References: <20260722044732.3547-3-wegao@suse.com>
 <6a620c6d.d5b2c389.2916d0.903b@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a620c6d.d5b2c389.2916d0.903b@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 2/3] lib: New library function tst_get_free_uid
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

On Thu, Jul 23, 2026 at 12:43:24PM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> > +/**
> > + * tst_get_free_gid() - Find a GID not assigned to any group.
> > + * @skip: GID value to skip (pass 0 to skip none).
> > + *
> > + * Scans the group database for the first unused GID starting from 1,
> > + * skipping @skip. The @skip argument can be used to ignore e.g. the main
> > + * group of a specific user in case it's not listed in the group file.
> > + * Calls tst_brk(TBROK) if no free GID is found or a lookup error occurs.
> > + *
> > + * Return: An unused gid_t value.
> > + */
> 
> This documentation is out of scope and should be sent from an another
> patch-set.
> 
> > +		errno = 0;
> > +		if (getpwuid(ret))
> > +			continue;
> > +
> > +		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> 
> This contradicts the patch 1/3.
This line is same as patch 1/3, could you give more detail where
contradicts?
> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
