Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE71C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 13:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB8063C8FEA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 14:37:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D73C53C8E99
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 14:37:22 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 826F811F3C44
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 14:37:22 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ded1395213so3644850a12.2
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 05:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740145042; x=1740749842; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Wxi7C/deXgnWgvIZ0cfFCyY5gmOzfgj/s3swNRDvLA=;
 b=h2jcGeEPqYFcVFBufLD2MiMW/MwItEQwyb1jjB5A7/gP4zpB5jzveGtlfTj4WdUmJd
 J1vAEwBqNg4QcXGkctqbPZHohFJqF0gWTFjfJS4ZOA5xsOOtfRrmBVt+Bt2fnivH1RVR
 +I2BoVsZ0YrV/VjaQVbuWG5phEZTvjkwyrmRkcUAnrm6Krr+lM8Ary9dkXMmolni3Emz
 Brrod6aMqSbWfjvdykOol+NccF79RZSs6+q9fUhboJUSXvZNjrXG6OMsrfcQbzctrltz
 Xq/CChQCo0cvlG8jY+FNgPL5WM6EtlB2fW2iLZLQGmtkgUU/DdllCaCR14Ol80cVONHQ
 Q7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740145042; x=1740749842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Wxi7C/deXgnWgvIZ0cfFCyY5gmOzfgj/s3swNRDvLA=;
 b=g5TFUpFfzEIwxe386c0WDBfLfkFtdiSRqeNyqLKLSCxF4S9QNCTgCJ7O0rawQ+UIAD
 MV+nNTkm2RfO7E17mzBBbds+BDc3xD8bL1BRugMQkA02YQG5QaqaH771ArAZr5q5QPTv
 +p6vY/Gcb7+sDbuNGAVmnjFfyBmS/TdnVdngXu0h33tri5/uFOf9/Hi1iw9nV7pU3fRm
 Ebh39+ccTzbJ8rccCspL2SJCjIsEmfU5rPjuUKCUDY+GuJ6WAr53cdaCBf5lhxi9FDG5
 P7w61XW6QbUn4Sb5uV0gVEGfdIvJ4CkB1UeGTUqO8asAz+KL4nvRKd4k4jFyLSux/MUT
 6x0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuBLSJgYfS6saPWbNlU4n9JCR4qEs9rRnau1iNdkofSySlbI+ZtJuNp+CppBUKCMtktNU=@lists.linux.it
X-Gm-Message-State: AOJu0YzXVuIUpxA8MpFTiWmjHKbOheMQ+yqepHoPivLhytdkKDLoeXXT
 aKn+RYS46BAbZ9hTBSnyZsLF9IIH5Z5SLA3Sb3gyUxzwbAh/4jDed+OGMATa0oLn46+YijKEkxy
 tOSrlIdBVuqI0P14LRIuEqq3VaPY=
X-Gm-Gg: ASbGncv7g8Tc4UmYA0tSuBFNrU3C/+BzZJGhsFxYJTilvXsGCwk7kCUU8PONDEzuc+o
 wZNZuWRmQLGUcgBBto0k4rMT0gPQIYrM0DKOh3DEbJO8nDVcmsGiIFa44qE06XMycobxRxRuIXq
 BrVwa8OhI=
X-Google-Smtp-Source: AGHT+IGuo15LE0IVRVtcOV0f9GqkxcFlxciG0TSdI8vVX42gATzHT+xX0kRLeguRALsqqM95N1LDSnz+5oSg2F4MJJs=
X-Received: by 2002:a17:907:c2a:b0:aa6:5eae:7ece with SMTP id
 a640c23a62f3a-abc09c0a5bdmr308875166b.43.1740145041484; Fri, 21 Feb 2025
 05:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-4-amir73il@gmail.com>
 <yvpm5aiigldl2ftkatepoddjitxs64r6n2igcatetyukpbp3re@35yc3muudqdf>
 <CAOQ4uxhex0Dz+c-DM9emgqhsYMar08NC4JSuc9TkiDujmN7h6A@mail.gmail.com>
 <20250211190943.GC1911494@pevik>
 <CAOQ4uxg6T+oO-RUcs+AA2W2emC18hboQMec7NUnQ=zFqoNPjbA@mail.gmail.com>
 <20250220204253.GA2719924@pevik> <20250221132628.GA2790724@pevik>
In-Reply-To: <20250221132628.GA2790724@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 21 Feb 2025 14:37:09 +0100
X-Gm-Features: AWEUYZnJP34QXd7q0Qb5n6BSHXNzYOFJdiNfdHlkCCOztuvvLMCviSjMpWNNZ2Y
Message-ID: <CAOQ4uxjK6auyG8FLOjzy3bYggYbNr5=ccuuV+isC8wcKTzP99w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] fanotify24: Add test for FAN_PRE_ACCESS and
 FAN_DENY_ERRNO
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
Cc: Martin Doucha <martin.doucha@suse.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBGZWIgMjEsIDIwMjUgYXQgMjoyNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+IEZZSSByZW1haW5pbmcgM3JkIGFuZCA0dGggcGF0
Y2ggbWVyZ2VkLgo+IFRoYW5rcyB0byBhbGwhCgpUaGFuayAheW91IQpBbWlyLgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
