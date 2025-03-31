Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B1DC3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743414801; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=09a3KFDBUc/+Ha4cnU2UL9D/EF20U/I9iLc7z87l/ME=;
 b=PcZ7ZhjT5l2XzeTQSNxlmo2g5qs9NVCOdyXKjQ/OW4VKxqYd4qkktYbWBInPtDTgt2XwX
 Z4Qr6R67YVTRGh7JtjKlNb3dsrys1c43lzNKhNee9X/pxl2NX0f4hbFeCPX5z8C1Q0xRCp3
 NN94Ap00xQdmDseDhqrNgg9xL9sirPg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC40F3CAB2B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 11:53:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64B6D3C9E60
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 11:52:59 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97323600C65
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 11:52:58 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so6803265a12.0
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743414777; x=1744019577; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4+jr/SfkOD8evigIfj30ytW9lSzbMZh9yq/4k1klnY=;
 b=TCha1/Ey4hsEaRPpKBYzClgMsQ9G7Oeo+UvDU7t1tIrZXFHexoUHz2QcRmbC+eQ8Pe
 mEULP6eMvI9+RJX2P8LO10rt3gA6+FM0WwoIR1FwFD6ZbvcnyAJlha50OIxEcX0hykAS
 SVdGjB8VFctGFqN3aUufNJ56VULPkHoOxspBeZuNuj2sdiuZd361vCkXMiVR9x8xTp7P
 G+OS3JLs8IVFjz/gMSEgwOnI6a3644LZhHu9LPPuDTNDQRLybh+3EAnQ2xC4fyW5h+Ht
 l92i0r2CI1XUdEVZiP3geSDKaE7Pjb/xnXR4pYjQ3TR7hdTnr5CmXE45wvTZl97oS3qc
 Lydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743414777; x=1744019577;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B4+jr/SfkOD8evigIfj30ytW9lSzbMZh9yq/4k1klnY=;
 b=QHLsPM6nObgAKFO91acp4IDyIBj3TPTo263zxZ6w3LFiru4CgNvMyRyl6NiE951Mlg
 mVYPBjjs/37EpbruErPxr2XLvw12ljoUvjfuh9ku5Fh4f5JmA1QcsQT4L3MwFVSIKIcI
 H6+Xzak9g8H+Yq0vtzKM0DmU7XwwFvPep72/QFWw4P2zTuMiDRCaU3ra2wJr7FOi9PfO
 bkgz5B6yP01DEywMI34bU2o/KVEphj6jMWe1wGq08NdtjEcEWcWea8+Tvh6p1CNHe9j+
 wuV3DkoTGHRpQDSiSxCFRqsdVRPD8rrPOC4apuQ5TkfMxbPFs0c9jVhDuaAUn/Wc9+52
 OJ8Q==
X-Gm-Message-State: AOJu0Ywtfqbsa1ACHpHzOtLWNZDCNjME5wXrNUxy0E492zNLLYhw8p5i
 8415QZLkMHdqaOWr9qWNjjmCB7EiE++tHriiQFBXJxDlXkHl4NXYY+Z0Uv6xDDUnlj7Q7rF+rcQ
 Nw2tTTw==
X-Gm-Gg: ASbGncuwCz875ygg4Z4fy2pF0rK0Ox1iOgO5/8dI1BCTByEd1nNKplQf0lQj+AM3Fme
 r9s9gILdlr/CZSKoGegaegjQaVsi1lxpqRAdLUZgmHsIeR2CWXeDXlpEsT0zjJ3vaHCT2l6yMcF
 kUIl3KLgaeZEchAN3B3MjfY/hdmYp9EHTzToE8PCKRtU5pxhf8DbGU2Ge2aO2eYjtrZ7Ktq5dsi
 n1qpgtniLQuVap0YLLa8oeTp2/P6QjFESBbvJXubSq/8uixKA40cPNiRif5uFlZiddR6lcbFHnI
 NfIXUU9zgpPoMbyUb3KSbObKVOTmO+2TIUtcql8aIyZ5a/vNjhLh9BeZEJcIoUySTLXycy+lNX7
 uInbd1JIR5dX61o72imB7HbQdlt4=
X-Google-Smtp-Source: AGHT+IHEpSQFYa9Ut6dzZ0ImXAOf1DUN0fIFuRNBg4idj475VVul0h/za5dXS1NP7PGsW59x43Wzug==
X-Received: by 2002:a17:907:6092:b0:ac3:8aa5:53f6 with SMTP id
 a640c23a62f3a-ac738a0c683mr764954366b.24.1743414777155; 
 Mon, 31 Mar 2025 02:52:57 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922b9d0sm596527366b.37.2025.03.31.02.52.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 02:52:56 -0700 (PDT)
Message-ID: <f1833ac3-5c28-4a19-945c-2112dbd898eb@suse.com>
Date: Mon, 31 Mar 2025 11:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Test Project <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [kirk] Remove support for external testing suite
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

Hi all,

As you may know, Kirk supports the execution of certain kselftests and 
liburing testing suites. It was initially created as an experiment.

We have made attempts to implement these features, but it seems we have 
not succeeded. They appear to be largely unused by most users and are 
creating a bottleneck for new Kirk implementations, such as the 
automatic installation of LTP inside the SUT. This feature would be 
particularly beneficial for QEMU vanilla images. We had it in the past 
already and probably it's time to get this feature back. And we should 
probably implement it for other testing suites due to the current API: 
something that we really don't want to do (see eBPF kselftests compile 
madness).

Another concern is the maintainability of supporting for additional 
testing suites. While they are interesting, the implementation is 
somewhat flawed. Each testing suite has its own 
input/output/configuration/compilation methods, leading to confusion and 
over-engineered solutions. While we understand that no solution is 
perfect, it seems we have reached a point where Kirk = LTP. Therefore, 
we should reconsider maintaining features that require updates due to 
changes in external testing suites.

For these reasons, I propose that we remove support for the additional 
testing suites and focus exclusively on LTP for Kirk maintenance.

What do you think?

Best regards,
Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
