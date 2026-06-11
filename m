Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2093CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:45:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42C453CA9FF
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 16:45:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57F9E3C5E6E
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:44:45 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EDF541000986
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:44:44 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8ce9df4732cso82976236d6.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781189084; x=1781793884; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rsiJdNApIucIYvYOrEzjwl7VTTPLuVL39Xxs34mcJU=;
 b=SpMwqzb+HP0w7UKo6hqxShGCpwHB+yr9zLBsn6Kr7N3z29IsiGpnu6DNRZNdLqWBXQ
 uml0SeMKE5wuJ+fnUWpzLnDEFyOU/ObN/23KvZdpiybJ+9pKYXQuZjHlGLwe5n3d35zg
 +ZgQneya9wm8n1kRnQnaYiJ53Pw7R1qQ+muNu/mEEE4yDAui/d094u+yxwvAq0zY5qk8
 KllAc9/VIKz4u7qiaureRQTrv5lheqqE7oVWLlPCaj7lQleM6x/KVi5IlwodbfxqynvY
 DVj7W2GbjS1zELBDpkOY2WEmkXf2xNKcUgvm2cj5pqvmBzkynZcYKlwN1tnlk0pdJkGc
 Z55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189084; x=1781793884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3rsiJdNApIucIYvYOrEzjwl7VTTPLuVL39Xxs34mcJU=;
 b=e3cDSjA8pYHYBZQgGUiNGIdDtINzk/8p0ZgrCXmJEvKzjVDfaqv1OeQ7VrF0F7ilON
 1XLYl2gGohJfP0XxIOhqzg9gT9QZ9kiYa1wWnmF9K67r1Q75sSkjAl2c6isaLTc0Yoh0
 1cCfxfWemzVJCtl/knc8Xlc5n/i+ivopLtXJIzKhFvdZnIf9s3VlRGruZ/0jGNrMjaBP
 ht16Wf82vr8n2FIh8zInn/gcuOj09Bebi6Bq+12bJX2bA+54xc212s+a5ZEndqGTPVu0
 ebV3HXZIs/MbLXHVxQDKyk7kUBQLAzTt72iNwLEuDj1WjcyOBYptBq0pZfkYxjT35HjO
 u/Gg==
X-Gm-Message-State: AOJu0YzYwb+UWNCLFOYwD6H+OQ+uMPY+qriBD/zLKdLH4HEkYKbNPsUR
 jAOUXLFqDpAFFFdOaJLt0f1yx39pjI/doiNDh6lindg6ICjOW59SFuI1
X-Gm-Gg: Acq92OHn1V9k3fCqj1uKYfSGxwqhzRlkg/av+QPLJBcVSMuzIluTLelAg2D+ta7PZrQ
 Gl+Qs5PgSXL4cIRmXnnF0uTZ8RC11+p4PxKx57aN1VeCyBESWiQAJptvj9ViVVqGFVmPqR76QvD
 vQ4A6zQ2scS34Cxk5Gpxm+KE5kGqUqQDQLwa5DdBxbT8v2+YcbiFq+D5aiz3nyTDBJG9a56sTxb
 BRzoErxvOoWOkNzK9i6nrt7x0sKuqQpZZJcKMtMhBR2JJbwW1uwSdHwFv9KAJDWCsz2u88M6drW
 KIFM8tJl1Kipr4JkLWbC50USH/o4xJjutqJqG4T9TY3Y1Ts6t+nQrIKnzm2qZrx5L8PGp0oBjkV
 fVgK9Obo+zkqa3TN4Oc306Ugh+f+Hl/KuydK9YCIL8C5JiyucMMst76thCN6ItvSiYJguo2mPcq
 erZQLuC23RntViJK0oWH0z0EEyk3nHTJ6+rUSbRovFeDy3aVmGDNnThmptTsfIkag8m4skAQBT+
 Bo2P8LEv0uA5sQErLOOZM8VGhbi3oXIzwNhgv29EyGMLS/puA==
X-Received: by 2002:a05:6214:2f81:b0:8ce:b018:89f4 with SMTP id
 6a1803df08f44-8d1db202353mr49894246d6.37.1781189083668; 
 Thu, 11 Jun 2026 07:44:43 -0700 (PDT)
Received: from
 runnervm3jyl0.g0vjefpjgiqevk55v1qvz15w3h.ex.internal.cloudapp.net
 ([40.116.72.213]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d1ea7c9260sm20770016d6.27.2026.06.11.07.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:44:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 14:44:42 +0000
Message-ID: <20260611144442.4113-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611-fw_load-v6-1-c2aec79a7ed7@suse.com>
References: <20260611-fw_load-v6-1-c2aec79a7ed7@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fw_load: Modernize ltp_fw_load kernel module
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

On Thu, 11 Jun 2026 15:44:19 +0200, Andrea Cervesato wrote:
> fw_load: Modernize ltp_fw_load kernel module

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
