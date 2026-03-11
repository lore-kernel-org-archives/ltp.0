Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DA3104C001
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773225963; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YAiSNiqdNfY04agbCn1vmnIjMyGftja/ik4K0BFHxVk=;
 b=aRJ/er1NtgDBkl0vmTGXcLr1aKtm2LzPhtV5m8rBhnMbzZzatbE0sKtgpbsAwFfcHs8Kc
 xnZ5LT/59d6VWADl/dWP6gie6CUa6L6qKBrrUYljAEFWLRgZIZRkF1Ew3zMj5xJgmnHXEtt
 ANPivKArOOhuGIuNF8AmuALhkf4Z2aw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D3223CD52A
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 11:46:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8219E3CD52A
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 11:45:34 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C592814010C4
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 11:45:33 +0100 (CET)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cd80f56b27so381345885a.1
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 03:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773225932; cv=none;
 d=google.com; s=arc-20240605;
 b=UIWNeYFEgsaPpmD3kE+0XAB0BBh7Tb8//4Y/mgC+4MNJQRaUJZv20F2R+SAYcKJT2l
 +7QfkCPMzwKoKI+oy2w2ayIcxL4jRYjLRXbVn7M0TApgoQc2PgiPUjBg+vxPF14nTOKz
 mFx4eYGO8sEydf2Wt4oU7u21nlby3G7n6xv9uo877kh1k2pKZN9+PylU21qx2/MRo1Ui
 f/Je9+fWMqrmhooeBspK0H3Mzyrarowx74Kf9LZ+pfLex6fmHn8yIMFhwp7waCQn3/oF
 Zw3I1DKyCDlxkpkzCi/9MOb/DjYAh+jAfDrGbdg0pOe0LLzKZ1r9+9ks4ltnxNBPl/SF
 ZhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7vsDk25zVBTfwb1axdr1KCfVVl/kd3eHhZd/r75+KnU=;
 fh=239nhs5vX0/q1HxuPV5OxvAF7OE5e//1Hm/g85yQzkM=;
 b=XvM0HAtnGpUZi5oBeZ7pIR9bK2H2fVWiod1/kLOAqqWui4itLuDYd1W8E5NKEH6vyy
 wOv1TnQQ9QjFUB1sQJJNOwCF7ko4di/qYZ41duQQm/TLylXswWQuiE6ItnHLDMdPd2Eu
 Lxgi5iGLue39IW9BfmDsJg0kQDPQs7VyTMhqaERUiG6dPJ1fJnmEHxbrZ4I2XFCwKVa0
 7s/XBXl8pnP7TXVCal0l4c5vUK6RxuZvI0NYGvfqF5gwLx9MeUzW+XHv1jH2HRJtdjhg
 Wlb4yGlY63fLHWuEjbDKQRptYLBSXL6U812aemZfprgY/UdDJomZg2MZgViCcnqMSVK0
 mCeA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773225932; x=1773830732; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vsDk25zVBTfwb1axdr1KCfVVl/kd3eHhZd/r75+KnU=;
 b=ZTeWGTyiGIEiU/KwssUPjts3jURX7C/EgL1rv1Omeo8nd7BYGXsMNXVhyqNSmm1BBI
 hQ2ON9hEJfnBcuWO4Z059jqa8S4O2KNB4sxoOtlqZKy/kA2J+WsWJwSVb+lfN5pY6dIy
 6Ol4pvtJ+GcmMvxJevn5e4R+DuCr9eCUzIcOqC7pims8aWOY1tA/wyQQSum/Fr+4CNP7
 ucwy2jb4iLvTMiStxW7GDavBGwMUVIfM1lih9+pe01IX47Q9Rpv/bT2JNbd73OFatABC
 9s9Ms1oOGf2HRKy5EoXpu3zNlh96zHVYhZQCF9KbOf0sg1V8HF4PgSNWf4UoSQS3Qvn8
 dJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773225932; x=1773830732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7vsDk25zVBTfwb1axdr1KCfVVl/kd3eHhZd/r75+KnU=;
 b=qRuua/QSnnVO2mtxEjKV3PwnzQDPmR2T0wKxUiRv6i06/tRK6hp7EERicBgJh+zXzP
 dluXAwJWIpl9Yxo5AICc6N5MRF6kUHQDn8hVHzHXtUoEKFukPh1D36wkA3mbPO+5UxNg
 I6Z7lA9F5xKivWHVsTC/0ZQTgcUulSXesBDDviS2Hgt3AtraAzcoMfEqjEEcwxAhbCWJ
 s2MUgW5LxTnSBTonYl0PV/T6w3D0kjrl3oM1jBjWN9+FtAFzQ1CNue3c6J+2JVI+yAUU
 B3RNNLNZLvz6VUTRjnsX8CH+Xry41bPiUXaauU6QRliR93HfzN0UZQzpxZpsbZYuhpYv
 8now==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAELW1EcvvgdqKCcSnPIepgHZV8j886uv8G8WUwCGnivPz59aEi3swzZDjBda8LLx/04o=@lists.linux.it
