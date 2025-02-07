Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245B6C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738933452; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=LAZblI/HdUzRq3xBQtOybPKPtIWLbeN5JiuFMfrzGBA=;
 b=GCBOMkLNBc/Ng2SRX0+w2nW2b+dGJHj47sfSID5T0B/NvosyzYo7bxg5YGdI4hiFHX1I7
 omWAbVwuhi1JC3AbHLNW9neVIv/uDTocKtmxmxtbXynxLR0ADW0CotY0fUE2C5+WpWz2G/U
 +fsFSc3H60GpxUrXNyYWEsonkfcjHGk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C8E13C9378
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 14:04:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA1C13C19E8
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:03:51 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1ED81230B34
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:03:50 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso13950895e9.1
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 05:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738933429; x=1739538229; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6NjDfCqKisj4rwq6Zd+aBDky5pB2FbWImR6f4CdHa8U=;
 b=fwvnPvi/5/hiSHApC/jBhoECdZzsPE+UgRjAx+1DKRUSAu5zxrzf71TuUVkhMx9ZiP
 x7UV4FsAALYM/xE8qWmve6S9gE8+BYZyfEGgRBzY3uJbj2VUsnhbAjYjGYhVA8nT+WU2
 BaHZKpkOUZ4qWAE+J5p0Gz10V0GtcYLPQDM57hwZUd5ZajNbm90EJT/4e/E6z/Q6Aw2B
 0UIaiXCspgNYpSqe/W/BeHyM2wzBYiFRKc3sqfe40xQNowT6yE8zy9rfaUvCwTOHAHOy
 5UjxlMip3i/S/3XgoELv2WhSKvAiYJ1KsLAa+c2hts8I7qXIC+W8dnFo5Mpro5hLlaMl
 mPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738933429; x=1739538229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6NjDfCqKisj4rwq6Zd+aBDky5pB2FbWImR6f4CdHa8U=;
 b=Pts2aTdvohzkux8s81X4/3A9/TY7SXJVgD09jcndKmwpvNc+7NPQi0DlKvfQeg0aF0
 NhVqBJyxs8QoI9R/D3Wv4krYfDTzn9fkqeYrCFm1yDfo+JoESJuVcScXqWW/vVxRy+yL
 L9fqVXQJ+lT+Tltu2aQ35gmfqd4IdRFyJuhkbHYYyHHXofjNZ6dvLmXwY12o3R3vTIM2
 zX00P2R8+4EEBIEdiCTUc/zAQdqesfOXwl2DZo4b3+h0nWNc0MzAcC3+nNQAs/Q+qtj+
 97ZBRM+Nm3cAKdokX4+HuJpDVOzMNg903yxTduX3raoTvPZTWx7S6tv4pPxb/yAKU2PR
 r5sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSOuqfOZ4JCR0UVS/MCvKD5mZdBnSRhHZbhsO0QmyiBozk3giqjS3c4+8KZ6ip1Cguv+E=@lists.linux.it
X-Gm-Message-State: AOJu0YyfS9hnrfWRhX59aUWhJaTLwb1epCmubVo4DNvcDWXlagCb7Hhq
 37g3nMRK2AwJ+9lxXG4YMXwlyCu4yQm5xBN1QHnqMHv0GXkupm0RjEIgHBjGXNy88lB+ubQXI9c
 mBc0H7A==
X-Gm-Gg: ASbGncseJLtk32Ui8QlhTiT5RuwK5vHvlP5QCcDs8neZPFH7bmGuri6YUHsIOimIe3G
 xjuF7z0R+r7AC/w204uBL+QkIbQOq87cPVfM6fQEStrfeQMKIpulomWFZYspUz134eWWp56yt80
 TF2KTYjHKXu5YJZhnJ2yUTrf3aJM9NGAiBlJGx75lze5r4MCsYM5FN8hGo0L/4UiYw8uUkmOUTg
 3q+8yNLf2j/jIlRZnl3B42txS314iMgtTH9KwYgSeeyOa3mlIEa1k+5IwNzFKC0rwK7C05a/9js
 9SpZ2xlcuskCppAQHt6rzXLOIg==
