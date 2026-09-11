Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C54C88E41
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789108412; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=iimDtHXm8iMOYzpApI8pw39vynXNrVmcGEuuwi8ZatTDz0XIDAlniUnBAgJrOpmtSK2qo
 BSvX2WXGpZwlyueCE0o6nVlJ1KhxvthjIOneQk6CDstY6Y+6aD+khWVw6pAWkXWGwE5CCxH
 J2kWuuan2yipYmhg68SXXe1yQQt6UXg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6CDD3E2E81
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:33:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430893C99FC
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:33:08 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B8E3140025C
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:33:07 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso4765345e9.0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 23:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789108387; x=1789713187; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=XBVkl5zc/jpaIK2YHoELgHrjNDwdhgy7HtGstF3DHVarv+6Gf0rQxyBv/H5rV/m6hL
 6mXJKR5D0WGfUxZY4JD791uBxfx0Q9ObWBkvtq0Wl4WQchs3/wX0Wdq8EzT5UjHKfv9a
 5H5rE24ByTdoq7K1n7AxgudX1jJf2P+auvJUPgyGahqVJCjd+00rZSGqcRs2m+teb5i1
 WzpmvVt8dNJsRpu2oKS3R/42sSnbnPR6WduE8ZfMcfsc9x+8qyIee3ZMEnrOiy0Tfx6W
 b1DOipBdEIvUqyCDfjMxsF0lx8+H6sQdMJOA3UcL5Zakz4yd/ACULKd1feDVOa3QTlQc
 yryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789108387; x=1789713187;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=dxgLLN1JIEVkNCIZMqUOvj7mRdqvETN1WyyRzwB9XchhR9B7J+AWGZwg9fxpFj4gVo
 Jpv1YbLbqwkGTRBHrhfofFb+zi/sR1DDPH3gY4ZiGjMiKz9hylF+ZzCXdJqoUZTM7mhX
 9cb36t9sDEd0DW8pAhm4CGnnr1/CtvNQfRtQWUZqbDAhm+0B0qsKrMyEpoibhZ/hJE4+
 4jV55Kdzh/I+uGbLVBUMM+HjFl0auUm4oxCZ/dZlbxK1MmQSyb+q83jk4QMKDyefJWtw
 kxW4Cg+LVOaJ3yeD+b8f6OkNrCGHf/uLGk7CRh2sxs8MfpOADkbofWioQHAAZsMZ70O/
 rDNA==
X-Gm-Message-State: AFuF++loXQg1Jzekk7NKg18yWWFhgP1NslgfNId+AaOhwx1IqsP2qqV+
 NGXtVCz7PHC9SH9r4ScL9ajSPA2cOZHr8cEEDacC74GK2qLOJibf5NFo5GvT5amKPSOwhiopUnT
 iUHf6jS98qQ==
X-Gm-Gg: AYBFou0gxkK/+Q5eaAQFtHdMa3D6gZ7gWo3wA4DFOSoeHs6B+/RcpvaXYCW2aLA6IPO
 BS9gBuP1lscJLgNjJv+ZssP7uB9VMLBv8itlqI8iUmjYJVZiX3CVOnYDv6fNBXtZbHx6uEntjK+
 2hYEycq3+tcrEoLOuAwAFiWnqxgs1bcTBVNuP4JHN0LYzSOh/ZEOnEOrdiI+9iMnYs8a7nn68rP
 pBb4FW+dB6xcsxxVLS8mDqTlWPBFsNP/hPKmWFcPBmOp+6j2SxSqjvXsPfgYKtQq0dlRVO/UaRH
 PJb/mT3MZn0RZJELTMoFguM+V7lFzEUlqAqUAoVuLuvtswue/A1VRY9YbNHXofFClIW9LwwLaMg
 uH+yEO0DOmEshintXcvBgmJCOrs9GOsjpSbrZSdfjKTWk/L/4bzcRwCuvFffb+HBATnjD9WKjix
 9c+Hiwf3fa1ct7JaktSciqoF1Ri/+7or+KDBvP/h6cIydp1AXwxt7I7lz7MAhcps9meAHT58uLr
 16jRrIJpXwGp3QE8B0HEhvL2FBPOsCm35mQQk+dsDwcavTcqcjYPmId4+XtfusHGcCV3/8XuQII
 XnvOJQ==
X-Received: by 2002:a05:600c:64c6:b0:49c:fc6e:a3e1 with SMTP id
 5b1f17b1804b1-49e619e7235mr24942385e9.32.1789108386705; 
 Thu, 10 Sep 2026 23:33:06 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bc5fsm125565275e9.3.2026.09.10.23.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 23:33:06 -0700 (PDT)
Message-ID: <6aa3a0a2.5d733ffd.2cc93.b29f@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260903-swapon_discard_coverage-v4-0-2a9f721ad954@suse.com>
Date: Fri, 11 Sep 2026 06:33:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/3] Increase coverage for swapon syscall
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
