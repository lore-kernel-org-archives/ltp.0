Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A12AC79FA1
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 10:41:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AC853E54CE
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5A953E1895
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 12:41:09 +0200 (CEST)
Received: from mail-qk2-x05.google.com (mail-qk2-x05.google.com
 [IPv6:2607:f8b0:4864:34::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0019E200092
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 12:41:08 +0200 (CEST)
Received: by mail-qk2-x05.google.com with SMTP id
 d75a77b69052e-52ff498cf90so27113621cf.0
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788864068; x=1789468868; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3M9GdatjYBavc4qJUhq03scUJcNtXdbAEG/ApQD4zo=;
 b=BWVQPYS8UVgM3/yjUdKuyD3AMRiH8SFmAu+bnudExb8fWJeLeEcIRwkvIbZvpjnpN2
 zxS69heR4bsvFLf3+waL6tnauinvt/iRiIN19nbYF31Lhb5G+IROzzBjPWj0QJwTA1ZM
 Xc78j1HPlHl1EAFQLEWuL0BHqIR6SlYZMrlIL+fopb68Fal7JzeGhmSjqkOncstsUkYs
 QTRKtsDu5/BBTIhd9iDoYF97PvWfTVPC3QMuPDFNRS+1V8rPAnjBDZZWe2oyRpYEwVO8
 PtD65n2jzhURDhAm4rwXuY18/bkNUaL1Spd9O/CeYu9/WNfg7Rgx7FIC+483bdzA2lCx
 q50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864068; x=1789468868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G3M9GdatjYBavc4qJUhq03scUJcNtXdbAEG/ApQD4zo=;
 b=sNyF4WBK7TMbAK3NW+CLJMu3gzXJnFaCj2ivBPdNSBoJcChLIGVghww4VhREGUNKv3
 lQ+lvQSvS/X4kVcmVFYMIVV7M9RZiGh5lkvYrjzOiYylt9Y3RY96df6vzPhmtvHtUoCM
 N3rFr8P4vXsvy+mU8OvKrvlEUedx+e/HkvBhigxucSVVkzW/friEZoynjGb1fwEv+K+h
 zhQExQh2oNg5FQDqXi4dePpyMmx1gBbxfk47ow9RYQPd7YDw4r8VB5XiSUebCeZhNPZ9
 bZSeu1iVoOr5AvxXVsYqCpmvTF1+TaXIRhVazKVRv+UXY6JiXGbXYpF4IFRqI5KDayXd
 80uQ==
X-Gm-Message-State: AFuF++nGKlqD+PsJLrjvcjQWgQnHqnE8NgQlVAzQmyB9n2bna7SqK+o1
 5YtOvGol+kQD+2dySqUhuDAq0rfwv4b3uk02Map9jRY/s7T5tBxoTWMK
X-Gm-Gg: AYBFou1MbcdIP2TN8EoNpsvtfYGXU7SIID3PE92oX/ObXhOlKeI8IgHFM0RjD7+r5Gu
 ruZhoPO/RB8VTj0vdMDtCH23ykF6eNfVsD8kKvLx1I6fgHuOVlxhezcyTiuCKm+Rv+Ss6WBsMDV
 EKKBa/mY+6o5SZYZslu+DjgQuaeLqbW5qtlJeoE84fDmK1jmnazadhf9FOzfMbtOYnhwDA3A9GU
 FyueepGt7K69pPFsp8b5u/uE0uVS8Qtm/bvWaxm9wLlwm05IcQha7JzdmB1ZJrk2OHOBK5Tmw5w
 6VP/8ZHBsufY0WhpXKb+Wz78pZhRMEl7J4dsrt4XJ5qeR+fhlkSerwKidLtaXOcjcvKAb6n5AIr
 Q3xAH2qKo+zymJgof6rwrrwB1o6XZ8eGKrs3607YTBlYT55gk6ZsADNGD56N2Lx4E7YExrRvgzO
 fHRYR09k0NVJDHYJNodWjCl8sVmuPmLwgPcVCvjxkkgoCz78+NQNAQpLdQTb4rPRmEUn7iKq5PB
 JZWQGzHPBOfEI5bNTC/0R72WklRtfj9unA5/El7dOEA/0t+XM3kXJ8zOw/TDmnzrRmhIiWqllk=
X-Received: by 2002:a05:622a:e0c6:20b0:530:8c7f:a828 with SMTP id
 d75a77b69052e-5308c7faae7mr76582701cf.35.1788864067675; 
 Tue, 08 Sep 2026 03:41:07 -0700 (PDT)
Received: from
 runnervmejwal.11dd50q2uqgerai5ailtq5mtfd.bx.internal.cloudapp.net
 ([4.236.158.85]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530541992e4sm109001981cf.21.2026.09.08.03.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 03:41:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  8 Sep 2026 10:41:06 +0000
Message-ID: <20260908104106.4123-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908-kirk_4-2-0-v1-1-cb51dde0f5f6@suse.com>
References: <20260908-kirk_4-2-0-v1-1-cb51dde0f5f6@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] kirk: upgrade version to 4.2.0
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue Sep 8 11:12:54 2026 +0200, Andrea Cervesato wrote:
> kirk: upgrade version to 4.2.0

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
