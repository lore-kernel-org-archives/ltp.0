Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09469C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788440886; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Fu3eQ5wnxa6SGAI1aITJj8qDN86nUls6H6LQdcdOFGvwjvaTJQ/B2BrzkpKF2iAG5u0xN
 RSLHmA8gbGF2IOD1eFnSVmbky2xDsn0k9DxKzapD0t40GEvAM308L8Tws+g481+Q0GaPIJL
 p9eqa9VlRBu2Hc9In/CfH2b9u6hGGWg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 829213EAD89
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:08:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBF4C3E9818
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:07:45 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B1051600146
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:07:44 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so21300945e9.2
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788440864; x=1789045664; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Aip9Wb8XCZ0VRi3BnQaDQO7SUJtliy2vBOzlFExaRQhgkMN+37OMu65+29PZWp0SAB
 6Pn8WW9JL+K24ZEJk3cCklz3ibl0+rcHSab2nC4YZUXGGYyRUVB5+/T1q4mZHczAEGDN
 oTfzSJwu2oavJ2fk4T6vWkcyxbDcyTqDs+uVnxfvXRvkypfCkS54KWCngKXu6KRZysXD
 ImvlrXZ7YuvyorBgZji4dD0fqfFAPcaHycBW9SLV2PIWlq6qKcB8rO24IAwF8RgUYZ+S
 7/28E/CDBO4tLPhnGVjtCTsIHMt6VPNN5+sM8NMa54C3TODk1JvSXnIUEZ6r37HI72bk
 0UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440864; x=1789045664;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=gzZmsWBznumpiGoyRyXdI3l8D4XuLxoP5g9l2wtNaDHU1PeXtsPqBygTevhvOaBEha
 qUs9lps5H4p4/mDhNh9kfoh0F5Fe2CGWye+C0l5pLV6Bp0zPcXiGL+tdUtPdbCshvVZb
 6GcZxZ40aLzgNM86Rra4HTxuYA2izRta+5PrjJpevuMJKL0Ky7YZqwzuGaRkSkKiyImE
 l/DrUfE/ty9mLZu0EQLVbor5c4LVzBEC9cxftMwHnGOFg2h5bUfPtCQXU9UgKv36H/eW
 yHA/3q/wMQd9P5cgkKkicxOO0za6co2NOq5VjaAIUvU2Wd6C+87cK0t3ZQ8/dKrA/dbm
 am0Q==
X-Gm-Message-State: AFuF++lT8oUzDK04yBW04gsVRySQC/8F3qSVMXqbTUpidg4DWur4/zLy
 rjNsPLtIcTFk3kFtq1Sh9RR73+prriIf084gWot+/5iLJjL5EIT+O6GLPpKCX/FstvA=
X-Gm-Gg: AYBFou2lgmFN4hbSqkB6fvqBON8qT0Nip9CQ8lHPdMS7TiLIkNgzqL5libYbCgB0daX
 OVXO87GzNewjSgk/jlYu7pNL6ixxZx1L2F7+ssaMb5T6tf40/xtZS7xnBa/XXmMwYlI7yloiMbN
 DtRjI2y82etkQBrsq+92UVsGUALgm2/7uM2eArtevJwP69W1Uk4JnNlBEhnjsiwUpQIqaIS+7fy
 5+VFI6uciNHa+8+euuoK8m1fUTtjTlDL6sMRiuNtL1kLN4AjHVbhjT4h+gZdWGBx1bB7f+pZxB3
 bQGb5pHjVP7anBMQqH00Sb1EKKuyW87SqmlBbIebYJnKXVVNS/Ag9DuUZslDfMk/Bo/UV609ERW
 INznFN3TZCuLLHPBUSyhvPk830mx4EOTQEWOEEz1wDXJjFUZRveUp3qN2z7Bl3jzIgwaKDsoZV4
 jc71WC1QZG3l4ec4iHKemVOdL2GXhbvSt6oiwrjhOx1uU0jFaoNEKPmEc/EXDh6XRh4OLE8w==
X-Received: by 2002:a05:600c:698d:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49cf4e14cb9mr42196005e9.16.1788440864077; 
 Thu, 03 Sep 2026 06:07:44 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5952560sm110485075e9.3.2026.09.03.06.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:07:43 -0700 (PDT)
Message-ID: <6a99711f.b4a1b9d8.179596.5b05@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260902134019.163296-1-avinesh.kumar@suse.com>
Date: Thu, 03 Sep 2026 13:07:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ioctl03: add IFF_BACKPRESSURE flag
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
