Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4414606A31D
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=jhzxpC51;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Srh3Bf3V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575223; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=jhzxpC51VKZb/ver3BWief69htdoBvrgdk4aRo/rs+eKFOyaz+Km0Cj17Yr1I2N4NC8rH
 rrcV+HhpHSrYBJw3xpQIEXGzmeUvrG0xH1SapYgqQcDbT63g/LxSZwbLMA4D7qGe0jN0B4X
 mcHkLekTRHz+uBvvJpcWJf4PE6c1Hlk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 722613C1AA2
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:33:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA2A3C01EB
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:33:23 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA9781400C68
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:33:22 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-487049569b6so311080f8f.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575202; x=1793180002; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Srh3Bf3VY/jczSWSexFqN4c/CFxplCghOeEZaQlz2jgDXQEI3K0obrc/SFsvBLztCB
 EGTe7qEBb7yw48wXf/u8T6DZwn+cPw6pzvdGjYY68ycoWS8pXyHq5/VIsLSe+XZ8hgls
 i0WLiRFTEx3LryrlvGrrgNQfluhl5Un75fV3anAFsUig2elVPbB6AO1M+bVbbBwa+uyT
 E5C1UVAbmJ8iKURv0C1XXtwnciU5u1Wch+KDlfCDGGq06Yzobn5Ajz4sMXlYJYl+cOrm
 LHAJaytpuctXdCOVsPciqfjYELPMLohxQ/b19AZnftc1V2XEO8kS2hal5Kx7e5KmXLTN
 mziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575202; x=1793180002;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XD7+3Hi2Q4Ypvk803nHstcoIwjWLkElhkBENW4eEcbKklONaNo9wjIhTM8svdRMXE/
 auMh3ZBP5U038Lew34aINoN8wS1hERACGULO/+ij+d73IUuoth7hayxiZSxqxGCRJbKI
 s0yl1aFeCxqdu4DOF1M0A+B8ZqGekmHVnyxpMIjK1F9AVP8zOmUddOqAkWTJ8Fu6XABY
 pgy0bnbZPJZ1TFdZreg6QMZO2UETy5gKxvtDTuphElcszU03T0YbMNwqM148YlySZWIa
 6PaDO7KFFQs8oNzsYtxJiFgeuCjRDaKXMwLTkPN1j09HjisT8l0goLzq4aDBrt6RvZPW
 WxDg==
X-Gm-Message-State: AFq9FYIdAhzC86IQTDzN0IQIgoRyzV07FSyEgsqHGREGHg1f/D9XE8DW
 2N6csEMMTCW0sSNu5olQW19UBCqeO0qYmtMrwPsOimsDOG5FGChFWQaWPOLriYTnNt3lXcIYWSZ
 n33SHxZ4=
X-Gm-Gg: AYBFou0s0w+P5E5/lDtSL8t+QLpClmw13gvkWQiQo4smhAi7N9rH6VITtL5rrD3Qwsl
 VDpgQU5UVe7jQzYLnGlMvuw2z3tC/Z12Pv/YU7e64gvy+YKphb0aawe2UM/9mziE3b0EG1H8y1Q
 TQghFVplL/Vtju1/nZ3mhfA81AfhspcR92OxVhmb/n35TBEC+5V2NN1HpNvGVEMyc+dL622zYZ+
 RN5uqW2VOvJPwZkX+KvEnYaJ6J2zjdmfJjeXfPS6gb9AzgLtS01PEyCOLCqoTgt6T3yH6miWOri
 WXBJvEwgVPgqFQ6956ZlYCJnmzMz9C5RoQXFSajbqEUQyV75y2HiCmKiNR/eC1asKhkBaJcdU9u
 FzN/VvkDmJT8h8Pw/7xyOUssq3b+hyyRCQM/umHXtNIEFHRznu1bavzLbQZ5iVTdCf8GQ25eP2E
 /DtSujfZ338O8CS/SyJLYbiNdyWTNegSpSZf44kbE3wjn3Vi7rQbp1RTe2nKVaB7cJj7oLCHeIc
 49VO2wMjYo1jEnfwksff4JfUHGMCJOgc6LIR85Rvq2p0lacriSah6SV12hQIw4et+OBvqsm4YMq
 TjIMrALqL6r6y1UGt74oR/nDbIq/Dy6STfyaxAM/xFj7PT2WGJVPra36YWCOvnQLNTxiZIjpWCv
 LmjUd
X-Received: by 2002:a05:6000:2990:20b0:48a:fba3:d5b1 with SMTP id
 ffacd0b85a97d-48e264ee716mr1980895f8f.55.1792575202211; 
 Wed, 21 Oct 2026 02:33:22 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cbfsm4226585f8f.23.2026.10.21.02.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:33:22 -0700 (PDT)
Message-ID: <yvghh4rRtY35Af2DMzcAVGa6TqwKgHWf4amF@localhost.localdomain>
To: "Jan Stancek" <jstancek@redhat.com>
In-Reply-To: <dc45087f4a5dd1700aae6df3a8181ae349f2bdfe.1792413269.git.jstancek@redhat.com>
Date: Wed, 21 Oct 2026 09:33:21 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] float_trigo: Fix acos/asin/atan input generation
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
