Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8AACD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:37:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA3D43E56D0
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:37:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96CF83E11CD
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:37:40 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B31C1400152
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:37:40 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-307263ad0cbso412216eec.0
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780306658; x=1780911458; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVJzv1yKt5qI9QhfSkuSWHy55WOv4Pgp+KKoVDXiP5Q=;
 b=rVe1BYQBBMpEqD4g6T4rOZAq6QCH+8+BSzglnAo8ZvQb/7ce8IL1x67jtmXHnmXIEi
 m73++CPdIBm2j1w9GrAkR6bHxMslRDFOjMBEd8BSa+YUMyj3R8Xl7EcZXIF4YVLFo2vO
 Nn9Xx+hETn/zypOyJIogB9zQpBgy2MW3edwk5jYjJIvSzdohISKIokJN9O7TfIxmYoim
 DGMadGlsDnWKMYwetAIiDhvnuTdMPCZyKRELzCZ7apwraKse4mIeYjnUsf2DZfPxvPVL
 J29o5It9QxzVsN8949nNDPPZsQhxWaRJtGZ2BWECNdPMPuGzgmAMMuaULm/1/A34P5YF
 VVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306658; x=1780911458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bVJzv1yKt5qI9QhfSkuSWHy55WOv4Pgp+KKoVDXiP5Q=;
 b=ZSgJ8eWf7632LN5JFHCN915C3iY6vRbndflry3VHm9qOl3H8wNbwF3LbmcKlyCRIkp
 M4pF22U8zdmesYSCHl1g9XIIkrfaAX6vnOHukYiGOKCtyso2WsdFm/IuZVEt0qp2ETSc
 cW300WHVhefWy0i8173kKK+Yl8H5nIC1Tg4Ik2HfOQLZEu5gWWOAfDPfowWkDNpzNl4L
 wa/zTLMHTU3GaJ3xwu3KBjCxpUjvS4Ooja07c9LezWKWyoSHBR3Fh2H7kRorymNvE7li
 Q+EKW6l9d0CXgsKSrojVkvePHHUjp0GoFh0UGihivN36j0PKvPllbBYimMDcVmknxC2b
 M++Q==
X-Gm-Message-State: AOJu0YxRaAdsxQFyKiax6O4bF5mC73NPfeJ1atYu5iugcHiROAIkM+kP
 WqM8zvq65EhkftWU88zfw8XhKYQbI+Fz2Q+KX/RtGh2oD1psnSC3/EpQ
X-Gm-Gg: Acq92OGfsR5Q/XM7OGuu6dXILzYcNclg/nBidplQMq+TOUCBhS6waVMpMOl1wkmhn4z
 /5Pr8/qVp3ATY8EighAIhpUVq9RnPn0JHx0vl0KXsE7kMK5IHLvRt6moLGgJ4b6qSj/d6vSmPkV
 SFzHdvFwFe9pmys2hl9Tm9VSHPgYVVJ7e7RJYzf1DlR+L0v+zOWnqdQpQFMFCVMeZJAuqJsXRIi
 iziMebefQbjphhTFsBARQuUYwfjJu0VqlQ8yjfvxJErtqLg3j3lQwrVfKuz61+S6ITCU4XY2qVT
 EyQYDcgCAnx2ey87sJuZcKhtWW1V7R3W3gt3j5uPeIyQBQ4B0QiUDdiaK2TvIP+5MmQnOxtWFOJ
 3vg5X72Ys3TfwIIfZ2Ngm5DvpHFj71wtzeXl2u2VVenE7vhpiHM7NunVBgAXaXh4OtHvOZvIFIM
 fk7vIvX2UETZ1iwrmVqbAo6H39fvr5g8cvZSUgmg/+9MPU9ame3Zwkp2qpSzyvxRyoM3z/Ehb0s
 tIOnkrKQzZjvUKoVTbqJ3bJ9bkQ558jbpW4CXTKSfND7hALDc4=
X-Received: by 2002:a05:7301:4918:b0:2ee:f85:ec3c with SMTP id
 5a478bee46e88-304fa6721afmr4510392eec.30.1780306658166; 
 Mon, 01 Jun 2026 02:37:38 -0700 (PDT)
