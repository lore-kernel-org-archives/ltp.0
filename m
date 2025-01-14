Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3973C02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736865169; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=g4U/XDGFKvkKsxHU0HfvIMbTU+UIAsWMQCY2t7p0dYI=;
 b=lOmhTrKP4P8vS07kOHq9+NN2WrWC3xaAM9exqEO+T1aoNDUp3JV1ddJl2G7o3aVG4Jqy8
 kUhFlRxfyNeIhm+tUNDvYFuLaZkvyGEJgyoq/1AsbM5aYIQAtHlXZgQ34tz0C4mkQhtDvXW
 1/kDgz8AG6/TsnWH7V8PCItK5ScnPms=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E21663C7B04
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:32:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40F023C7A24
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:32:27 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6727C11F5F3A
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:32:26 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so3951718f8f.2
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736865145; x=1737469945; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1Y+hWXv66QVHp4cEfTkFx7RO925mOu9UuQCPA56cGg=;
 b=Nmj3fwuYsJgwNZaWmTjr8MZz8kmLC5546YIeOgZDiWAVaDUZX3OoRlbgR4UVyK8P9O
 KVVDq69o4CY+IxLQHtNOnKG9i9YBwAq6Ogr3W/XKjoMup0F/8E8THS8IWyDA7sLH2gUg
 bZv0OT8nVg9mOYO9dpEZ+ha7OE1qjG7IzqN22FwvUgC6sfNrm/BvC/U6Yy799kOYnxu1
 5CyQ3ckCPQCbyhMAahtsXWtfS8jjABheHDecxneKl+BpAWDSIRoMzCBecOUGVACUi3+Z
 sfEtWW36OMraYV9+yFuqBZX6kChg4vSzCOZmASAdg/A6NdLegEDQBkQGaW8m595tpOhA
 EC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736865145; x=1737469945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H1Y+hWXv66QVHp4cEfTkFx7RO925mOu9UuQCPA56cGg=;
 b=UvbWa9sl/rdWumWdxMfEATjL7v1k1Zt0LqK++l76oXscf2cj62bkmk2rIDWQmziBcP
 adrepnCsK0i4xykSDStCMq6aleOluWJS7338nEh1i50tRxt50vguwynmvmSntAuhcw2Y
 srKXDSSn3M/hV1nEJ+FMNOX6GKvSNUdgCMF+yde7EAH4/D0dY5Jq/RQ6pssQ2kNiigQt
 deOuQpjdMdOpr7S79tWVuuT0LkCZWFB1bhmRUe/Caya4AOK6bSw4hbe8GIEv4PuqUH/4
 HwNW3P1rqztEUy3GWYhU5SfGb6ePzH8JuvzX0LQ8UdjrSXA7B0BNPsDZveHOl2GDhbp9
 6iZg==
X-Gm-Message-State: AOJu0YxNk97qrv9QKJz8LKT0Yh9qGrpyqE4y1IgRlEz1d4StTKr29//i
 8IQriFMMEC7lVXJftiicgLtE/slqqBSaeeBNJdYcGs2iyCJAMw3tRjc29tqvNDvVYL9JD9k+Nko
 =
X-Gm-Gg: ASbGnct7cjBsbHml6LXrGJ8uxinB8W5AjIE8dfGNuRkkqr3egq3bfnaFIrDRGQIY2L8
 6SeWf5xnHlyui14ixHkdO0AD3LTSTPsMHSUxvzlmEGO3HzFRjoDiv0lCHKQ1fJG9XTGDfohtqPh
 EcwcxgFS8BTx79yizy1s6ktz53LA3+TKDFRZ108rCFN3nZxaY4C0T9DaFC2ajGJYxIGiP+N4bio
 qRYQh5+8EjKsMID10ILOT7BAj7Wok+T/WzsM2+kMeqTUg==
X-Google-Smtp-Source: AGHT+IEJIU4HkszdroRJab9Trrs0ng1lEIN5JC1OJQIXgGUctlJurHa7/65bG2GlkHJABkhDQmNWDg==
X-Received: by 2002:a05:6000:1aca:b0:385:fa3d:1988 with SMTP id
 ffacd0b85a97d-38a872fc2d2mr21059750f8f.8.1736865145630; 
 Tue, 14 Jan 2025 06:32:25 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm178218355e9.4.2025.01.14.06.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 06:32:24 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 09:32:15 -0500
Message-Id: <20250114143217.21018-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250114124023.4702-1-wegao@suse.com>
References: <20250114124023.4702-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/2] ptrace: Refactor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  ptrace05: Refactor the test using new LTP API
  ptrace06: Refactor the test using new LTP API

 testcases/kernel/syscalls/ptrace/ptrace05.c   | 218 ++++--------
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 325 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 3 files changed, 252 insertions(+), 307 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
