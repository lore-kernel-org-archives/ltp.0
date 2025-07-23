Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51782C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753276589; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=pgIU05dNTCZrIp0RwK58YwuyWIht6QFHDVfGLyQX+jY=;
 b=eaT0rz8lsGG3WGo6xag/rbxyWdWb625ETtjgDCN3rSMmKPPdB6GqKfKA8WaEeF7KiapWH
 c4p4FT1kFTLu/hN4vn7jT0aFHkkNrLGwyHisV8k1Z6dYiU7qWv5fqOZ0nD0AkVCUZ0OQqZO
 hYiLb/B8S5sQrJWA0NZKtqgq5uwojSQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6B1D3CCD66
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 15:16:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ED943C6AD1
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:16:07 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 749D51400190
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:16:06 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b611665b96so3800552f8f.2
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753276566; x=1753881366; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsu+OA1nqHVVIa7JIxe4QW2EGDUn8+Jst2JnVZng5Rc=;
 b=O6EyNMidvXbIwMW7SeIVfwtz4I/0ABBb/9IPH9Wa7j2DzJWyvrmEb7pxsl72w0Z4pQ
 aSp8xcKsq+dOFGIOG/JVq9ntzviYuasmNIkPjiSpyACRigGodccg85rxb8aAcOoLcCeX
 MPhrPnqrri6LD9uuvQIAkesx0GtXqTUAL7+/urCMXvIsJej5jqd5eRiKBDIi/oicMl8M
 gFZ6rsRg5NJX66eD18RCwilTi8CUriGDFwcs3NGMMWnzk4jv7rqbf1nmwHAH2Qa0Ex8H
 NKge/MdNUqiLDTd99YNkQOGVb0tPhAKHerpR6ieHZsetNhdBcepdMCqUzIwHNvS2I5G9
 9YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753276566; x=1753881366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jsu+OA1nqHVVIa7JIxe4QW2EGDUn8+Jst2JnVZng5Rc=;
 b=bwbLdUGJAxddzrw5C7tdDZTkDJ+m63nOP9/8rzceRNgCchgZjXOGU5CjFriX5UTheB
 Pihbg/on/64LOA7/0A3nxJhcfI4kPZwbS/LLdlkQo+JNJWEKKERkVlcWXjzm796uConS
 9UXYII/GIic2rXVVAa1s/fANSxlu3/ikGebsf0pdJo2Q9kmB8Wo0Yqi7WmihJjt0wBu4
 dndAD4xqmj6bPQOonsQol16789iSbZA+jlaMnqyABsNJZ2gDlAHyNPMqh8q3G2YJu1ab
 VV5WVM1tvsvWHwrfiCNlWEoAI6XGecuVl0G4vFfQlJy0b2t5N4e+8sqBJEaTJRuoy6S4
 0/2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTcmdr1AgomTE+S2XUVLR0+CnHiy9tP5Qx1pf0JP6zb9gZVKp6NH+Ir0oQ5ElbYRwLlwA=@lists.linux.it
X-Gm-Message-State: AOJu0Ywnm7MlKPd/8UnFu/MsrRxkkSncp0+2TXTgONABipxW3s4GTjyC
 Imn1NrVCYiu0MRoRMvdVkV5U5YOtmeJrZn8TvW+P0TZ367NSjM4S3d/5nT9KJTN7usXSSQmQPSD
 NgYC7
X-Gm-Gg: ASbGncvppF1bJqS1q/OSEbPPuRFaOUjJib5ci/ElGyUYWAxOZzKUlbjn9QvQTZq9/rw
 8EE7u/MhgKwvBejtEE+jyicRZXGSCdrgzV5Htni8R8YA/s9KOEG1QQ4N1wOUHGLuHJVQT0jRBED
 BDAwOZBL4gua1N61wbyTFUltLo95f04z7Rf5UThfkAKsgarhSej7ZoR64KiFCzKyqKNN39/Btnn
 8ylukjC6I9PTuSDps63tXELgPerQHF1Yo0R5XgpRKuwKYC4pj2qMVJ3XV2U6hrpEyHN0KPZrlcn
 EmXk5sElSxTr50+aWt0n2+AIn2QUKBKOmCZh1IU8mR/jX0ooz+XzzJ8y0nXp115OMOkScGxjmJP
 C7pcKJ4qIS+nHh8H5mBPzpAGgkEU4tuJbhQBl50Q1flHH1l01/ZG2rqXxME1FEZHrCe/Tdlh68t
 VA8guUci3P9vz4ZJCuoh/iZVtoyDEI556cPpq/0yNSvJC8pAJNOl0htUBGPwt5+A==
X-Google-Smtp-Source: AGHT+IHbcnGjw5qKMyJfr4nTd15lDPxQnpr5OW55OeMb73WL6XxPTxLkQffSh+NxxbQC48bCEP+c3g==
X-Received: by 2002:a5d:5d10:0:b0:3b6:4a7e:1571 with SMTP id
 ffacd0b85a97d-3b768f0561bmr2356500f8f.50.1753276565664; 
 Wed, 23 Jul 2025 06:16:05 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b60ecbdsm97307475ad.82.2025.07.23.06.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 06:16:05 -0700 (PDT)
Message-ID: <abbb4f90-d163-447a-bbb2-e860371e0179@suse.com>
Date: Wed, 23 Jul 2025 15:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stephen Smalley <stephen.smalley.work@gmail.com>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
 <20250723124127.GA154226@pevik>
 <3a8c2634-09d2-4d29-951a-4e5c5b1adef1@suse.com>
 <CAEjxPJ7bj-4_PSKiSuH57UZJWof7ky9QECkUeaeWX8T81wHtjQ@mail.gmail.com>
 <CAEjxPJ5g5EGQ-3Vq7b7YTnW6O0O=GM6yxxFa8cvfJ8uSjYTUTw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEjxPJ5g5EGQ-3Vq7b7YTnW6O0O=GM6yxxFa8cvfJ8uSjYTUTw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 7/23/25 3:13 PM, Stephen Smalley wrote:
> To be more precise, the bug is only triggerable for LSMs that
> implement the listsecurity LSM hook (to return a synthesized security
> xattr regardless of whether one is set in the filesystem), which are
> only SELinux and Smack.

Thanks for the clarification. I guess we have a solution: we can take a 
look at /sys/kernel/security/lsm and verify if smack/selinux are enabled.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
