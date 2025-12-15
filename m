Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C92D5B16E
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765808738; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=ncqanQUjZNFRQcR4Dxwz6kug0MeNmzuGTsuSbCrwbE8=;
 b=V+csHh1wPDDVwWW4ZcRAZNrudPKeAkg8uVVsZusLB0Z73/YEpHjTt6Kv0ubm7LOl8VWH9
 EJOzw4wqiBFu5QKpYcXYdVkWLZ5RIEeo+Tw13CUfLJyD2ybug2slFJ+xnPc8fvln11WIRzf
 94Q5UFgLMjZt1ZQw2Mi/tIL77Pqv9dI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249FC3D024C
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:25:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12BB93C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:25:15 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96DC21A0015C
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:25:13 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so22242035e9.2
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765808712; x=1766413512; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/khyXVsM5u/uwZPaw+vWv+r7Vx//y2PYMFkqewip3uw=;
 b=a4/UaTR8o+fDCMLul+EBAAspcaR15NDI7SxeMSU7niaGFe0SlVkExU6/EFTwZOLg/d
 zNMEMObnltsJUfuJwvrUkmydqPTkcKrmyGoV7IjhVRF/X3RLVOfT5M52+uEkXkbN6bQN
 ZRtf8pBCrcAuTSJhzFRHsAC0YKv0owZmHeMnLS7rfUNlZizzYKUI+gktaqCoTyDx/Y8m
 BNaUDwYxD713HtGFL8N7YEPl6kv2Q9U4YPrUIIqUtetkWg+m3NaHWTRvKeC6ZY2FAWMV
 7hls8nagFuzd47g54Gjx4daEmjkVEXYClCh56oc8D291uoQAjT7IcyrdNsQzYXP6n3kw
 fo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765808712; x=1766413512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/khyXVsM5u/uwZPaw+vWv+r7Vx//y2PYMFkqewip3uw=;
 b=WK98/4Cy1aAYu5SQ4iMmxs6H3wm8TKsa0TNRNpIv7C+3xkDCCmEfQG4ktwSBsG6gv2
 U+KfjhqavM3E0L1ay/foKVN1qDmR/WxzQdwyNjKlWMnW4ves5bINVGSfxJ2tHq/Yx19s
 yuo/iR7OyzmEKSB6WU3ZW4t17jb03DHHdlgRyxG6X9gxnrzGajtlE9m+gVf3M6sUMLJf
 O2zAJpUug6m43uXWNQCdZdU0nFtjXXu5bZsxPHTKg1LAG8JGerWhq5UFDXCz7Bb0z1K6
 jS4AkqVZYAM/OklE7XAhErtOM7qgua9Cx26SbdfgGjVAdR+oblWhfKz0R9NFM1v/+S4v
 teyg==
X-Gm-Message-State: AOJu0YzH+sKmecKN8DZoJiP+gdZqjm5Htif4Oodr8xQw+SojeTWqHPic
 3AJvVzROrmVD6Jxvd60XetTLNCLUHSDUf0i6inUjRFZDOdS6eJQEc2inUUn4BPh337/nYvRMyT1
 xIizrrxs=
X-Gm-Gg: AY/fxX5EpE039mY42qzh459FrS9E8XEQKLb+hLSU+nyOXJMpWwk2+M6stDU5NcQOA/u
 zoRRmtY8J4xFDMtBZY/vcgoBrMhWNubKd/MguJ+zpWg4P01jywup69+XsDfqWAYxAPDHjTjye5n
 75PI3OLiRcGzDYGRQBPXKbjd93w88e0xzWK+OrlyUgVAN4kvBCMlMr554FhWOqXZcqAsE/lstN5
 7bjDWw+UhNLar3XD02h8bv3yXPzlAUtzOPpDzXcOCNkndKKuqxx+BRx6vBuPtwg4auzUAL0DHsM
 hzbgToMIT6TZHpfpPgL32nazlXwJ18yuHeAB1sW+hiZlW7Vh+poAKTXcprqvOQB+oqBop/fc1D5
 jxgDwdHr3KhYeVk6kaKioIUxiFEH8uMA1n15pBl6HkB2zOFOqtjqmUzeFskkDlXgxH8nSyYeIOu
 9ZrSDGlKdfBzjPtNx1fj2IAOI0ZfsCv4WOAPA7A3O4wDCB2iry5OufbEBD7BVWsF/xQjLYvgyK6
 dorIoo=
X-Google-Smtp-Source: AGHT+IGoFhm8SivM7mnl7/k+VfNvhzvhL3aA5mO9InkZ3EAOv74tSTLUKTkOSrugwDDgSqAZ/b5+2A==
X-Received: by 2002:a05:600c:8115:b0:477:8b77:155f with SMTP id
 5b1f17b1804b1-47a8f8a80eemr103835405e9.8.1765808712541; 
 Mon, 15 Dec 2025 06:25:12 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333?
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4ef38bsm200058375e9.0.2025.12.15.06.25.11
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 06:25:12 -0800 (PST)
Message-ID: <33f1fbb6-e095-405c-b51b-006a870c0c73@suse.com>
Date: Mon, 15 Dec 2025 15:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
From: Anrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Anrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 12/15/25 3:03 PM, Li Wang via ltp wrote:
> Another *important* rule concerns artificial intelligence. I've noticed
> some beginners submitting LTP patches directly generated by AI tools.
> This puts a significant burden on patch review, as AI can sometimes
> introduce a weird/unreliable perspective into the code.
>
> Be careful when using AI tools
> ========================
> AI tools can be useful for executing, summarizing, or suggesting approaches,
> but they can also be confidently wrong and give an illusion of correctness.
> Treat AI output as untrusted: verify claims against the code, documentation,
> and actual behavior on a reproducer.
>
> Do not send AI-generated changes as raw patches. AI-generated diffs often
> contain
> irrelevant churn, incorrect assumptions, inconsistent style, or subtle
> bugs, which
> creates additional burden for maintainers to review and fix.
>
> Best practice is to write your own patches and have them reviewed by AI
> before
> submitting them, which helps add beneficial improvements to your work.
>
>
+1 for this.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
