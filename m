Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E800C35FFF
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742548890; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=kW3FTU4++5NBsLb8ovgfFnhMz+9MNV2MQL5mIFMlzUE=;
 b=iGgPpxFeu2KHSxdZGKqjHXkyGrjDiYHqiF8otVY15DUY2dFZPLlGH2z0i0dCZ5FyK1qB4
 qStipk8f7345apwz6eKLHOSaxW7KSjkEtnELdqshOMVVGs+V4KVXoKzqOkVo4t1/KnOKBDf
 vlNEh+p1bsypUwbL6+3oEIVliKxHw0U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7426C3CAEDD
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 10:21:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A48193CAE4B
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 10:21:08 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFB121000375
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 10:21:07 +0100 (CET)
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1838846f8f.1
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742548867; x=1743153667; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrHIFWZxS8Aw8b+40rYgVNTd9AjpA9ZJ6GsXoPOytSE=;
 b=GYCiDlkhCF5FwzUxjCaVezOADqYYTPmEGM5cr0iX3b/mV/hocaJ9uLyagK6N4QIzOo
 Dlbf0I+yGCpvUNk5Fb2aXzSJR6kLG4TUWYEDg0zHZYCdYu2anrdYs69eff3ZzSbtnGOH
 6Hqj4LYeERLYXw2fsjoP7J+aWSQnzoni5R8PjJQFfutbrhERKuLMGzjAQLFZWeWcOtuM
 roos1BElzc7JanBloZu8yn34FJjJio/1V56qFkoSzUcXQX862slDts75lCGAjO53Smdd
 ZbKxxB8d7fLTHd+Qc5yBVFrfKWmyghV1qeb+Eg8Aqi6h5h0gMyzY9D9Ye5Xn+AJrzOHD
 BoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742548867; x=1743153667;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DrHIFWZxS8Aw8b+40rYgVNTd9AjpA9ZJ6GsXoPOytSE=;
 b=EZ8er8D5lj71CPgOFOBIoYCFXSkqIyB8FIMUwiRIo6dZc/DJwB3e8YtsoqVRI1STdG
 cAb0bZTihUTBCAmLTQT449jTYKCrVOGoM8kTB9uXIMfTngPl9jpn6WE+HioPrt3Q+DjI
 Y8ywrPgPDeb3Q0koceZTyBYx/pc3K++arEuEe97NtdsHv86JpLuqnNWStGUjDBdn/udR
 wZB6KIV2e3kLL1Nfv6I9Zh+i0+l6Ggj7vO1hW76boRmhGK6A05IKhafL2bqLO824o3vB
 Qz2K5MHCYqMIvaEB8iw7RHrXg/Z097/FJJWbVf7QwyInz4Ilyymio2odo82NXFL4+jwO
 u+LA==
X-Gm-Message-State: AOJu0YzyyzptBLSPPsc2aEKw+z2qTNkfR/E6Am23m0cx2Kkt16oOA2XP
 6armpDXEFzGkvWOiefI37IF+Lb63ls5I5hc8ufc+NRNfmEVjO3FYuUbwdt58+1PNnGuy9QsvaUj
 62ENrkgPa
X-Gm-Gg: ASbGncvZTtQnP6ek8qOLUTgRPUo8hZbmVkg8NRKu1FkcQgd/p+gw0pBciTgpMM0g2NH
 Bub71F6cHJ6KCVdgQZ90hVem8CVfei/fmvh2nM1wF118Q0cyxiO3W02sqjEpsPjX3UH5ekqIsh0
 aiy9QzwtLNc/AWG4RzHdhO7oAwUVOMcYXzZhq8rlq4nEyxSyynlLHPpaDwSMJywkgBvKlGbWnFP
 Z2dvF4AqNBtaG0AAn7vhAwPdwJDUA82rRZe4j+iUFEy6u7dTmDfI6+FknQj1BJudnlVbWCA7a1b
 zKXaJClWvu/KxRTVBhImd3tCywWQTVTqpQmwTW/dchz6sKo81SeLTkh5Nih53WlEbSX14G6INS0
 7o9xmiSXpw6153Dsl5tUiNXoeRi/sVbJ7wbh8hY1PQA+ndoLmWZXW+zAQmutvTB7YAl2fCQ98uc
 eN5gKdFD4=
X-Google-Smtp-Source: AGHT+IHxA3fhlTcavfSTjdotALGuM94ygihvyZtnTw1dftlcfS5tPE4oxI4N3NqYbLrXIRx/A2iD6w==
X-Received: by 2002:a5d:64ae:0:b0:391:952:c74a with SMTP id
 ffacd0b85a97d-3997955cb5bmr5702996f8f.8.1742548866847; 
 Fri, 21 Mar 2025 02:21:06 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4d9sm72214005e9.33.2025.03.21.02.21.06
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 02:21:06 -0700 (PDT)
Message-ID: <529e9b45-ff7d-4aea-9313-7bf54060f409@suse.com>
Date: Fri, 21 Mar 2025 10:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Test Project <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open LTP meeting 24th of March 09:00 UTC
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP 
meeting.
As previously discussed.

Next meeting will be on the 24th of March 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

Thank you,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
