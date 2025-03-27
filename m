Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13728C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743112624; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=yssjXV6mJ82mGjFHtB+IztxspP7kL28HqeIe7TznPhA=;
 b=JXCwUz53O5TTL+qd57vY7jneiklT+SFNwqY89xo/xBBydwEWVCIoQqn/1rUCJ23H3WVqQ
 awsxJCS595nUunBMOc/C/646zKM7iGpyrPCBRDwBYcuWBYsz+HPDLoQ6icmcvY0LYxtMwlF
 xJZjBnmJWRPFPtm+8N1TcNO4HcEB1Mc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62C7A3CA131
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 22:57:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 992503C99F2
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:41 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FFF21A010F3
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:40 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so1020780f8f.1
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743112600; x=1743717400; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yuurmlag0WpUE4jW+KKILm7CQRMBAaD/QgitoPdBodc=;
 b=erDTV1g3kDMnyQKoNZm2NPHAGRmEpPFSqM6ClNl3d7Ap9whzyHqzGMUtE2FpueyjGG
 F5WjclRVoFraUtw7Woqtl429qPLCa2RKnd/kaZqY3koqRtMANHRokCsnOE81P7ZW526C
 LkadhXlr2elTE1HcoU7fczEz+3SQWkxhWEBfSmglND7TswUN1lSGSZOe/iN3nnRLA9nn
 dZxEkqweaxe0wZ4Olx7kwrkKyP54cn9Y9kr97r6NTCWfRid6BdkfJaKjiXsVsgxm31zL
 sI+QDUnwIv10CZ/0WY4BEcCNMhH0XXfbRGdajqcWa80Jvhnqk4TxGcvN0KqDPMqJ5tQ3
 IMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743112600; x=1743717400;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yuurmlag0WpUE4jW+KKILm7CQRMBAaD/QgitoPdBodc=;
 b=HgaLb7n7hd/XXNXJiIE6miSgYF2a/j3IMrhwXGVp8iEKHkN8XfuIX4cD9NPpWF+KTR
 e8tRvx/0vXH1sVQxwZRjSpsLYHpjgIfjwKiT4Vd/1kgB4Q1CAzpqVymxSuSU3bVdVsT/
 tK1PGkgVEnXDmF0HatL9X0CYWh1pdKqNHS9t4uCvIvknkYmEuGDqpOf/68gY3dtQPFkd
 HFVqeZjxEqEbNJLdpNzr13KifLOnXr7uVyk9M7xIAu7N2hAjAlqgW+IZRrwA3eiQJRqG
 SvWHkOThw+Gf7Mn+yGAYC2K+lmEjUmCSW/We0b2ziwEXhohSQ/y3UK6wRMQHdnXtnOe/
 r9sQ==
X-Gm-Message-State: AOJu0Yyv7KPpsLHDCR5Qw66EISNWUZlyPBUe+4j3R9ALxE5oqDo8pQ6I
 jHiiaHNk2TbCg0SOXPAuAhLJbRPB+JOWSIrWctgn5iR3SvsYd3BMdPSPFyleg+o05oq6e7+6vRE
 +
X-Gm-Gg: ASbGncv0VkRm5q2lQlS1XvqnNgo8bxWgcQIvZvkv7QdIdEBazZ0IfWkOzi5XsYmGqyN
 WS/9Uow2OWHum3y2mjyQXcu+3juk9z1rSmv4GrUenMgRxhcVUVn06RHvBKn9YPIppxTZHMgdPlk
 Gdnrx5QFWhHEcYCr81xHzWCLnPfqnt1dc3p1iZD2gpEOysj9Ce+26AXh10z5nCfviOIEnwawE6p
 XuXc8Klkc0Q5te0kvykPHqt0VAcoeTfAJYOmNYA5dIwbPOURiweC0HtYONb7PFTXyGwwuYM/v1t
 2d+aurUq8TI60wS3q6OLyRbzWCAQ0iwV5A==