X-Gm-Message-State: AOJu0YyFtWSvTIonTVACb3ofxSzs3n1kl+FX3Mjcq/cs1WjeNvw6x90T
 zq/YZMoF1YKslGwPeqk2+IWTXvpXnghazH4DZMHIhbjiqh7BRAh/NgBS3WTjSLalqMKbArcPDFs
 2oLLup454eRrgqQUsYNBo3o64Kg1E8DS4tD52U/9K
X-Gm-Gg: ATEYQzzS/z3VYbCUPWZz7ap8ajWmT8skEHv9IUazww/7BvjCUUl/RMtselEOg2gTU8S
 PvImuIG/9WNKpETcgtzx01in5UkPBJ8feyFywXDw8xByF2n+MzACZeTqK0Y6ASyB//efKv4ugNu
 mYRMYLTpomIVq44uKa/O9ft4ShQkKmTTUbIFodpyhcodHNoZpCl2/Nj8ckYnC4cK7yfY+TWcaie
 ugCVlDeLyNqQp20+/lA5si+dADlFETCjjbMwlnhsTy6RDYIRFNzo6W6rBhG9B8o1rWVtGkfZ7Yz
 89TP1kCM
X-Received: by 2002:a05:620a:19a3:b0:8cd:8f18:d1d3 with SMTP id
 af79cd13be357-8cda1aa96fcmr238042885a.58.1773225932110; Wed, 11 Mar 2026
 03:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <202603091409.866c520c-lkp@intel.com>
 <CANn89iKUdtWw4ptM8ZreRP0a2FuvQOJ5FgE3o4q-zTRTmt1Umg@mail.gmail.com>
 <abFE5PEtrkT5paKB@yuki.lan>
In-Reply-To: <abFE5PEtrkT5paKB@yuki.lan>
Date: Wed, 11 Mar 2026 11:45:21 +0100
X-Gm-Features: AaiRm53pzyyhStKrLmQaAlgunggh_gChR9xqV-J3aHPcZ3AKfR6HTggnSd94pyY
Message-ID: <CANn89iL8xwJxLMm+a-QqDUq_NeYSZBAMxvAAJ2_2X0tCd+J7kQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [icmp] 64db5933c7:
 ltp.cve-2020-25705.fail
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
From: Eric Dumazet via ltp <ltp@lists.linux.it>
Reply-To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, lkp@intel.com,
 netdev@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 oe-lkp@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXIgMTEsIDIwMjYgYXQgMTE6MzPigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiA+IEkgZG8gbm90IHdhbnQgdG8ga25vdyB3aGF0IHRo
aXMgdGVzdCBpcyBkb2luZyBvciBleHBlY3RpbmcuCj4gPgo+ID4gSWYgaXQgZXhwZWN0cyBzeXNj
dGxzIHRvIGhhdmUgYSBwcmVjaXNlIHZhbHVlLCBpdCBzaG91bGQgc2V0IHRoZW0gPwo+Cj4gVGhl
IHRlc3QgaXMgYSBDVkUgcmVwcm9kdWNlciB0aGF0IGNoZWNrcyBpZiBJQ01QIG1lc3NhZ2UgcmF0
ZWxpbWl0aW5nIGlzCj4gc3VmZmljaWVudGx5IHJhbmRvbWl6ZWQgc28gdGhhdCB3ZSBkbyBub3Qg
bGVhayBpbmZvcm1hdGlvbiBhYm91dCB0aGUKPiBzeXN0ZW0uCj4KPiBTZWUgdGhlIHRlc3Qgc291
cmNlIGNvZGU6Cj4KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9i
bG9iL21hc3Rlci90ZXN0Y2FzZXMvY3ZlL2ljbXBfcmF0ZV9saW1pdDAxLmMKPgoKVGhpcyB0ZXN0
IG5lZWRzIHRvIGJlIHR3ZWFrZWQvY2hhbmdlZC4KCkl0IGhhcyBiZWVuIHdyaXR0ZW4gd2l0aCB3
cm9uZyBhc3N1bXB0aW9uLgoKKGljbXBfbXNnc19idXJzdCA9PSA1MCkKClRoYW5rcy4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
