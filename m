Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E07CD4F5E
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 19:11:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 479793C71CB
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 21:11:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18BF13C7088
 for <ltp@lists.linux.it>; Tue, 19 May 2026 21:10:40 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C3F631000403
 for <ltp@lists.linux.it>; Tue, 19 May 2026 21:10:39 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso3989407eec.0
 for <ltp@lists.linux.it>; Tue, 19 May 2026 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779217838; x=1779822638; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rqkj0g9AUe75leATrZD8LbQUgaAGNbrvcqrwTU/4qso=;
 b=k/nzWwE3VBrXNqAgo0rfTEq69s158Fo4UwJYwymo9CeDjixpTL4UWx8R9X3F0ofZE0
 2Z2/eZCud0cReOcLM3aGGkXNQ9NHMVjOBnsKPAN2IbBpt4/sbY7JBjfrVuKGC98nlAxW
 hiW2QzDoaeMS28m+s/GdEjTQKZvRKZcodY2SHfYi/5ywxsFrO0zpzVaNxmsl4CyTU2xD
 lUBIA0OAGphVpZ1EBCNEPKb7dXF7fIqmmQ6JK8cwtYjVClWjrgbnPGW+MRF82IITTsND
 XXFcQ3EgQqf/Qu/ziuxYo70iVYMd0Jni0IVf6cbN7c0OUKGgQAdd2jXfIKJciJHRwU0t
 G1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779217838; x=1779822638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rqkj0g9AUe75leATrZD8LbQUgaAGNbrvcqrwTU/4qso=;
 b=a0D8USLWzARD8i3wFvxJVN20wbOsJFf3PjWQFi6OmQcrbnrugZ5/460hIFVajxnp0w
 jrJU9CP5qY6xCiE07+gB+ScgmC1/uAC3zyIKdBha4fRhUWYPG9cZWBapzBDObUWtC8Qk
 M9c3oc4YmJ0642F+stHhIT/vvtVJAF+P7DpHc/vYpI3PlS34e80BZfUnlKTqd1MJjG52
 LWupsep1XLNT4+jBzrfq0Io/+6KDtJcVYNVFcNDE2JG53bGQFc7xMUljgN1GXtb4PmIJ
 YJMGXskK6lv4CjSa6LbrO/WjS4CO/PhtfIH5fqqWxWVsU4grhFCWFneVNo2tkrUMB4nZ
 aExg==
X-Gm-Message-State: AOJu0YzL0dAITh2GB5IWANO86AZQSMNrgxBwGol46WRYir+RnMVEK4ZO
 jtwyW3o4Cj0S4U2GdPebGwoURjXcSKNTAUUyrnCSuYOE8kFWR92j/GnQ
X-Gm-Gg: Acq92OHzbdJsJ6rXu9ri07WkKVaqeRyxzpMabGc1o7mz/ariEX381qJoC5D38XIuvD+
 /ZXhlZAVd4iT+U7WOUdcY14tcrAqmnChkLjgYnwItFM/SQLJN+Eqf2Tq2w3y6uNyRBC6WCgr3Xg
 WmCcbRbW7b1NSvg4wb/vniQophLcj56f3VAfk9e8cANT79odH1TYNq2liVMse7MqaBBAdKb0lZ1
 5Y4QfakisdZu1gTmgbVStyjsdCbmrNNIkR4u8jXLvXvew0W127pgVD8blFu3RsrGPv8JGQ8rNF6
 dVpp4ePWbrndkSibQMwrO4yu1F7t/pa5d9gKm4KNfDAfKG0ro9qvh2WIKSM0INqeSldCc7Se7/A
 9/RlbSPUzwjryXIpIKYy0Yf2njjA771czcJmlreSf5hB7SPRNcrRYtJ5uocTg37wYgg9oiQeiLn
 ZYXRnbKN58qfl/vVYBnnXk2aDzvBS2BlMpGgDGBvoiyN5wgu1hFyyowX72j8qmoVDdr00E9v6Sw
 aPUoULQK+mLU80jqmRnBd+n7l34gXm1Ze5xOg==
