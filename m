Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F12C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784034374; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=kF/u8bGl0fOM0Z3hqK3n8U14cnOI3EqG2v89lLS2kDOLzi4VTUtXyVAEdO7z7R/TuMRIQ
 D73YXapcICtHwupXbeb7U1F5owOyQrLOjIXrLimrdDdZYiJC5qukgw/nDKtWrOA5lbS5zMh
 voF7XNLh7UzimECYoNh6anU4fsZssgk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 284083E78DE
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 15:06:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B510C3DCD69
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 15:05:51 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A14781A0080C
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 15:05:45 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-472326ca506so3512666f8f.2
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784034345; x=1784639145; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MlB2O/qvUFMGRweCz4gyps3gXkG/qeyjrJRpwpTcStQjuY94fuy0B0PbsU3Xz56UIr
 UWBymHEEgXZs4kLFDw21voBTPGOwopl8RE4k8Mn6Y1Y2cf1OukP7zn81NkvXQWhDUhf+
 qgOB/BCxZbFgnzCj2+IsaFZhvaZN/V0qZasPFzs/FgdP+xbMvZOOujcbgcM/dL9kv5Z6
 E+BjT5xXDNccK5/aZVLCR0uuckI1AAzZe9jEbCSf/arjlHzn5xvrHSvfUwBfzBf5k0px
 9H09qQ/yUoiVD16HsXXOnpW9GCijYhBlih67buKaSXI2Mru13Km6boUwmEFO3EqlqHGZ
 sHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034345; x=1784639145;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=aEpXJGt4ljWGRDSXxMPY2d1vv9V/TsoPo1JObC0vivatUApSIaJFfr4UZAdxh23/EJ
 HgmhlzphEidHH6gQNEG7l25IkTUIBYzCvFEp2NAf0pwA8SraFnUT/I4EXFV3BH+zC0zC
 I+GWmTmIJg7q+V3M0SN8jiFuiOCbcs9PTNFt3hhL6lcpou8msTpmy2YuwBIzGDvByxee
 EfY7pVjqlz1csLsmpWdQEqxrzXLtz4Q9uIxi7QO5O120vzpsC1Q22ZcxddUepnOmrc1z
 iagqeDuUPzMbJSzpzgJ5O6cwhQmGfYWeQLIqHgQe1CyKIJdU/8eTuZA4UGzhuCkrlLd2
 Hs4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Roxa9sit0K1N9yjMupGj5iGa3E56bFLDsgDXB/nvHhteDYQ+sNRvPWbRTwX3yOmUrLlm7Q=@lists.linux.it
X-Gm-Message-State: AOJu0YyxoIOHjyLxO3vxif6ox13h5qFG5J3X3C7WvtXQzqAr2whrT+9w
 yS5sYInBSEBHxubLL9koAVMzHN4gonZNRCnyC8hq6UdwzOnCEekjtXpQpah1cgfYy1Q=
X-Gm-Gg: AfdE7clqkA+hdgqceKbyl+L6BkHFPgHWmxV0FODMNmTdvQ6L7YhXLXifmd8n1E+PYOr
 zKsZSMb/ZO5Ci6lPjkd90zv3MQAqgQQAg1xu8c9uOZSmCrU4vmMqTZpoM7P63PgUhCQD2Or0SiR
 7DsDN74yanMQyjeiEN1hHF6FV51j6PvPXvPx+l1ePZPhMBD+cs5O1EdTM3hrjT5W+t0auSGCLKq
 d6rdrCLWz0t+n/pbM23+ncofwqgxAafjejavm5ARaBqs53NhwimNgk19nbr047p1ioiMeShQm5N
 kfhC9PmCSV64Zy/u/RVntID6rldYp9xe46GtavawZu/yU+1/wFW+ENeVzIM+Rnna03W0qfuJyZq
 NR+aCFPoJhswIhNQq+l9csiuvff9DhxXg+EmBgKMtDd0esuJy4lsL+VRGeg7O9h1j4DH67CR2BN
 8nN6vM0b9PRVtfBWjqjLLR78Gy7ocBKSGWKl4l
X-Received: by 2002:a05:6000:1786:b0:474:3b3b:5e5f with SMTP id
 ffacd0b85a97d-47f46340659mr5082373f8f.16.1784034344927; 
 Tue, 14 Jul 2026 06:05:44 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a9cesm8033311f8f.14.2026.07.14.06.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:05:44 -0700 (PDT)
Message-ID: <6a563428.bdd87efd.96c6b.e022@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <alYyZ1HfnRBEsFCF@yuki.lan>
Date: Tue, 14 Jul 2026 13:05:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscall02: test invalid syscall number -1
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
