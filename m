Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1B3FD3762
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772029840; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1PdavH8/z+Fj16Caeet9iC6nP5n8ayYMZv2NcL9zm0A=;
 b=Qjm4czwmIM6l0lDXR4qbViYjpBCcIlAx2/4bof7MtG+9H+AEkWnovJ2FJKGdBgegFaRkL
 PbWSo7sCVZniu0RZDHbybNYw70iaontTyXHgsFBYswtR3IOwgxwGjBtmXblkgxs6J5M+Z/1
 09gc6NTrTejYbIni14qgamxqu69SJtk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5155B3C9CAE
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 15:30:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 455633C536F
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 15:30:18 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A65BC1000932
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 15:30:13 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso56813125e9.3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772029813; x=1772634613; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fl9fBtFn37czdR/y9Dm0fLGsdzOpbnLQ6s7tAjcTtkU=;
 b=L199axCsnGEhReuCoM86l7atnhpa3cpd/ZBEbCjq5UWeMdHzc5U9GG75bgJjRoqrXV
 n5YRSrcc99J/BxkiNBmriJw4I9zPVlmNwvtxTFqN1qpzFx3xHBbYnb+x4xLI63fVVnMU
 ThMbWAEQ6OqKj4ydM/4f44LkNT67LrYvJMvXuFOsJMN37AjwRavYAqHQmlxZZYH91qrv
 0r9WMMV1QHOmyk4J2cAuPaOf/ZF9Nr49FIolaeYyR38U7tNwJv+DmbI5WBdgKGD7dSPY
 0WhZffVzqEvHv/TFLtQT/1h4oO6PEi8z+zw7KG9GD/3HlONr+NMX/2gS52VFE4iL2Asw
 zrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772029813; x=1772634613;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fl9fBtFn37czdR/y9Dm0fLGsdzOpbnLQ6s7tAjcTtkU=;
 b=XlljxSgEt9XfGCbj7y8IT6hdwob+KUGyHgHBaxEEaUSolZDUOjpa8ZJoeNyKYyd3dw
 OydiXet4SK1cZvMnnpTmtBE3T0QKtVxrYySHRWVV2826y5tgKGTRzPpsYd5kuK/4AKUv
 k7I3E56z6krGns4eX9DCGWYHEVaUKt0+SQqhBDNPaE3UNRZ8APTB6v6m2srKqehvg4NS
 U1mVd3/NWc/4mDvwspi0atgUP26Udo4/6AtIx2z0Ur5kDqenk/GuIa6VCTO/5c4/vVS+
 mvgEqsQ3i8WDiMSWToob7xsLGLIYZsDaeSSLZN/2oOsPLi0yTeI/1Ng8R8Xr/ghXF7lT
 cq1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUepB2WxVmaotctXtn+tAEEW14Afi7N2fqHdGckRqNPwywy9q1iEZJpaxo4igP0rzl8+aE=@lists.linux.it
X-Gm-Message-State: AOJu0YypUFcRlW7JQPqLE3pYZb2BCC0rYh640lv/QetXGvpI23IGvDkt
 QcIr4t1NWR0XJ8chez61bq97Y9nNVNxgBFdqrsj6gfffMlaskZjxNrsxkq4/m/UC51oJg0Dpc9F
 Suf/+OiU=
X-Gm-Gg: ATEYQzyZS7dt5DA5RVqaWqn3CdKzfoNQWK9t//XN9rpM3yVU7mawRYY31hPSXWyhfM1
 wrDZzosE9bAthTyTCkbFWixsiqfmcHsKuxsB0XoMSIzCDZNwqNod4AO3Duqc5py6dfiO7SdSSM4
 LC/n4qCejwlgCTMdi3JOokpGhukdO8/M21fu3Cj+CrUvy42FbfqnEsSyJ2sD8tpQLqa3aqvyncH
 GC4i86BJSgH3HBQ1mxZPPMtaPSr8GfUXpVqkA3F19qFV5SwOEE7h/TP2hCNofWDcRkz1cR9OXSv
 x9iEnT5ou4b2dnZ60F94OSg0cg+v5mW54fCFpsU3wnIPEOhnK5fzZPtn7lXOl9NrZoHL6J0Ksyd
 E8J7k2Hp2FqBNNyUMwOiEAbBgNmHYcAPJjxiQYpCiqhH7uPXBAaiqF1OzgUqS24cziRhUMsih1k
 HwPcwGjjrYqOZWziqIPHC9wQWe