X-Received: by 2002:a05:7301:2907:b0:2ed:75d:fe40 with SMTP id
 5a478bee46e88-303984bf216mr10309456eec.15.1779217837978; 
 Tue, 19 May 2026 12:10:37 -0700 (PDT)
Received: from
 runnervmrw5os.4gsvg4wsvffutjcasgdygelxgf.dx.internal.cloudapp.net
 ([13.88.85.245]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm21845052eec.3.2026.05.19.12.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 12:10:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Tue, 19 May 2026 19:10:36 +0000
Message-ID: <20260519191036.4081-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183031.114591-2-mmenashe@redhat.com>
References: <20260519183031.114591-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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

SGkgTWljaGFlbCwKCi0tLSBbUEFUQ0ggNC80XSAtLS0KCk9uIFR1ZSwgMTkgTWF5IDIwMjYgMjE6
MzA6MzEgKzAzMDAsIE1pY2hhZWwgTWVuYXNoZXJvdiB3cm90ZToKPiBmdXRleF9jbXBfcmVxdWV1
ZTAzOiBBZGQgRUZBVUxUIGVycm9yIGNvdmVyYWdlIHRlc3QKCj4gKy8qXAo+ICsgKiBDaGVjayB0
aGF0IGZ1dGV4KEZVVEVYX0NNUF9SRVFVRVVFKSByZXR1cm5zIEVGQVVMVCB3aGVuIHVhZGRyIG9y
Cj4gKyAqIHVhZGRyMiBwb2ludHMgdG8gdW5tYXBwZWQgbWVtb3J5LCBvciB3aGVuIHVhZGRyIHBv
aW50cyB0byBtZW1vcnkKPiArICogd2l0aG91dCByZWFkIHBlcm1pc3Npb24gKFBST1RfTk9ORSku
Cj4gKyAqCj4gKyAqIFRoZSBFQUNDRVMgYmVoYXZpb3IgZm9yIFBST1RfTk9ORSB3YXMgaW50cm9k
dWNlZCBpbiBrZXJuZWwgNS45Lgo+ICsgKi8KClRoZSBkb2MgY29tbWVudCBzYXlzICJyZXR1cm5z
IEVGQVVMVCAuLi4gd2hlbiB1YWRkciBwb2ludHMgdG8gbWVtb3J5CndpdGhvdXQgcmVhZCBwZXJt
aXNzaW9uIChQUk9UX05PTkUpIiwgYnV0IHRoZSB0ZXN0IGNvcnJlY3RseSBleHBlY3RzCkVBQ0NF
UyBmb3IgdGhhdCBjYXNlIG9uIGtlcm5lbHMgPj0gNS45LiBQbGVhc2UgdXBkYXRlIHRoZSBjb21t
ZW50IHRvCnJlZmxlY3QgYm90aCBvdXRjb21lcywgZS5nLjoKCiAgInJldHVybnMgRUZBVUxUIHdo
ZW4gdWFkZHIgb3IgdWFkZHIyIHBvaW50cyB0byB1bm1hcHBlZCBtZW1vcnksIG9yCiAgIEVBQ0NF
UyAoRUZBVUxUIG9uIGtlcm5lbHMgPCA1LjkpIHdoZW4gdWFkZHIgcG9pbnRzIHRvIFBST1RfTk9O
RQogICBtZW1vcnkuIgoKUGF0Y2hlcyAx4oCTMyBsb29rIGdvb2QuCgotLS0KTm90ZToKCk91ciBh
Z2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBhZ2VudCBjYW4gc29t
ZXRpbWVzCnByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cyBmaW5kaW5n
cyBhcmUgZ2VudWluZS4gSWYgeW91CmZpbmQgaXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNl
IGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlCnN1Z2dlc3Rpb25zLgoKUmVnYXJkcywK
TFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
