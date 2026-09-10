Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA5C79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789038900; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lBvB5CyVOnoGeCQJlcGmD0k7h7KBb5gNcjZGb+Hr/T0=;
 b=l4Ze5RcBGKXe7N2H3Od+cqWpwFozS3JferepNqLI3r7bMNU2vqtzX7a1zK7TIrsxrd9RJ
 Ca7i57zxXkceMkL+F1EH7qrYJw+6MVR38OtmNMqlL2tMv1tzVGSq72C4KFPyz2ca9vkTP2y
 mmugzgez+jt72BX2qVjHKr8cwPcvg0A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 312473E9275
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 13:15:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4BA93E5967
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 13:14:38 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0BC03600155
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 13:14:38 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso57363095e9.0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789038877; x=1789643677; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h3nMdeW2nWc82wmIb9skQA1/9nKyEN7B+h6ABvU9UXE=;
 b=B09uZVg/N9qjrZQ4F62+Xgk6ptTkbEZwF0FNuy99VFUHBsSYFImVMyDKVzqent/Q3N
 wi7V+K+tsnnzW7JO/7va56or0ikr/33FxmrQkwB/XALRDXzWhfWa833b3ze8eYoUBVsq
 GLKwL6giZ3DCLyAZ6VNF+9ofcFL/x6T55jFrEEdUWzRXqKcGFhOh5B4DVIJnwY+GsSvw
 7f5N8pl/9MZotn2abFWj/NaBxSsZvY6HEfYYVNMVCbfR++DClzUmDMwjM4tFz4D8JffO
 gBIi8qgZDhz/Fr1e6T2FqhPNFwvrIr2CPkpvIZ7m/t77yvE1A58xqILATk2GP+v5bffZ
 JL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789038877; x=1789643677;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h3nMdeW2nWc82wmIb9skQA1/9nKyEN7B+h6ABvU9UXE=;
 b=aVr7t7U+MvYgCem4DlvlsQNH9+nF1l9ia17w5oak9DiWiR4U1K8HMHD05v8eALoE4D
 ivCKweiZ708xH7sn2necEHr3IrH3scy61rYSt2GOBbDbfNiqdYbcmc9AcnOlrTT1FIoS
 WvjA71hoxlJLOpIZVy95XD4S/M3yZP8yIzdyq8op2i+eTUD8bGYAdA61Op6znM0XxGlt
 0kYt/2BZT9vBVtQFUEJy7Nk3yi5dYo7ZWZnYfEI5SWvY5R0JI2pnJ3SzlOuZ8PTofA+s
 lf4N6Byl5vBxScncuZ7PZXkfCrS8RrCyxga7F49uLBDxzIi9Dq5Z5HPvJKZLEJZ2XEdT
 rrEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ0pEhPIr3dk5m2APqQixT+WvGkDgTKNryUV6whIMPARTI5P8RyBKupLW4H24A/ddci2s=@lists.linux.it
X-Gm-Message-State: AFuF++kq8UlWHlwoQU/V0L/spknn6jmyBf4eye8IrDyLd8F7QUohvf8I
 RUb57KxWG9s0NlFY/5URTViOvvZJxwrLMZh6REo7Jw7WMbsu1j3A9dizGqqNPwJdbK3dCRiQ/GM
 2ImnrsfY=
X-Gm-Gg: AYBFou320FWWkfDNEqj6i9v/IuGMjo/J6OwXKbJ7iv3vW954MTfYWoX46lJHamQTcCG
 7O1dI//nNJ2X6Lexvso/WUmP5jNqy91CxT7zlxiL0ypasbLTd8ieWQcmmR8ZBpSe/ztmFHjRVWP
 N33CctllXenPl/BfQB+dAYP33fDBsWavhf61PtFib1cpIuPggoCnlA2wahKM3Db3cUU6IkZY89r
 3PdTkVavrqm9N4t6yh/aUCJWo1sJq7As6b5kjNq2slEP6ydNNPkYhn8PyRzFI7akRshMVWZ6iqj
 UQKPIhURE+ma9NgeEkVIvoiGmNtjpxZAvYt1EsCO9j0uhPsOOM78Ot/EG4P0GP0LwrTEKtb8Xys
 zyJF/AX3ZZeKUt4aVDKD7dgeGKhRm27Fjxg/N74fI+xm3i0XQfDsTyw98cd1zxbwlDA6KlCE/ZS
 oJst064g5eBb7VZ760tyYIbTV+vVPs8byrxcwCk++gmcuEr2h2fS4PZpTRwXsicB2AEOuHwbjwd
 UZNhKH7LtxiuCh4Gij7zV8GIodbK4qdrmtlqWAB2WnkO+uysMeXvFTNRQ==
X-Received: by 2002:a05:600c:310d:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49cf81e5449mr418669295e9.3.1789038877404; 
 Thu, 10 Sep 2026 04:14:37 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fb40e1sm124955535e9.2.2026.09.10.04.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:14:37 -0700 (PDT)
Message-ID: <6aa2911d.1f4fdde7.c7afd.7a6b@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aqKEqxlsRHagH-z-@yuki.lan>
Date: Thu, 10 Sep 2026 11:14:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 3/3] coredump02: Verify ELF structure and notes
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > +static void handle_note(uint32_t type, const void *desc, size_t descsz, pid_t pid)
> > +{
> > +	if (type == NT_PRPSINFO && descsz >= sizeof(struct elf_prpsinfo)) {
> > +		struct elf_prpsinfo info;
> > +
> > +		memcpy(&info, desc, sizeof(info));
> > +		TST_EXP_EQ_STR(info.pr_fname, "coredump02");
> 
> I still do not see a reason why this can't be:
> 
> 		struct elf_prpsinfo *info = desc;
> 
> 		TST_EXP_EQ_STR(info->pr_name, "coredump02");

because ELF notes in Linux are only 4-byte padded, desc pointers are not
guaranteed to be 8-byte aligned. Casting desc to struct elf_prpsinfo *
or struct elf_prstatus * creates a misaligned pointer, which is undefined
behavior in C.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
