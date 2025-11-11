Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7B9CCF9E3
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 02:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762829571; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=KRYk+flEz2ZkMdNgmSeKWYDvDMbSBpaQtrgNEXWjUog=;
 b=aOjl64RPDB1+g07avi7OIKMsFn1XatzsN053FtOSRLQ+dJ/tdTn8cSi0mQMVGwO1Ek/Sp
 DSDFSWr3cqERjtrLy6OdA3HMTRz8nj33cEvjomL7ptFu4Ndaf2JZ1537tMVJsqiug1Nyclc
 odi3nhAJxZ4qHoII3wmut5vi6DqUdE0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1F463CF609
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 03:52:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 041E43CE2A9
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 03:52:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 087961A0089C
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 03:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762829546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdBZZNm42SHh0FgbA9ioVa3dROwWN3BYjjg4Qs4/lnY=;
 b=enzTrbCe+BbV1B3KbwF9iwVyPMHPLKtmdvAuHhPPKy1ZhUt2TevZq1DtJ5ee907Ff7gNrB
 rr/j+mWwshrd9zk2UBSBrZ/Wdob6b6kYC+PNC0RECrJ0a7rIxqXmoC9x/osKeFYCKQYByW
 04oVRYd56Ci10MFcWo4YZKuKBaHJGlY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-257UiWpSP5ej2jqr-RdOEg-1; Mon, 10 Nov 2025 21:52:24 -0500
X-MC-Unique: 257UiWpSP5ej2jqr-RdOEg-1
X-Mimecast-MFC-AGG-ID: 257UiWpSP5ej2jqr-RdOEg_1762829543
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso7852327a12.2
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 18:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762829543; x=1763434343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdBZZNm42SHh0FgbA9ioVa3dROwWN3BYjjg4Qs4/lnY=;
 b=eofyYO391/Q96cmk47HCq5MPDlP9PHjGIRwjVqjRzPwKtrX2v6Qq9cuxtEmIppW+jZ
 9vr/fddw0wMmTYoeLN+TDQFWBmdvzSbkDFN8lBsEgB0A9u95SQBXPWH/qvmN170Xg8uy
 8c3ZMlFQwhY+xw/h/dXeYwHtynMLcP/0ros1AwZkhwLtGIN9QosUmBSfIPhsfs1S8HPW
 YODN6Lp1yc85UCdJ/XSB4LCVCxFydtDHvopMd7WEL+r/g4OgjPo+nU4mxXgNJvCfudM/
 UKy0Y9AYr+ebnXtaKiuqYKCkXxfETlkOa539WTTYReeA+N5KIYnY7B97FnUaktnTSWTS
 kECw==
X-Gm-Message-State: AOJu0YxVqQbw/UgT5K4WmZq4VroVawHnO0bhpatFB6fVm7jP8Dj5IxwU
 5p8+h+OmsDLSSU+gyxBsRjagqVE3VEu+BMBgeq4RtHRQTXhhL5N/ogaGmlN3j6lzUzM6b1iUBuz
 qMZKtZP9hI/sIuzPE0+mARcwKhscvB10TGfhLjM//aT0YDZc8dj1BAmBeZx/feEjha2veGF2dNy
 YnAAuBSkP9v8d6VAiD+jK4dhv3ujM=
X-Gm-Gg: ASbGncv/wYyr5KirGg1dTS7ZO2XuY2K1OsONd4VlCFb+WF5vTpL5zn+bIPH7uj9Vp8P
 ZmVH8jpxuZKSJRZl8CKdrAFvnQZJcGy1dhzU/U5zsNlwFnieuB9Z9UYRTH4WteL1Bxh0Lq/Ptb+
 wUFDyUo2C2rtrLjF2fBaiiMypUBSAA94UT2JOwZrdgy72ZB7LlnKcc/CYG
X-Received: by 2002:a05:6a20:7353:b0:34e:409e:eea0 with SMTP id
 adf61e73a8af0-353a0f94ba2mr14912081637.12.1762829543259; 
 Mon, 10 Nov 2025 18:52:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF/AAc3L/HFhzrCZu/eZgdNPpiIkB1kSft7Cm1h7SUgKLmuFa/eSG9YWY8ZZO6ofCCeH28Q3snNCGa/JXJZGg=
X-Received: by 2002:a05:6a20:7353:b0:34e:409e:eea0 with SMTP id
 adf61e73a8af0-353a0f94ba2mr14912061637.12.1762829542892; Mon, 10 Nov 2025
 18:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20251110101039.41257-1-liwang@redhat.com>
 <aRHCXEMa6cUhSKbn@yuki.lan>
In-Reply-To: <aRHCXEMa6cUhSKbn@yuki.lan>
Date: Tue, 11 Nov 2025 10:52:09 +0800
X-Gm-Features: AWmQ_bnRnnTHZf4yUS5soB7B6x6_plHGGLi83HwYzFrDzf8epa1_3Xm3pzSWE4E
Message-ID: <CAEemH2cDWsyend6zAsay3VuE7n5CuK7aa-Kka6QwTEvNZg9N7w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k_rYW5b4IdvI7KXyA-QouUTFnfcctGe_wQ8zhLhoMN0_1762829543
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls: make atime-sensitive tests more robust
 by extending sleep to 1.5s
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBOb3YgMTAsIDIwMjUgYXQgNjo0NeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJp
c0BzdXNlLmN6Pgo+CgpQYXRjaCBtZXJnZWQsIHRoYW5rcyEKCgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
