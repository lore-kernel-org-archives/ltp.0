Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9781C108B8E7
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774000249; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=L8w0tfIqJzVOm3v0TzfTcvK8whACtc8sZ/flhwFWjxY=;
 b=cd64bEDrVBgFmpPKfnaxJT7DbdcaM1xcr+qbWh4fhHnAScAuR7hSzH5rEUBw5GbrX9IYa
 XDokWQES+qYGPyVejf9IYARqo0ARYZ5/nYhtTgcQVrBlD+c4cNQ8EgBvS26wGrgwQoMuT1l
 sKXeRbmsj6AyNTKYpUD9JrOvv1V0Vj0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26EF63E2B3E
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 10:50:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1073C72BE
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:50:25 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 42F721A0118B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:50:24 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so3369585e9.0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774000224; x=1774605024; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=s3sitjTzJuGN+Yp6tjHm3owP8DZFEPTsasdX4URXpE4=;
 b=Z8k0yopcK5gLyKWzzODzN+7nd0iJu6eWLTvzqIhwHZeulQ+dTuxTZzPwo5TSpasWrD
 Wngij/ZSolF3Yuc6dJavmJAjuDANxXJSP5yqU+Ohrkr3oKI2ftEU72ASU6gSTw0Z3riq
 dNnjbl39iqFWpggGjx2vjRo3ztYUj/M+wc0GX1YzvIbELDLOk9C0N3e+2GVEXSQVcrMe
 +cLKno755xU2Potx/++RHIjwmq+TUMf7QiqZakulYOMrv6Dbd0SN0nP8VIGUkSVF7wfh
 8f6Wwau60vwvYAoJmCQ6vQY6W0C2ymoQOv/0PyC11IJfcUsAHHJfNBiAgFqkVyiDrBVO
 IWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774000224; x=1774605024;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3sitjTzJuGN+Yp6tjHm3owP8DZFEPTsasdX4URXpE4=;
 b=k4u5PXKYTzj2BFjDFfeeOa69z/7ZzBnhDfn058v3m3yfB0VLDv5ZrxTSeXeK0ZhZaa
 JAqhZJ7alQ3JCRbepNis3gqvcIyCyy3zmvrJgcZI+jJuyEd4lFGUBy0mlXYS+hT7VmMt
 vhtVycR/+h6TSay1jKs4qKrM6M3BPJ6pA1+H3gMJj7uBzfUvCJN8v5JMOtErUKTSou1x
 ZFuD1zKXwN1ENoc9HUSvqeOZskHeQiSb6uq2/FGOLLMFsB22tdz8SVphWHKpGl0agoBw
 NWefkwLG7CgV0EJQWPx/oJ8Q6JvxMJhWaIlp2hGZd80SBnTJw3xUq/D19lbT8oUz8jpV
 45pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ4Vs+azeQmXMOVere734xRi6fepdYarIKJTfYAC7vC/YkZRIw3WD7TWA8QKAooI4ekrA=@lists.linux.it
X-Gm-Message-State: AOJu0YyvAljJsWuSCBlmu8fzKVUPLfrzwDRbua6JI9iF8bRHYYLZxSOQ
 QLv922X0IJ/O5VTQC87HXdkPIWAzc8KCQ+fNknjF0PfHTbpVe1USyo4O58vi91lb5Es=
X-Gm-Gg: ATEYQzx+VxyNRvjmWpIXTF+YV2RMVXZ5CtCi2FXsWtMCgM5gEt+QiQgqB1KqjPScARA
 72aMQ2ketpgNfyLiewAw5PWTDdFTKKGbIbGt8I2tTWw/YSlX9o690BulPVJb4rQG7p29x7T3Qci
 doN50AI5c9N6FsqBP+QISC2DbjRIO6eq+DQ/ogMI0M4T7HQTeLwFrymk7Y6AgxeSl/s+aeCOrcF
 85rDoIN5TuyudZ8Kwhmyb/yjSWuW3SnGenQISRtNqt9ePBmMnq6v9bG42Z8XjBNhTbWpVE2hOAh
 t29YeBmUASuda9PKRH1kWeCGo2lv36PbrGz99mtuAduymTB4rSO8Ew4yx630CX1dh215sX1vEYq
 os3ZYDJfEjgm789zqiZgD+VGEgBOraj5YUMN7bUQ50SZ4ChhqaP6C12+W7V5LICEBLOFY4QZjRs
 2fkX9mBTv3Ygc7ltYrtSHb6ftDUs6yfSfgZR70syskofMPg4A=
X-Received: by 2002:a05:600c:1c0a:b0:486:fbc8:8dfd with SMTP id
 5b1f17b1804b1-486fee231e8mr29523385e9.23.1774000223582; 
 Fri, 20 Mar 2026 02:50:23 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm17087115e9.8.2026.03.20.02.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 02:50:23 -0700 (PDT)
Message-ID: <69bd185f.050a0220.8a4b1.1ecf@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260318111306.98139-1-japo@linux.ibm.com>
Date: Fri, 20 Mar 2026 09:50:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/2] LTP: adjust socket xattr tests for kernel
 7.1.0+
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

Merged with the suggested edits from me and Petr.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
