Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A189BC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 11:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782817837; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=dsCET1PaXBYcDB6OWGSWfncAsQ9lnxSGJr1Zm6Sw4iA=;
 b=fTJYJaxw+g2GpKKdI3GXZgd6BLmwd95CYBk+uZqymtK1i3HsYs43YEqFJctMIR/q0zILZ
 oaNcQ5qsflX4FOe4DzJoP/WuioXic65rw1vvGmM8Ckc6kqzSGTq/VYnyBgxEIl6/GltC5c2
 POsYS7fOlfkbzxRzIgJBT7CWiMk8oYA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A50D3E4CE8
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 13:10:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78C0F3E4B35
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 13:10:18 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CEC6810000EA
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 13:10:17 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493a5392c60so13715685e9.2
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782817817; x=1783422617; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NAns/SY0f9fzdOHmCZfiIy1Ic2xbpazFKKRteXzF5pY=;
 b=Rzk3HEmbbIn6lNObn9976hOfqcZcr0/bDsFHyXFITe+eXvGM4d36iN6K72T3K4GiBs
 7TLx+Whcmk6I/rc+kYuAfB5siSI60Ot1tOffMT2qT75k7ZxHnI4T60YHbk22hXQkZ1/F
 zcv7oRRwvaMO+5bMPvB30e4KDoYeLWq9GqtkpN8800zJvLtSKp45BgmpWwDnJ3+gzV+S
 mUmt6cAZW99ZTF8oYQfvEByr5hlE4oYDQ4GiFkNMwuD1oBE9G9JNajzBLkxsYjVW/AIx
 NVwvAYJ7dCrTkGUEGQIQzOcSj0woMUfFXZfB0exT2xK8naCVfAKD8Os58Qsy48uN2a0b
 ZTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782817817; x=1783422617;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAns/SY0f9fzdOHmCZfiIy1Ic2xbpazFKKRteXzF5pY=;
 b=c0Q0bObJKhcVI0DHiQsTjYPmFCJk68tjtdLhhYlq2BRBonUdEX5TfBvIICqcXJT7fS
 OYsnCK0v/QAvZY7L0BoHmzmg1X5/zenNrqerL78S/b1NmRTDBGjBEcz6CMuO0WlplWdU
 jrUNNWrTj+akjsj7fuqdPsbBvC5jogbwsoSo1+7BTvDlmNoPBEgjWiUVNzHKTmXf8YLN
 txITr1PrTeM12iEVPNSEF2UuTpkJ1QX7czEDR3UI++mLAcI3KRVx6iwQc6glcFpEtQF9
 4JQ4zofrDyZXuKOYoQ9WWvIqevVgT54gR5sBNL9escr7mDm/2bnBXh7ITyCmBleczbhl
 ylHg==
X-Gm-Message-State: AOJu0YxyWVmz6reZ0W8jse5xBy4hyXFhx8SOdtSJ7UunMdcHZPJeytII
 eHXRY0KKbqt5nkYFMyMftOWXBmo+kVlXzP8Sx0l4fiKkbJoHuukQH7qcroymPAiAyabUHszEWDH
 701tu+WguYg==
X-Gm-Gg: AfdE7ckpPPgLuSoiMEVzC1u8vHFjrgnIEfNug9biEpkWBGNwTYR6hw//7/qLR8hUjnI
 u7Fc/blfqK5FbOH3JRJDTmanWdwxvExYJNbjlnFdhzk87qlNJuY9E5a/pd9jXUqw3Q19Cfal39o
 cv/KDtfwdw8Y3FX9BKQoKV2CIotezjBGF6X3gtRPhGv4rmEcoNE96AAaybP3ab0wDwd4O2hrXH6
 e2u5bXS5DDMH1w0xzniNeKIOOZgyDCYXIyNboa4gbl3q/CaC0/0qHOu7Gl4m/uUJ0Xdw0RAhv2k
 pS8+M2tcAtmlZ6uyu+J8b9MFO/eP8xLbPzyj4C/gDU/hiPXntSRcLrObTJYD2CvRvCNMu7api5f
 tRGhzGWRRBH/XXb9v+Urn/p72unuHR3W71Y8vFJp5pYZXovmw8DlogdqoqM6LFXUYiiSIhMHe10
 aps+DbS81ztUJ9DlcVa2La1QKjyHOStp7bAe/XoiP7/HQ8aFKkvbQ4jzwFAdvNDw==
X-Received: by 2002:a05:600c:4e4a:b0:493:bc4a:fb50 with SMTP id
 5b1f17b1804b1-493bc4afbbbmr17672635e9.38.1782817817096; 
 Tue, 30 Jun 2026 04:10:17 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bc19f4b0sm33466905e9.1.2026.06.30.04.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 04:10:16 -0700 (PDT)
Message-ID: <6a43a418.da15fda7.276e06.e569@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
In-Reply-To: <aj6Iml1fSH2IwjqN@autotest-wegao.qe.prg2.suse.org>
Date: Tue, 30 Jun 2026 11:10:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] set_mempolicy: require CONFIG_NUMA
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> I suppose we do not need "#ifdef HAVE_NUMA_V2" anymore in the code.
> Same for set_mempolicy02 etc

HAVE_NUMA_V2 is used to check if NUMA is available at user-space via
libnuma or during LTP build via --with-numa option, so we need to keep it.

The patch is LGTM and we are ready to merge it.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
