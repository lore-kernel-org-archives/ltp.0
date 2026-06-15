Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75592CD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781515792; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nWhKGbhlQuJjIs0iZxuflaQICl67NTOIAnK+cvJzXJ8=;
 b=HrZgTuEZsjczzrxTBJvRuxSQzCcwC+J36MI1K2eXPFZg0JvKo1o/ic2xSd016eLxTQofn
 vwrWRV/tRxtQmzSJm0eEPziNumlSFXO3eNEyO7pXftCu3I68UEJHGYzXHH3oD8L0/SC8heO
 SUtRCiqsOjnZGWKEo9qhx1rUk01ZLjg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85BB13E5B67
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:29:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6B43E5B4A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:29:32 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A98CB6005EC
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:29:31 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46015dc517aso2502502f8f.2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781515771; x=1782120571; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=m8OTPrv5QoS/pg8RIPyYdteQA9ngo7CwyzaBNuWcJGk=;
 b=gUryoihVat4RzwxG8ypUEaoslL9Op60z/HLNwa5Yz9+DuiWzRbbllR9Z2/ObC+sUb7
 74V41jqKLDJh1d86TC60MZnO1odlQPy399Q/EVfJ9NQ8obAMSaaJbUbJ7KpGnQmvpTaH
 1sl9VNlSmd9ffpOJHf6i+KPiku+0cisyErcINqlEg4rTLCVQ5T1HfjVTQ3ZgdpCRH8CD
 0O7WdxEVCNnIqPLUoK7RgDLiY9QUFcHoBMx3/59AOmUSX4o02xQGsn6jCbRp+Yply2Ub
 89mwpo0ZVAf5GCaV8T0/IubORfXAa8O+N1wqA62Cj9NIt7sho1zn73gbxdoStPVuy6L6
 gZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781515771; x=1782120571;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8OTPrv5QoS/pg8RIPyYdteQA9ngo7CwyzaBNuWcJGk=;
 b=cyWxR5q6BAicaMh/xgBL8s9Q/YDCt3JJSUxwA9orunJfJ+k+h6y7CHs/Hsh99E2Dnp
 uOku0iyHUBA5KDtS08G0SKwiI8VATKUoRgRd3Bkla4tou6Kvu/ksVM12ySZLuExY6ywF
 9iftZiXhdWj8bZNoyj09UGDRyDAnUi3X6UlVBOkK1qZYYo/lsoOrX101FexNsqV6RZF9
 wR7yquuYWq17g6CHaCPC8iidMqInTiUpOLbxDdgKk1AB5QtYKDpmxw60euQGUHBa6Oin
 fVC/AZHD6KiMwUBWelpi6qn+uV4/Bu3SC7uZGd14GeLg68HNmPXKXYPJVb2eOBG+SSQo
 iUpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6HLhQV3F2gHUdPMMLrKXWvvd0ul3JL5ApJ0uITpVCvRUD5jRIRuEFN2na3N3ffpLWThc=@lists.linux.it
X-Gm-Message-State: AOJu0YxKE6u9HHQZ+xZ2ZA0fkXrFlBePOnCrCCKFMnNrltv4jMxrknTX
 zSyLCHM5t14yYRT2Ez5BhNgKEjPpuq+Sb5kCUX9+0C8XFFeWpKoXvIoEDxOvf1x63XI=
X-Gm-Gg: Acq92OFXhFKg4YA0Ds7FXLqlYLGoI+5nB1aHSaqi0rycUKaimcyB4TU42yGxLryimAu
 F4secrcs1sMNzbgWK8j8gNKgET60JtFntmTorzMzpUZewREq0cpDVO+QrK/wNVaH2Ldi4KL74+r
 QrUWDpt6+ix5+uOcEy5KhlcfQRYXLAkRAuQjtESPcGEGFE2nFflkNN2E5NamkYVV+781jWnUNYh
 QbKKC+QGVde1ukZa6DKA2XbR5ygjyW+Ib1GqZt4afOrxWafeT4QEJ5ZRRDLW2fACdWyNfc1lqrJ
 Ldg5FYXWoBlyD4wfqRqIkphyNpsd+UjCQ0WNubpxUBpVRR7a06ckIRD9dAJbBCgjjJI8fryky3U
 h5qhhoe5n0K+ynJtR2X4lxeATdXms+XlrNHDB1eAiaSYAtRgny4utEx55+THJ9LP4ArAGfjNdDl
 w4r99xb+2t8YEhzymbStWW2tyTTvRpb5tJoGp+FfT30Zmyz2ZzYCgbXzmqfSFTpfMAAvoBUTz+C
 rMWkXCrNtpQ4kktpR3YrmRylM/d4sueD80=
X-Received: by 2002:a5d:5d02:0:b0:45e:ea46:ce11 with SMTP id
 ffacd0b85a97d-4606da6307fmr19407281f8f.14.1781515770887; 
 Mon, 15 Jun 2026 02:29:30 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm31248817f8f.34.2026.06.15.02.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 02:29:30 -0700 (PDT)
Message-ID: <6a2fc5fa.03c7beee.2cbde5.4243@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a2fc007.05603459.3d8ad6.7d03@mx.google.com>
Date: Mon, 15 Jun 2026 09:29:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This is correct, but it's also true that TERRNO is printing
> errno with its description, so the example is wrong. If any
> syscall after acl_set_file() will fail, we will print the errno
> of rmdir() or unlink().
> 
> You need to save the errno using TEST().

I forgot to mention to use TEST() first and TTERRNO then. It will
print TST_ERR.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