X-Google-Smtp-Source: AGHT+IHtG9ls9B+tUOrhpveRiFRIJq2Ys0jkoYVYQOSeOP9ow8ykVz7cTsMAVxRalufV8F5W/C04GA==
X-Received: by 2002:a05:600c:a0f:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-439249a898bmr24171105e9.24.1738933429299; 
 Fri, 07 Feb 2025 05:03:49 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd23sm4423494f8f.71.2025.02.07.05.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 05:03:49 -0800 (PST)
Message-ID: <6ecf5daa-95e3-43b9-9d04-fd7d2b2a0778@suse.com>
Date: Fri, 7 Feb 2025 14:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250207105551.1736356-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250207105551.1736356-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/6] Remove asciidoc{,tor} doc
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2/7/25 11:55, Petr Vorel wrote:
> Hi,
>
> This is a follow up for Andrea's 1bf344a3db ("doc: add tests catalog page").
>
> Besides these changes I plan:
>
> 1) Configure readthedocs to generate html/pdf doc for user to be able to
> download it.
+1
> 2) Generate html/pdf documentation as a part of the release process
> (build it locally with sphinx), to be able to add it to the release
> as we did with the doc generated by asciidoc{,tor}.
This is a bit tricky. Did you try already?
> 3) Andrea refused to do have virtualenv support in Makefile.
> https://lore.kernel.org/ltp/3032b376-8f7a-4b1c-8422-f5a61e59b680@suse.com/
> I would still prefer to have it, as optional, when some variable is
> passed to make. It's better than copy paste the commands all the time,
> also it would help 2).

Yeah, we can have sphinx + dependences packages installed in the system, 
via pip or using a Dockerfile. virtualenv is just an optional tool we 
don't want to be dependent from.

>
> WDYT?
>
> Tested:
> https://github.com/pevik/ltp/actions/runs/13198229443
> https://github.com/pevik/ltp/actions/runs/13198229440
>
> Kind regards,
> Petr
>
> Petr Vorel (6):
>    create-tarballs-metadata.sh: Remove metadata generation
>    github: Stop building asciidoc{,tor} documentation
>    ci: Don't install asciidoc{,tor}
>    doc: Replace docparse info with sphinx
>    Move docparse/README.md to metadata/
>    docparse: Remove
>
>   .github/workflows/ci-docker-build.yml     |  14 +-
>   ci/alpine.sh                              |   2 -
>   ci/debian.sh                              |   8 -
>   ci/fedora.sh                              |   2 -
>   ci/tumbleweed.sh                          |   3 -
>   configure.ac                              |  32 --
>   doc/developers/writing_tests.rst          |  13 +-
>   doc/maintainers/ltp_release_procedure.rst |   6 -
>   doc/maintainers/patch_review.rst          |   4 +-
>   docparse/.gitignore                       |   5 -
>   docparse/Makefile                         |  69 ---
>   docparse/testinfo.pl                      | 526 ----------------------
>   lib/tst_test.c                            |   4 +-
>   m4/ax_prog_perl_modules.m4                |  77 ----
>   m4/ltp-docparse.m4                        | 118 -----
>   metadata/Makefile                         |   9 -
>   {docparse => metadata}/README.md          |   0
>   tools/create-tarballs-metadata.sh         |   9 +-
>   18 files changed, 13 insertions(+), 888 deletions(-)
>   delete mode 100644 docparse/.gitignore
>   delete mode 100644 docparse/Makefile
>   delete mode 100755 docparse/testinfo.pl
>   delete mode 100644 m4/ax_prog_perl_modules.m4
>   delete mode 100644 m4/ltp-docparse.m4
>   rename {docparse => metadata}/README.md (100%)

The rest looks good. Feel free to push it:

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
