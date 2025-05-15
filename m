Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97734C3ABC9
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747300328; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=OU8+1+cHzzNNgXF6K0I856ILZh5LvCg0s8vPRm7MiPk=;
 b=mtGAa/wC5vyvo2fOcPthV7b3WFeYte0jtEzoeZM9EH0bb5cFB1yXfLalPEwKG9cu6h5mZ
 vc84Eo2FARlxVXO33Ru/sptYgVealF8o+2W3T1I8ZHerrn7m/3IkhWfsJ/5xY/bPmlMwHAj
 A0QQjJ8WIDDmL3mWrzON4lvwLAyUrjA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AE423CB7DE
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 11:12:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03B853CB7DE
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:43 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB34B1A00CB7
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:42 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a1d8c09683so401806f8f.0
 for <ltp@lists.linux.it>; Thu, 15 May 2025 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747300302; x=1747905102; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PWht9wCukHLrI0GEOOb8io/33zjIFEru+bTvpwmAfjM=;
 b=VJ0E3r95AWI5ggZF89EXW18WPWl5HzZA2/K8yVj1BAi0DotwRBHGBb222zC4APU9D+
 NuKbdK9QoDKhuVRna19w8xidI2kC1hmcLmFXAovmC9g7n58l/Z8wxk+JHPzj8QlFN0lA
 XKW9jnvTplDVIiEoQSWjQFHCp9CPE1NKl3Gv8z5EhSpvdVl0OhtzdH4QsUSGU/U4WB3B
 jFc/pWB6Nl1O8QeEDGGCoo9tGc+ZmMQ3Nb/jv1yXwIOCyGgyPIbfFzXPxQZOgkiGw8+Y
 Ndx3QK0av9dXl2WiiqXeh4XX7t/Zf5RtX2F+kb8h1za/Jz4akYAUHXBdYx2DdUU6R1C1
 Yb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747300302; x=1747905102;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PWht9wCukHLrI0GEOOb8io/33zjIFEru+bTvpwmAfjM=;
 b=GKK3f4fwIePTHl9bdRHgvQjgt8Rjnfu4Sq+aRzS+Ssec61KCB33OPtZfvOP1uzze+e
 pfurQ1j7T3eRikmxR26H9equaMdrFLN+aO6ucKrZ2duXQJ4JxCgL1Vuo6y7wWkUrctL0
 Cdbbwz3RZLyNB/LqYgwd91Z/akjlfurJ9PvF1G6UTzMU50zrUV9rEa+yLIgWlbHkOLkf
 uYrz0IxeJXmFbD/B1gZ3S/SV5CYWPCnmdvSNY478EdDMrIYjcJCw9eo2m96l/q25QibB
 deK0yrz0g5Su+I9qB1k63kvf4S7T/x+/eW/wErHC+qhyF+KLVIcUKXKPjzcoq9+3XUav
 lD0g==
X-Gm-Message-State: AOJu0YxjGWlUR3vQ/MwDXIUp67mrv2vx6dCa6VH8RVaygcW8wYaMEbRi
 B1UtPslQ1xNAib4kTcXBe/ijGdndqmEblN6mYTq2wSx+FOyN0lDh8WCt2CyKG80=
X-Gm-Gg: ASbGncv1DmO0kxVCU2ynAPCcGKSU/niL9SI3uiID0DjDZELCxQkTKvnhInQfWM13K64
 LSAKYCFFF5tNsM3SOIuHnC6PDeCTOL+M8+Y1yXXp4oXU1J4Jd+7Aci76nU8qsXOqMUdvO7Sw5HO
 TD9S049+rtfHreahmWtpV7KdUzAA4lxZ9jIudPM4j1RB9JyeBCb/SWnmfHfPnqOu9GabWLMszou
 jPIAi1fJH+DJa1cKDskbNUE7U06AXj7wIM1w4TFyHe4Nq/pxJfysRulay5HRDpUTRhNwnskqFN5
 2LKOw0gmgidZwtfSC8njWdhmazlKhRFcWInPcJQ=
X-Google-Smtp-Source: AGHT+IGCQVR9xu1h/Nm5dYSbCZ3IHt9O8e/DTJzNHG/FwJ34XAYpB1+kXJVb8e6MKwRmx3qv3VINBw==
X-Received: by 2002:a05:6000:2a6:b0:3a1:f78a:42f7 with SMTP id
 ffacd0b85a97d-3a3496c4815mr5660252f8f.32.1747300302321; 
 Thu, 15 May 2025 02:11:42 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-879f61754d7sm9908955241.14.2025.05.15.02.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 02:11:41 -0700 (PDT)
