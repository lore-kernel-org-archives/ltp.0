Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D04606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=lAJZMqzK;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ObvTBlxb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792636630; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qE1qngm+gIOPVrYDT6hJos2Db6PAoW9uGERHA+iuo00=;
 b=lAJZMqzKRQFhWkY+vCcNQdMRrTfuBDTyuRdg3xqSBtgO2OpiqjB/y9qFWZmZ768o+bptE
 JHGRH9InhrDt15Q3DylEy7YQlgZ/1Kf+bXd1hcTcF41BGuhAPuvp2RgefIiBAxTjWdvgjte
 J6U1SN4VuKF8ftPvgNMqU/LqosajeJk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8F633CFDF4
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 04:37:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E9973CFCDE
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 04:36:49 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6A331400BF2
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 04:36:48 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1259085f8f.3
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 19:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792636608; x=1793241408; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X2pxXYvWYzvVP02VbC3fbs9OzA+EVB07oRE0FOr9ToI=;
 b=ObvTBlxbFxN+j5FFf0kBN3+oq9v5P1ajxZPkoG47zviZXF8slS8anhL3dwbLfhF3T2
 UzqTDqb8gMTqMgwSdpe6CqOvfXfmHI7j0mnVuQdb/0RpMP78nNMZRY+oJTJin4f3G4IP
 8ZxX9IhBfhaMLXwTiCbJ8tRC4gZx9d4MES9w+tTMGkw11+2rs1Zq3lcPWOo/3iYM93Fk
 uIWrY8ApQSN7U6Dr98WKOsmpylSy59EywtaOpSoULeur02az2PMrhLNw6QqWIaFON8r1
 09p9r0phm/UM5sIQz9paf2Q57cvRiO2f19RRk4g0SBe8dprhEwerzv/lYDA4ShlEQmUt
 lynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792636608; x=1793241408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X2pxXYvWYzvVP02VbC3fbs9OzA+EVB07oRE0FOr9ToI=;
 b=0YD0cjiGRPot2PzfLQCfHmu70WGXC/Yqyk4mjFr4UTtdlL5LzIFTXaXOGkyM4irulh
 mRCpK9dLcv4XOZSl6oHk9wFPX1WC9siqfHjHUju9aW9vIZuA+tv7VIHPwzCcRdEFywx+
 kzlgW/ALg7vFHXBMHUw8b4auF9hpMoVR/uQbRGPjsVWghJlRiQ1Ct5epfojvzqAHH2cw
 eFgQp1Y74x24P1mg71Qqk8mkkdU/mcnEMfgO0trsIVniGGzVC9rqPAqy/68/iDsq5Akw
 O48gdqviwDZeIAaE8zRRDJkDXICXqpPE4Vk+WYPrOyOt2CfYonPIABQKl8X8RCVvYcXy
 qCnw==
X-Gm-Message-State: AFq9FYKcUx5DS2OREK/5Yo1hOpj/qdN37mhMU9bHcQJXfBeSWeDrplQR
 OQbOoKMaYiWZ7anTkjk0BsjN8YSgn1mzQjNCK4DF8xA73vUGhJCMEbaiYczrPL17Jtd/7Kyd9ir
 hVYo=
X-Gm-Gg: AYBFou0KDePSWacEGRLcnmeVIQGRHW5tyoCvIkArMEQBFMHiBNBLzHpIgeRtSP5f+gP
 k2q0+4w6Md/Uahw0t4P8SnXGMd8hpaVX0JcGCi/knfRS8g5GN/5ttsBmMqF/svRX5T4noM9ElPp
 lNIZzrE8T8844rgwPP30ebsnnnZHCiNREAC9icVPvsigV0K4qTMLu1WqDDRuFjk9dJmy7svftAO
 6ELXwTueDQj1uT6GqI/hfpO3IvzUSyB2blYu/5mI4RNhcLNl7l15R2tP+pNx8pv/FlgqMSLdPjC
 ccdMymQV7u0F0ZlV/or3juzvzJzFDq3UpRpL1jfowAiJ4e1UmSpmuAp7uU/Uu0pblpv/3Y6D2C8
 kb80orplMoVL+dHOTb6BNWUiD3cpjakT3G4hvIzlG4VluMb31OHW+uirXqiWxClnSoBGmcHnwYa
 JAhnWEpOJc+h0OEyOkljlS41l9OcjYls+5+nEDRalWy35dQtmSGkJz3oXSCTAFhAIQ19KRulb7R
 L0tZ0TPOndowjPIWQqKmPZWrvs3CxDvzllTiZSTa7ldsWYrYNGqs1JVYnzdetOtQ9NGXv5kx0Ij
 R4tskeh6HWtY8fq/qvrcB0GQsQ==
X-Received: by 2002:a05:6000:4815:b0:48e:84b:e83e with SMTP id
 ffacd0b85a97d-48e26427b9dmr7916544f8f.1.1792636608289; 
 Wed, 21 Oct 2026 19:36:48 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48e25828c6dsm9807509f8f.24.2026.10.21.19.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 19:36:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 22 Oct 2026 02:28:19 +0000
Message-ID: <20261022022824.19735-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v16 0/2] open16: allow restricted O_CREAT of FIFOs and
 regular files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v15->v16:
Remove change for tst_get_free_gid_

Wei Gao (2):
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_path_defs.h                   |   2 +
 include/tst_uid.h                         |  14 +++
 lib/tst_uid.c                             |  28 +++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 143 ++++++++++++++++++++++
 6 files changed, 189 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
