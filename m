Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB27C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785340386; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=rMT8zQCE2P/+HRr+MRurBwhnfqpwbc6N/g1ql23agCc=;
 b=ZEk0nB5j2MblHv9frZy7Gk082ZosbJpLb0Au/zbDGQVscsIFcjAp8i/KFNo9kzEPsjuWX
 BvXWbda7RfDWRoafaVJm9Dz9uj1fMXO7p1Cx+E5ij3u5GlQVwsZtWiZnR8yK8QK18N955Iz
 i7DuZhRc0J3DiUrPIKhplvp3FOnp2Mc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C78FE3E62A1
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 17:53:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFE633E4BE4
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 17:52:46 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B8F460083D
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 17:52:46 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so605569f8f.2
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785340366; x=1785945166; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tuUw+yQQSmVfOeWL26PYHciqmb1KHKvscMcFJ6OuCVc=;
 b=ZkkFmwIEfni96QEzR8aDhwc3JLyNKEtzsiBz1IGU2qhP+YlFBFrwYmZ9D9vVs/hYZ0
 CTkdC/5dAJn8YGrGl6RUNriOdec6UvAIRm5t4jLx1YLAt3DfZrYEo+2ywwYk6kWEJNT+
 OqF+11FbDqu5Yvu6c6UmAGYZiTYFNuS0KfIE2/MJD9Vev12TQhhFrJbHoFjW5y3p8kqV
 Q75QkSLlpwU/B4+POgJTiXWQN0pXw2e0PrioymFHVqK9WzJOq7CNjLFSsH/Xc8s6HVvh
 Fj9/MByY2P2pbavwXddvWMPeWOycNTx5kwkPz7J8uuCURKvCVW0NShQ6xOyWGlpD1Vm+
 pmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340366; x=1785945166;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tuUw+yQQSmVfOeWL26PYHciqmb1KHKvscMcFJ6OuCVc=;
 b=Qr1LtjMEPIHD5Zq1d1JC0VP+lNzh49bhkHb4+k+RnzOC2go8BdNXFTrMW2G8KB96DK
 rmWJD00isFLxhYKFyl/ZyP1pbFkUZUroBoC3uqBGTjUhgWHZCMx23lW4cketWVRrMyJo
 eUderz4BCYE6Y1rg+IKwbILfSP7kmIxIvAld7thNnSBbheLR0aXUD9Dz+/Rl0RNwc6hl
 CqWrVdP6MR0X7RKNazr8Q2PQkSOObgeVEiId1fqoYHF/9PVAH8P0izv6D7U3bOPjKZH4
 kU08chSX/ERs9i9bjJhwDwc1ZHain5TzKpWDNB2Q89aDMznY/2AxvUNKjEHP8vXa36bR
 sYAg==
X-Gm-Message-State: AOJu0Yy+xMJW4tLlVWw54rrNI2dJUAkVjcYws+yjPg5SRa0PqVsrAFKf
 Iqv6WBoAwdUsg11XuAcLOCRzCjhXIJ8jTV89lG3h6aoVf7/URTZxwA+QVrN6MrwvQkFgXySjpVq
 IP6CJ407KCLSh
X-Gm-Gg: AR+sD12FKIKpvomZf7SxZGbILI/JGTXHxNIOZVMgw50aMcMOpCc9Xu3kkkux6NadnMu
 PnifbL0xeJTsrKjTffyVRa41LrSsO/LthwwDfzmEo9pYslM6aEciJohMgQeIg25pYV/7aSbpHQn
 DF9lXRnTG2TBCh6LbEXP9gS0VNAkbNc+ba+/GDD9mMZwD+GLxcsMCQlk9bxL1qHJgmXtuvt/dLq
 ROhAZYk8g68frCb//rEXKpML9yb+eACk6QXPicKEH86pmgA49t2chqux2wkMIic0c6jIv4IxJ/Q
 FYDfQihKqd7swfyBqHEw+tPo9K82M3PI3zFSNuUGgfMK3SfEyosw2SNwooPch8YPXtYOvNTYLgc
 hDUWdJvgCR91vDt5VgsProkPfG2v1OJU/cAnq5WmZErcE4chw2f5zUGBzBLPp8CZCp6/BC4QSod
 ouWZxX/chCH8EgtLN59CS4BNxDeRx1r/x1F/OT1S+6BK9/DbmVF3hzNIUwjtW5Yiwpzhnesgc7Y
 UMwa6mB5EcgCkah4eY8qTh6sjfPUp0KC2gsRFmDH57cPmOYcIZtKLkBpLdSZr0XYhQg0IU=
X-Received: by 2002:a05:6000:4b06:b0:47f:9662:85fe with SMTP id
 ffacd0b85a97d-47fb1e696d2mr10022510f8f.16.1785340365700; 
 Wed, 29 Jul 2026 08:52:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa3a32sm9064659f8f.2.2026.07.29.08.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:52:45 -0700 (PDT)
Message-ID: <6a6a21cd.18b7d65e.310c4b.bd8c@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
Date: Wed, 29 Jul 2026 15:52:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Fix bugs in LTP core library
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

With suggested @Petr feedback on tst_attach_device:


int tst_attach_device(const char *dev, const char *file)
{
  ...

	if (strlen(file) >= LO_NAME_SIZE) {
		tst_brkm(TBROK, NULL, "Device name can't be longer than %u chars",
			 LO_NAME_SIZE);
	}

  ...
}

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