Date: Thu, 15 May 2025 06:11:34 -0300
Message-Id: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMavJWgC/32NSw6CMBRFt0I6tqYtH5GR+zAM2vKQF6E1fdhoC
 Hu3ZQEOT3LuuRsjCAjEumJjASISepdAnQpmJ+0ewHFIzJRQtahlxa13EULWiD9xnrlom8uolS1
 bI1mavQKM+DmS9z6x0QTcBO3slEOLphVCFiek1YfvcR1l1v+8RMkFt0NTlnCtJLTmRm+Cs/UL6
 /d9/wHYCUx4yAAAAA==
X-Change-ID: 20250514-conversions-kill-0867fa2c38b1
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=rbm@suse.com;
 h=from:subject:message-id; bh=KkUnL+o6+QvedR2diR2KYvyeyLrRay/xG9EiTpm4ATo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJa/KXH8Q9HTw7j9wl7LUxb4837wXQZnkGNXeW
 ztT2niqmQWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCWvygAKCRDJC4p8Y4ZY
 pv1aEACnNhnaBeQQAb9Oe4t2EBKM5m2vCSV+eL2Sbsa2S+ZYMs+Y04s20vaK8UzaiS4IFtzKwPL
 sNLHZ4KiP/nQfkcnPjCZZRgc2xv1x4DGuqCYIt4CQMz13mE32yXt+oTU8qCfr6Pz+eMn0+D9Q/i
 7GCZYANsUcf21WxtZTCBMd5g4sAR/kqxTrouO3sJJBvivWw5px2y97knPbgUeG74bZR+b/IH0GN
 ADw+7kNhxzvNyxUJvBLjEgOELLbHHzKUuNvjQCA+Q+WvP0WumVGIBEnYZ9LUrosX3rqPjS2AEB/
 2q+dI6ckg5c35KnYnjVa+/YBeeNhpdAWxzKZbHupq4tOOOK9G7SOjdLeN8qsYfq92mDPWMmmCKO
 G+FJPwj9lgs5dRZVElculnzt3yNX1eD7xFBsCBooESuFBrbGaATgQ5i2GjiKRFHVz40k6rDk7sr
 1+HV0zLy6rlYCDz0t3r5W61CnywQYaQdJl8+rh/JjJYjmDqS4OVOnLijWKn4E9bUMe3Tk7Wpprv
 9TcvnV51kPgzdLZrMnH9OKJOdf1znBYhOYAMuy2qENUIY8KSxOrtUUKzxni23epSfmSN5awgXLK
 QhCXsbfnIUL6RvjOqvMtv2RwATRFIao8AYab35jNgTGV+WMvE+RrwxLw/9LOImYi9MZEWbA4yi6
 R6nnKQd+/vB+wRQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] syscalls/kill: Small cleanup
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjI6Ci0gU3F1YXNoZWQgdGhlIHJlbW92YWwgb2Yga2lsbDA5IHBhdGNoCi0gTGlu
ayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDUxNC1jb252ZXJzaW9ucy1r
aWxsLXYxLTAtY2Q2MzNlOTQxZThiQHN1c2UuY29tCgotLS0KUmljYXJkbyBCLiBNYXJsacOocmUg
KDUpOgogICAgICBzeXNjYWxscy9raWxsMDM6IEZpeCB0ZXN0IGRlc2NyaXB0aW9uIG1ldGFkYXRh
CiAgICAgIHN5c2NhbGxzL2tpbGwwNTogRml4IHRlc3QgZGVzY3JpcHRpb24gbWV0YWRhdGEKICAg
ICAgc3lzY2FsbHMva2lsbDA2OiBGaXggdGVzdCBkZXNjcmlwdGlvbiBtZXRhZGF0YQogICAgICBz
eXNjYWxscy9raWxsMTE6IEZpeCB0ZXN0IGRlc2NyaXB0aW9uIG1ldGFkYXRhCiAgICAgIHN5c2Nh
bGxzOiBSZW1vdmUga2lsbDA5CgogcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsLy5naXRpZ25vcmUg
fCAgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwwMy5jICAgfCAgMTQg
KystCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDA1LmMgICB8ICAgOSArLQog
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwwNi5jICAgfCAgIDggKy0KIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDkuYyAgIHwgMTk4IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwxMS5j
ICAgfCAgIDkgKy0KIDcgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjE5IGRlbGV0
aW9ucygtKQotLS0KYmFzZS1jb21taXQ6IDRhMGUzYThmYTdiNTkyOTU4ZjhlM2NkMzY2ZjYzYzc4
ZmJhOWYwMTQKY2hhbmdlLWlkOiAyMDI1MDUxNC1jb252ZXJzaW9ucy1raWxsLTA4NjdmYTJjMzhi
MQoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4K
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