X-Google-Smtp-Source: AGHT+IEP0qI4AZwAvEnOnt2fWyknjdV1vOAN+j+82/kP1SRMv3oPFSeQLgEi6K7s1moZOMDNxI3eLw==
X-Received: by 2002:a05:6000:1acc:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-39ad176be62mr4407061f8f.36.1743112599866; 
 Thu, 27 Mar 2025 14:56:39 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2291eee1b3fsm4925385ad.74.2025.03.27.14.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 14:56:38 -0700 (PDT)
Date: Thu, 27 Mar 2025 18:56:33 -0300
Message-Id: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJHJ5WcC/x3MUQrCQAyE4auUPLvQrpSKVxEpaZy1QbtKIiKU3
 t3o4wcz/0oOUzgdm5UMb3V91EC3a0hmrlckvYQpt7lv93lIRT/jwjeMcgfXdEA/lIJOkIXi9DT
 E4h88ncMTO9JkXGX+ZRb2F4y27Qv3FYMxeQAAAA==
X-Change-ID: 20250327-fix_make_clean-8e57ffe1ce2c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803; i=rbm@suse.com;
 h=from:subject:message-id; bh=r0hBK2CctGGzcseg+N8LpAr9ZqqPCBkjeoZMUhDOiSo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5cmTXbdtpIWCiAWBZ4yVUtRs+H9esOTnLX3at
 DSbf1NIRVmJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+XJkwAKCRDJC4p8Y4ZY
 ponzD/9QNHLJKtAs5xSyfl06y3HCRD60+UObPH8/nYXJzoh7QsGBD0R0lO7m8HsY7813Im+6b/B
 gB53UjqKyVkEw79ufdT9E4THaOsdU8Iy++vMc/lBYrcpICq6oNVotV2midcpTM1kbt8wFDePQa2
 HV36Ma9jcXU9Nxcft8LjCkho4c+ePyoqc1vY3bN3YldaLhI/goNzx5ABck7NwRXc2KjrWqYGiCO
 39uOaZ7cSSGXr0sT3PjHWqjb2GGj89TXqGx6W5XYz9ZsTjZa+Ui11NFXKBb+Ug86CDnRWuLFiGc
 FHhuPae+0nkOTURQqUIrojw2vohKa/hRnGiI73VHyA8sMgMZbt2r1Q7VZlRDV4g/urwech/YNEV
 MuKhPL6cKUE7bseJOpR9Ax+5FN0PnWAtHMjqPrRoOSOyC2I7twpGwpcJ2q56vkuC1DqlNk58lja
 TGMbfNLKwmOmGEYgIdh9NAi6RhNYAAcbijcV+KDEyiOn2BOpdY2BklJWaGg85IaN0H/uaEvViKR
 DNvMrGPvJCmS94qzCkTnSGnAetnCVbtaJSv/Dn+PCW8HgNxjec9ApCk7fGFWtVll/2GQePc6aw3
 CFY+KR8YEVliMVKYKjOX/+FBUQO1+YZ5pjf5soaB7LCHSjwCMQ01vL+mkm+7/rmvkkLDIFyK9PN
 0RySCSffKt7BKfw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] configure: Tidy up removal of generated artifacts
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gZm9sa3MsCgpUaGUgZ29hbCBvZiB0aGlzIHNlcmllcyBpcyB0byBmaXggdGhlIHRvcC1s
ZXZlbCBgbWFrZSBtYWludGFpbmVyLWNsZWFuYCBbMV0Kc28gdGhhdCBpdCByZW1vdmVzIGV2ZXJ5
dGhpbmcgdGhlIGJ1aWxkIHN5c3RlbSBnZW5lcmF0ZWQuIFRoZSBtb3RpdmF0aW9uIGlzCnRoYXQg
SSB3YXMgdXNpbmcgYGdpdCBjbGVhbiAtZmR4YCBpbnN0ZWFkIG9mIC1mZFggYW5kIGluZXZpdGFi
bHkgbG9zdCBzb21lCndvcmssIHRoZW4gSSByZWFsaXplZCB0aGUgY2xlYW5pbmcgdGFyZ2V0cyB3
ZXJlIG5vdCBhY3R1YWxseSBjbGVhbmluZwpldmVyeXRoaW5nLCBlLmcuOgoKKG1hc3RlcikKJCBt
YWtlIGF1dG90b29scwokIC4vY29uZmlndXJlCiQgbWFrZSBtYWludGFpbmVyLWNsZWFuCiQgZ2l0
IGNsZWFuIC1mZHgKUmVtb3ZpbmcgYWNsb2NhbC5tNApSZW1vdmluZyBjb21waWxlClJlbW92aW5n
IGNvbmZpZy5ndWVzcwpSZW1vdmluZyBjb25maWcuc3ViClJlbW92aW5nIGNvbmZpZ3VyZQpSZW1v
dmluZyBpbmNsdWRlL2NvbmZpZy5oLmluClJlbW92aW5nIGluY2x1ZGUvbGFwaS9zeXNjYWxscy5o
ClJlbW92aW5nIGluY2x1ZGUvbWsvY29uZmlnLW9wZW5wb3NpeC5tawpSZW1vdmluZyBpbnN0YWxs
LXNoClJlbW92aW5nIG00L01ha2VmaWxlLmluClJlbW92aW5nIG1pc3NpbmcKUmVtb3ZpbmcgdGVz
dGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2F1dG9tNHRlLmNhY2hlLwpSZW1vdmluZyB0ZXN0
Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZmlndXJlCgpTbywgd2l0aCB0aGlzIHNlcmll
cyBhcHBsaWVkIHRoZW4gYGdpdCBjbGVhbiAtZmR4YCB3b24ndCBoYXZlIGFueXRoaW5nIGxlZnQK
dG8gcmVtb3ZlLgoKUGxlYXNlIGNvbnNpZGVyIHB1bGxpbmcsCi0JUmljYXJkby4KClsxXTogaHR0
cHM6Ly93d3cuZ251Lm9yZy9wcmVwL3N0YW5kYXJkcy9odG1sX25vZGUvU3RhbmRhcmQtVGFyZ2V0
cy5odG1sCgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29t
PgotLS0KUmljYXJkbyBCLiBNYXJsacOocmUgKDQpOgogICAgICBjb25maWd1cmU6IEFkZCBtaXNz
aW5nIGluY2x1ZGUvbWsvY29uZmlnLW9wZW5wb3NpeC5tayByZWZlcmVuY2UKICAgICAgb3BlbnBv
c2l4OiBNYWtlZmlsZTogQWRkIHRoZSBzdGFuZGFyZCAibWFpbnRhaW5lci1jbGVhbiIgdGFyZ2V0
CiAgICAgIGluY2x1ZGUvTWFrZWZpbGU6IEZpeCBjbGVhbmluZyB0YXJnZXRzCiAgICAgIGNvbmZp
Z3VyZTogQWRkIG1pc3NpbmcgZmlsZXMgZm9yIHJlbW92YWwgaW4gYWMtbWFpbnRhaW5lci1jbGVh
biB0YXJnZXQKCiBjb25maWd1cmUuYWMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAr
KwogaW5jbHVkZS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKystLQogaW5j
bHVkZS9tay9hdXRvbWFrZS5tayAgICAgICAgICAgICAgICAgIHwgMTEgKysrKysrLS0tLS0KIHRl
c3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9NYWtlZmlsZSB8IDEwICsrKysrKysrKy0KIDQg
ZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKLS0tCmJhc2Ut
Y29tbWl0OiBlM2FlZjU2OWYwZDBlNzA3OWJkYjY0Njk2NWFmYWY0MTkwMzVlYWE1CmNoYW5nZS1p
ZDogMjAyNTAzMjctZml4X21ha2VfY2xlYW4tOGU1N2ZmZTFjZTJjCgpCZXN0IHJlZ2FyZHMsCi0t
IApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