X-Received: by 2002:a05:600c:8719:b0:47e:e807:a05a with SMTP id
 5b1f17b1804b1-483c21b6a1emr9467255e9.33.1772029812965; 
 Wed, 25 Feb 2026 06:30:12 -0800 (PST)
Received: from localhost ([88.128.90.40]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfabb84esm45992855e9.0.2026.02.25.06.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 06:30:12 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 25 Feb 2026 15:30:11 +0100
Message-Id: <DGO4558ZMLNH.3U00SNOHLUVXJ@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <DGN98XP7WAZD.310XXFFOA9X2R@suse.com>
 <20260225131922.5723-1-always.starving0@gmail.com>
 <20260225131922.5723-2-always.starving0@gmail.com>
In-Reply-To: <20260225131922.5723-2-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fstat: add test for multiple file types
 using fstat
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> +
> +static struct tcase {
> +	const char *desc;
> +	const char *path;
> +	const char *macro_name;
> +	mode_t exp_type;
> +} tcases[] = {
> +	{ "regular file",   REG_FILE,  "S_IFREG", S_IFREG },
> +	{ "directory",      DIR_FILE,  "S_IFDIR", S_IFDIR },
> +	{ "FIFO (pipe)",    FIFO_FILE, "S_IFIFO", S_IFIFO },
> +	{ "symbolic link",  SYMLINK,   "S_IFLNK", S_IFLNK },
> +	{ "character dev",  CHR_DEV,   "S_IFCHR", S_IFCHR },
> +	{ "block dev",      BLK_DEV,   "S_IFBLK", S_IFBLK },

Makes more sense to merge desc and macro_name together. Then see below:

> +};
> +
> +static void verify_fstat(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +	struct stat buf;
> +
> +	int flags = O_RDONLY | O_NONBLOCK;
> +
> +	if (tc->exp_type == S_IFDIR)
> +		flags |= O_DIRECTORY;
> +
> +	fd = SAFE_OPEN(tc->path, flags);
> +
> +	SAFE_FSTAT(fd, &buf);
> +	SAFE_CLOSE(fd);

You can just use:

	SAFE_LSTAT(tc->path, &buf);

Otherwise test will fail with:

fstat04.c:74: TPASS: Expect: regular file: macro matches
fstat04.c:74: TPASS: Expect: directory: macro matches
fstat04.c:74: TPASS: Expect: FIFO (pipe): macro matches
fstat04.c:74: TFAIL: Expect: symbolic link: macro matches
fstat04.c:46: TBROK: open(chrdev,2048,0000) failed: EACCES (13)

> +
> +	int is_correct = 0;
> +
> +	switch (tc->exp_type) {
> +	case S_IFREG:
> +		is_correct = S_ISREG(buf.st_mode);
> +		break;
> +	case S_IFDIR:
> +		is_correct = S_ISDIR(buf.st_mode);
> +		break;
> +	case S_IFIFO:
> +		is_correct = S_ISFIFO(buf.st_mode);
> +		break;
> +	case S_IFLNK:
> +		is_correct = S_ISLNK(buf.st_mode);
> +		break;
> +	case S_IFCHR:
> +		is_correct = S_ISCHR(buf.st_mode);
> +		break;
> +	case S_IFBLK:
> +		is_correct = S_ISBLK(buf.st_mode);
> +		break;
> +	}
> +
> +	if (is_correct)
> +		tst_res(TPASS, "%s: %s() macro matches", tc->desc, tc->macro_name);
> +	else
> +		tst_res(TFAIL, "%s: %s() macro does NOT match", tc->desc, tc->macro_name);

We don't need an if statement here. We can just:

	TST_EXP_EXPR(is_correct, "%s macro matches", tc->desc);

> +static void setup(void)
> +{
> +        fd = SAFE_OPEN(REG_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +        SAFE_CLOSE(fd);

Just use SAFE_TOUCH() in here, so `fd` can be removed also from the
static variables.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
