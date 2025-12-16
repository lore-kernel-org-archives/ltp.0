Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E0CD5E130
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765883363; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vh8TlH9Z4OHh1nyaaMpIVG8tGM/0FkX50ugO0+A4lQ0=;
 b=gG+8Md8rxfnPuESA6ZhNekj9rdXy+czV0q0VbKUhydpjG+dwoPsA28XT29FajZolAYL0s
 +RDvNyvJ2Xnpd0hRjMfk8RQ0HCakrRJi/FeK/oEsOb3WaAKadw76Su4q83Yz0SkStRTUnto
 ZFupQ9UpNqRC7+AhdUIF49ubkKQmMpA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BC283D0349
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:09:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5277C3C0322
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:09:00 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9EA1120091F
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:08:55 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso39366915e9.3
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765883335; x=1766488135; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=du2KsoUk0WKl7nSTo/VXxIpIpzPAU/WdaVFauUklnlI=;
 b=bHqkK84fgi8rWoNvgQZyIPSKfqFnCTbdO9mxiDYolG03cbojdADrORbtjxw1eZfBIn
 HU4WVb1GMBiF0gvxXO5zvFi6AARDrXBZ418LxmUBNkmsmkdRxYt/DftRSTQcHehxcQdh
 MwViXuGJ5Z9+KN4GxGFn5ulSbZvob60SiSThgHc+6DQhN2aFhsjI0FUgvST2ph39TnfU
 vxFLeXAihTDuJRNdNFgU7IrezeBzxju9/QF5Pt3fD7xUqDJMmDo/7UGEinhHoaSXLl64
 N++AJxfGXAdrRwFWV+C/ZfAKueIyootcWcgkbOHJNqq7+I8qoh2vuuZf6zE2MtRi9Jt5
 bdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765883335; x=1766488135;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=du2KsoUk0WKl7nSTo/VXxIpIpzPAU/WdaVFauUklnlI=;
 b=XcLLPOc5jWVkGgUGuLyHbyFBK3bfERHYipMzBGbOttfwpjHwxEfqmEU+prGFYMNMcz
 LLq6XeETNpJCDxtwi4NkZOrfUepkZqhcyDXGYDOBuA+z0RJK0MvolI0YV0O8rysRhm12
 F+QlUbD7brTB+m6JQMmyLhUJEzNU42rBG0a91e70zLWkZLaZBrh8E2SxkEhM6oFteTj2
 nCyygOBrZGVf9+okgfSD5mM+0pTwFGO8mewK51w0Z2GZx3LDac2C+QJiQYYLqMpoBEjL
 2rm4rf++Qg3b1538v+/GzRsqOZj7QK2SODmA9jqq7gVdLCIa0FB+5xVZrvWE/VT+IAOm
 lK2g==
X-Gm-Message-State: AOJu0YzfkwvB7Ujw2qTQkjormJt+YDb6hvItnNicjQRAxNaG4zOJ3zvE
 Ebb2VvDGA+W2Vq5z06gnoEEexZ5Qp8OPrpikAcIN79wguKYS+HkEQRojWVz8WHyRB90Z7UszmQJ
 QXEzI5fs=
X-Gm-Gg: AY/fxX43BHSsoxKt5ReLSzvpqOLCSeRoATZGx5jBY4qS1HYbfmdEmltkX37QZdvQpQN
 HbdoGTw+rdeCEqTRyX3jA8DpnBTuHSut/nqwAskXCcvUcuWg3ukDt1TJd/JDlcSUIWUA+2VIkY1
 riMEdgtMcpYa9R+277taNrYuAD0dZsgWMV+ClWPdvKZGZv1T2mSGXqP3VA6ehZKVtv58/dqVUJl
 16uLG93Y7N590VFj6U3esFFbAUyhVC7plUExvch7bmmeTVLaal2/JLl92QObIoFVSSHQ5gtuLXw
 yY15rjAmrG0Xf1X09fpj9Q7MuBTAluiwagAY7mj8srfrHmkjJqHtKOq2pmhtt+bK9c4PuVaI/B/
 0fWfAnuBfbulG0kK/F1EswOfpVjUwFU7K5i4HtYFBYb5yrisU0zohF7L76sOT11+3QGfVe88dbo
 cP50vHWF4i0eWokGs//9E=
X-Google-Smtp-Source: AGHT+IFlh0c/lsGZi9Hakr6KoGqtdTuVbtEycVWe10V0Gpf8TX6pHaOtGPJuDCXzsILzYmOpHB7VUw==
X-Received: by 2002:a05:600c:3f18:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47a992e2ed8mr96747735e9.10.1765883334964; 
 Tue, 16 Dec 2025 03:08:54 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a09fbesm35024354f8f.0.2025.12.16.03.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 03:08:54 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 12:08:54 +0100
Message-Id: <DEZLECEME0NF.1AAT13XDV0HO5@suse.com>
To: "Li Wang" <liwang@redhat.com>, "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
 <20251215143048.GA267467@pevik>
 <CAEemH2cmuxr7jKBA32eXQHOwQLvq4tPMDsmcen_9C7di=eSpDQ@mail.gmail.com>
 <20251216101117.GA295306@pevik>
 <CAEemH2dyDmwz=bCMAUCgma5P7dYbfeD16Cey-anLrVxyFRmg4w@mail.gmail.com>
In-Reply-To: <CAEemH2dyDmwz=bCMAUCgma5P7dYbfeD16Cey-anLrVxyFRmg4w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> Just like Ying Huang (From Alibaba) spoke to me:
> "I found that AI performs better only when I break the work down into
> atomic units."

The problem I have with this approach is that there's a risk of "dumb
effect", where an engineer will rely on AI so much to forget how to
write 100 lines of clean code.

> Therefore, it's especially important to rely on engineers' experience to
> clearly understand what problems are hindering them and how to
> communicate with AI.
>

I agree with this. Boring, repetitive tasks is why we created automation
and AI is a part of it. Let's give it the right space and we won't end
working double because of AI madness :-)

This part of documentation is needed and it would be nice to have it
already by the end of the year. WDYT?

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
