Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFFBC433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 09:28:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C5D63C9F2B
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 10:28:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBE353C96B4
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 10:28:13 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED3F014044D9
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 10:28:12 +0100 (CET)
Received: by mail-yb1-xb32.google.com with SMTP id u3so489676ybh.5
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 01:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ygp7HmSMQP3Q+rbTx5g2DkVDCEdl+SFVfMjp/BmaoiI=;
 b=cepL0hdCN9UbyCzkOyV9cQEdxhgUijKh9zmmcDO5ikU473yp2AMOZcJXilqLRa0sFX
 zfJ9F6q5gR/6iBDSs/MWKl5HIY9yjtZF5m5sa1Ox3N3Gu4/ncdRBYcD3fvzUBnuQqtrM
 nAUWwm6kL8VdrogYpBrNw18wLKWFmZd6DDEvOI6D4H+mHJGqcA8phVZheJzRPgN7lv64
 eRe0E1LIuKHztxG7hg2oe7Qf66pC89aNTF/Ig8zlbtlXZZhzOOy4WbazNK2qNpt4Zstb
 gznQQkwisI3iIEeReJZnQLwDvvvJDXee/MNMui+50vNhX2zNwhqzm+l5ZvFAoJxzA9Pw
 B3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ygp7HmSMQP3Q+rbTx5g2DkVDCEdl+SFVfMjp/BmaoiI=;
 b=5hiOhLcwphPiDGdSp1LtFNxi6WHsuL5deuivYnXdvFLq9iTpkJrTRAHNqy/ALlEZN4
 nl97gZUE0sDDU2Z6YZOJHU53PgzPg6MIdIxIx3li5wF0BW79bXtCQlOGs+ky0HW2WdeP
 MRcceBYnXbdEIdWGNu/r1rUrzQQ1Phiiv6IoF8KlmZSeWC0S6l7NxWSq8JIr6slzBvW4
 wwUShyEBTz2GNpwHX+Fks7HbFS4ZZn9P6NaYYT5kqen290gQTJPqy67rxwLzOKyonAL8
 o5h0FiTDbD2NdJhcxuV10Ee6t9dkOMol65vbBPtsGwPk8Z7LUIokg5mhPcBFyXwOYmr3
 VlmQ==
X-Gm-Message-State: AOAM530bJnkqyZA45onME5ya6Zp5Z/c56FPQC5wi6kgOLdOVbV3jZCNZ
 IQ53RUtQK0HYBtXfSII3/+kTdoZLhjr4Le0WY8vDmvJAXXbzdQ==
X-Google-Smtp-Source: ABdhPJxscph16DkI7QPkYWvFXGKPAB18KesE5yybvpBkL5Qinq23VhWYa9sR4nWUBegylDrScVJnGI8fPsI6IwGs7nc=
X-Received: by 2002:a25:6993:0:b0:624:55af:336c with SMTP id
 e141-20020a256993000000b0062455af336cmr1603707ybc.412.1645694890926; Thu, 24
 Feb 2022 01:28:10 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Feb 2022 14:57:59 +0530
Message-ID: <CA+G9fYs_8ww=Mi4o4XXjQxL2XJiTiAUbMd1WF08zL+FoiA7GRw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev, 
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [next] LTP: readahead02.c:295: TFAIL: readahead failed to
 save any I/O
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Linux next 20220222 tag LTP syscalls test case readahead02 failed.
Please find detail test output on below link [1]

test failed log:
--------------------
readahead02.c:181: TPASS: offset is still at 0 as expected
readahead02.c:285: TINFO: read_testfile(0) took: 37567 usec
readahead02.c:286: TINFO: read_testfile(1) took: 37263 usec
readahead02.c:288: TINFO: read_testfile(0) read: 0 bytes
readahead02.c:290: TINFO: read_testfile(1) read: 0 bytes
readahead02.c:295: TFAIL: readahead failed to save any I/O

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4607403#L16941

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