Received: from
 runnervm3jyl0.mwnkrarbjm5e5digrl2jy2mjca.dx.internal.cloudapp.net
 ([52.159.244.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed53f002sm8708381eec.18.2026.06.01.02.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:37:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  1 Jun 2026 09:37:36 +0000
Message-ID: <20260601093736.3880-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601-gitignore_ltp_agent-v2-1-fe5ab986ebd8@suse.com>
References: <20260601-gitignore_ltp_agent-v2-1-fe5ab986ebd8@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] gitignore: ignore ltp-agent setup files
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guIFBsZWFzZSBmaW5kIHJldmlldyBj
b21tZW50cyBiZWxvdy4KCi0tLQoKKipQYXRjaCoqOiBnaXRpZ25vcmU6IGlnbm9yZSBsdHAtYWdl
bnQgc2V0dXAgZmlsZXMKKipWZXJkaWN0Kio6IE5lZWRzIHJldmlzaW9uIOKclwoKLS0tCgojIyBD
b21taXQgTWVzc2FnZQoKVGhlIGNvbW1pdCBtZXNzYWdlIGlzIG1vc3RseSB3ZWxsIHdyaXR0ZW4u
IEhvd2V2ZXIsIHRoZXJlIGlzIGEKcHJlY2lzaW9uIGlzc3VlIHdpdGggdGhlIGJvZHk6Cgo+IERp
cmVjdG9yeSBlbnRyaWVzIGFyZSBhbmNob3JlZCB0byB0aGUgcmVwb3NpdG9yeSByb290IChsZWFk
aW5nICcvJykgc28KPiB0aGV5IG9ubHkgbWF0Y2ggdGhlIGx0cC1hZ2VudC1pbmplY3RlZCBwYXRo
cyBhbmQgY2Fubm90IGFjY2lkZW50YWxseQo+IHNoYWRvdyBhbnkgdW5yZWxhdGVkIHN1YmRpcmVj
dG9yeSB3aXRoIHRoZSBzYW1lIG5hbWUgaW4gdGhlIGZ1dHVyZS4KClRoaXMgaXMgdGVjaG5pY2Fs
bHkgdHJ1ZSBmb3IgdGhlIHRocmVlIGRpcmVjdG9yeSBlbnRyaWVzICgvYWdlbnRzLywKL2xpbnRl
ci8sIC9za2lsbHMvKSwgYnV0IHRoZSBzYW1lIHJhdGlvbmFsZSBhcHBsaWVzIGVxdWFsbHkgdG8g
dGhlCmZvdXIgZmlsZS9oaWRkZW4tZGlyZWN0b3J5IGVudHJpZXMgKEFHRU5UUy5tZCwgR0VNSU5J
Lm1kLCAuYWdlbnRzLAouY2xhdWRlKSB3aGljaCBhcmUgTk9UIGFuY2hvcmVkLiBUaGUganVzdGlm
aWNhdGlvbiBmb3IgYW5jaG9yaW5nIOKAlApwcmV2ZW50aW5nIGFjY2lkZW50YWwgc2hhZG93aW5n
IOKAlCBhcHBsaWVzIHRvIGFsbCBzZXZlbiBlbnRyaWVzLCBub3QKb25seSB0aGUgZGlyZWN0b3J5
IG9uZXMuCgojIyBDb2RlIFJldmlldwoKKipGaWxlKio6IC5naXRpZ25vcmUKCiMjIyBJc3N1ZSAx
OiBOb24tZGlyZWN0b3J5IGVudHJpZXMgc2hvdWxkIGFsc28gYmUgYW5jaG9yZWQgW05lZWRzIHJl
dmlzaW9uXQoKVGhlIHRocmVlIGRpcmVjdG9yeSBzeW1saW5rcyBhcmUgY29ycmVjdGx5IGFuY2hv
cmVkOgoKICAgIC9hZ2VudHMvCiAgICAvbGludGVyLwogICAgL3NraWxscy8KCkJ1dCB0aGUgcmVt
YWluaW5nIGZvdXIgZW50cmllcyBhcmUgbm90OgoKICAgIEFHRU5UUy5tZAogICAgR0VNSU5JLm1k
CiAgICAuYWdlbnRzCiAgICAuY2xhdWRlCgpJbiBnaXQncyBwYXR0ZXJuIGxhbmd1YWdlLCBhIHBh
dHRlcm4gd2l0aG91dCBhIGxlYWRpbmcgYC9gIGlzIG1hdGNoZWQKcmVjdXJzaXZlbHkgdGhyb3Vn
aG91dCB0aGUgZW50aXJlIHdvcmtpbmcgdHJlZS4gU28gYEFHRU5UUy5tZGAgd291bGQKc2lsZW50
bHkgaWdub3JlIGFueSBmaWxlIG5hbWVkIEFHRU5UUy5tZCBhbnl3aGVyZSBpbnNpZGUgdGhlCnJl
cG9zaXRvcnkg4oCUIGluY2x1ZGluZyBpbnNpZGUgdGVzdGNhc2VzLyBvciBhbnkgb3RoZXIgc3Vi
ZGlyZWN0b3J5IGEKZnV0dXJlIGNvbnRyaWJ1dG9yIG1pZ2h0IGNyZWF0ZS4gIFNpbmNlIGFsbCBm
b3VyIG9mIHRoZXNlIGFyZQpleGNsdXNpdmVseSBpbmplY3RlZCBhdCB0aGUgcmVwb3NpdG9yeSBy
b290IGJ5IGx0cC1hZ2VudCwgdGhleSBzaG91bGQKYmUgYW5jaG9yZWQgd2l0aCBhIGxlYWRpbmcg
YC9gIGZvciB0aGUgc2FtZSByZWFzb24gdGhlIGRpcmVjdG9yeQplbnRyaWVzIGFyZSwgYW5kIGZv
ciBjb25zaXN0ZW5jeSB3aXRoIHRoZW0uCgoqKlN1Z2dlc3RlZCBmaXgqKiDigJQgcmVwbGFjZSB0
aGUgZm91ciBub24tYW5jaG9yZWQgZW50cmllczoKCiAgICAtQUdFTlRTLm1kCiAgICAtR0VNSU5J
Lm1kCiAgICAtLmFnZW50cwogICAgLS5jbGF1ZGUKICAgICsvQUdFTlRTLm1kCiAgICArL0dFTUlO
SS5tZAogICAgKy8uYWdlbnRzCiAgICArLy5jbGF1ZGUKCldpdGggdGhpcyBjaGFuZ2UgdGhlIGNv
bW1pdC1tZXNzYWdlIGJvZHkgY2FuIGFsc28gYmUgdXBkYXRlZCB0byBzYXkKIkFsbCBlbnRyaWVz
IGFyZSBhbmNob3JlZCB0byB0aGUgcmVwb3NpdG9yeSByb290IOKApiIgZm9yIGFjY3VyYWN5LgoK
LS0tCgpMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
