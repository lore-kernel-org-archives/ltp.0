Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC5AC3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747061006; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YFADBcJHy/daGQUpV4+iyoTDAekpVCvhAXaQbthk0d8=;
 b=pX0fLrvv/A42IIxQwpLsCXMi0O3PdykYMIQcBgugTo+aERhy+2w4/83EhE+gUqS+qoJXl
 pwvUXdFJZTM5fYkCf5mO8DqStmSQMEhOjXgJISb7bvaDtvgA8an6F8LA0N8xvWjxuMSsXZn
 rqAnhuILS2dZCxBHFGT/qNR0Hiqhlxk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F29DC3CC2BF
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 16:43:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2633CC2B0
 for <ltp@lists.linux.it>; Mon, 12 May 2025 16:43:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B6739600551
 for <ltp@lists.linux.it>; Mon, 12 May 2025 16:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747060981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wj24/uBanlDOv+Xz+YROQaW0hYQNBVyS5Z2jT4atlRQ=;
 b=UPYhpGAqEC02iNI27A1KjWNz4CgXAfAiJvJPYHzUh4BR2z+L54mKqZOTLo20dFSt5tfvUi
 RhgNSxBI77pSeiRzmLKhKH4RmorwDGluWnzDZKH0QOtu/BDgZh8xMx9EXFIzuSRjZA1A1O
 f3EQJdWkDB+PyjlEKFWXYMwyr6NyLtc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-IiuHJrULOXqCZnBM56hmKg-1; Mon, 12 May 2025 10:42:59 -0400
X-MC-Unique: IiuHJrULOXqCZnBM56hmKg-1
X-Mimecast-MFC-AGG-ID: IiuHJrULOXqCZnBM56hmKg_1747060978
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e50d4f49bso67377935ad.1
 for <ltp@lists.linux.it>; Mon, 12 May 2025 07:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747060975; x=1747665775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wj24/uBanlDOv+Xz+YROQaW0hYQNBVyS5Z2jT4atlRQ=;
 b=i34CNR5qnAu8sBvu6aMl0U3PZY921Xj0hzpZhk4DE6Y9pGcO5v/m2mtAauug8ZlaFk
 D8RfaEwck7dMhigH/EALQzattVzawOxgP+olMr9WegUPjfStDH4T8uJfJ6BUcmGAnNVA
 k1uPIrT+H0cbRGjO8AqnWEgz2kOv7lAHpL1h5pNShoJdV+KDxqGe/DEnc+wgW/wBxpnC
 i7/aneo0OF/+5tFcscSnsp06vedZ95szpDwIccNeKatnJXsgSliBiBkObqlnBfZJGrHa
 4Pe2b8vVAbbCwefOrR7RrSlS819krNqGcHQVuqHSh0WqLwxpDC5iGeHjEfJPgb61mZ4w
 yI6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC90SBzSywuRcNsVCFVNPhAdZIi6JezH0yYnSkJ/oM9teN86cSy+gz27mwPVPfbn0DFZE=@lists.linux.it
X-Gm-Message-State: AOJu0YwtEu1C88U7ZU1ZbYOJZ8uDjNo9AcwGe8SjDqW+/pSwq8/aWvD0
 Cjpir5hfyNMDu5nTgJG8SZW1kW9I0KfBGXj2cU3iE3mkZMxzsYhQ0vDdRaH3fS/3vHm0JR+4Q1u
 5bLN0ADsGHuszhBXZFO+BEIj5rjksyzXmKF+jt8pwCArHTQ+Z47fxXkWWreyX9pbRHIid8Sij9U
 3vq2YPXCucO6NTxNHRmxmNJ4Vpy/6LJ9S6kA==
X-Gm-Gg: ASbGncuzaDd7MNgRVFn7ekFVG5VNsAzMoTA8AkJVEieEd48ukNncWkovzv7rOcVO1Ks
 gV4bf/oaGyG7agPCn+e7mzpXb+Z80xc11kgZ/Twsi3mCa1bZ+z/VIYRic81fpXh974taROg==
X-Received: by 2002:a17:902:e94d:b0:22f:a921:db4a with SMTP id
 d9443c01a7336-22fc918c3famr179984825ad.45.1747060975535; 
 Mon, 12 May 2025 07:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3yMnhGDUfgI36i+E0sVfkD2gf0o1asGmRrbA1N6aRKn6kJmz80cvxZc92Ogt2B6zdJubVJq7IHus6OyX4FDM=
X-Received: by 2002:a17:902:e94d:b0:22f:a921:db4a with SMTP id
 d9443c01a7336-22fc918c3famr179984395ad.45.1747060975033; Mon, 12 May 2025
 07:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250510205326.1353857-1-wegao@suse.com>
 <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
 <aCGyTkkA6iSQHNzg@yuki.lan>
 <CAEemH2fbbqZU0ir-9YQ6wh2v+6EXveOr3NRkjhk0MK1ipF_xkw@mail.gmail.com>
 <aCHX9rcKFhQKbxuM@yuki.lan>
 <CAEemH2c=34SkdSmEVvJR0Yiqv=n8jFJgYgr2L1AOL3Hxk3msqw@mail.gmail.com>
In-Reply-To: <CAEemH2c=34SkdSmEVvJR0Yiqv=n8jFJgYgr2L1AOL3Hxk3msqw@mail.gmail.com>
Date: Mon, 12 May 2025 22:42:41 +0800
X-Gm-Features: AX0GCFub0-t1BDcsQ-CEABnNalFL4m13oVvFWJKDk-9K5lXI3Erhb_kBPaOom0g
Message-ID: <CAEemH2dM-k1+5q8p9oPpdtS_iT7NJPxA3bGS4NY8YuPqNTPXHg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u3rzpYPUPpYXp-LirLLG6CWWNBavUUjcOdZedqYTyKE_1747060978
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with
 error due to uninitialized lib_pid
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

I have just pushed Wei's patch with a refined description to
make it get rid of the failure before the May release.

NOTE: I'm almost done with the new refactoring work on IPC
and will send out patches after my testing.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
