Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0586E83047
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 03:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770088770; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=++YqDMWPLu8izpKfUAN4vAvzbr0gcLbDgd0m9XEJ7SA=;
 b=GzIw3juh4Rfse0+nVXMGt0020nuVw0zPHtr7CjUCHAwEHRUXu3J7quhTyxrEUfAteZQaC
 w7765RRA/eMzs6Cmp6IRm3fn4EzOokGeTpzM5yMCq5emGHY73j5kAMYvZib4hMz9rD0NBe2
 Mx9Np/lrGXn8TgtNOuDTo9kwe2+Fp8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D1923CCFF3
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 04:19:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84EFA3C9CCA
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 04:19:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D639560085E
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 04:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770088743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EJzf0AeGtUrYqZKYSJ849/AvKLCcsMib7l2aTp1ALBw=;
 b=hriD1a8PL8cLx3tB/m2Ocwc97vFQr40agGfY4ihUsbQ92DiRFRSwG6TKg/9VmfcaerOOFQ
 hdX5XP9UmHNQOJcnUWOupgVFvwLHSobKhu4FHZGFczZqBhQOrm9m0BPh1e94fsbc3mKlMw
 h0HZW6nlfOK8TfvbmI/2yksF9aJaRUk=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-KUk0GogAMiOyjAaO6Bt-1A-1; Mon, 02 Feb 2026 22:19:01 -0500
X-MC-Unique: KUk0GogAMiOyjAaO6Bt-1A-1
X-Mimecast-MFC-AGG-ID: KUk0GogAMiOyjAaO6Bt-1A_1770088740
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b75222e9easo9943672eec.1
 for <ltp@lists.linux.it>; Mon, 02 Feb 2026 19:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770088740; x=1770693540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJzf0AeGtUrYqZKYSJ849/AvKLCcsMib7l2aTp1ALBw=;
 b=enK3DIcF5sWxpGLz6QhA8Fk1JhBWVJ7z3DDd1N3ynbJ3MYQGkQ8k5hvW1FOt05MC+b
 3vI6g+TDLzw84oEmKiK0FL8WizJEQ8kiUbJARV00u1d1xawSrr81smYbZyWv00JdElg8
 uaGgNPifcBkyYkI/A/McX516eQEhLhWsm5Rer/zqV7Xxe6mf9+2F9OgICpuZ0vo+cQ7w
 YWMuOA3a5LkbIyRIFm3o/Ey7NDBW+YPIDt6YLL8hVZst0rGE/9KKlbOEWKO8NnpOVDyT
 GjgSJO7JQEeIu3jY4iemymstu+gZnTvhirjxI3yllEqCYctldBAB7cM2CjoYoFfJrSer
 e81w==
X-Gm-Message-State: AOJu0YyAJlizH/a0QK+/27Hry1e+2jJlsrjzqhgBxAiJnuBg8KWqiFbb
 c82FOqf3/gi0FJ+rNe+7lka1BTHbNrMcuMHzgmp9omxDyT320UjCYwVwOBn2TpaivNiSoI+dtFr
 7wjqcO8uZL7lIgtA481KlNbRNS/V605j3DwBxm1hyzPUZX4U49LURyKDNedw4HbljSQZvla1YPs
 WHat7PDeeN7syWMzpXThHxkPuZzp0=
X-Gm-Gg: AZuq6aL6DAa5Usfv2nZEhk0CWzbOMtGpsKkBzuIkyHEjJpbn17i3Z+v+glu8RS4KIZY
 wLk4r1d/w2HgKy38ZSuKy5TStQqCrqZ8fHt4LO8+8ACuBYZlvy/69FR+vz3zMfXmRwCoIU53tad
 rOJSP+ftnPG84NX1BwGMNLEw1mkEjlY5KNGxy+Bcg5Z4E6XObknGejaABmH38P/6r5y7w=
X-Received: by 2002:a05:7301:100c:b0:2b7:2f29:648c with SMTP id
 5a478bee46e88-2b7c8634921mr5838047eec.8.1770088740280; 
 Mon, 02 Feb 2026 19:19:00 -0800 (PST)
X-Received: by 2002:a05:7301:100c:b0:2b7:2f29:648c with SMTP id
 5a478bee46e88-2b7c8634921mr5838038eec.8.1770088739894; Mon, 02 Feb 2026
 19:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20260203022719.226064-1-liwang@redhat.com>
In-Reply-To: <20260203022719.226064-1-liwang@redhat.com>
Date: Tue, 3 Feb 2026 11:18:48 +0800
X-Gm-Features: AZwV_QiQO2DCBqOPnFbWG-uwPCgsqB40XdN2dpu33tOf_UFp3lDbl_6sJk15yZY
Message-ID: <CAEemH2dk9zpZOGjkhEOAa70qxYe3y4CrPoLPwFrZ60_EY18vvA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fszIDcEYZ-PTCPaxz_UsRcVAkb8LtoHd5GjjgKmy_mQ_1770088740
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] openat2: define _GNU_SOURCE and include <fcntl.h>
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

The binary file was added by accident, please ignore this one.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
