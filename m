Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322D0C3600C
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742849214; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=R8WOF6foK7k+tQYySNrIE8SojmTTv/uDjuIXUvr9fSM=;
 b=JLILJXR63j2uoBxUTMzCs5YdGjjUxRaGpqpnfcsDCTH8DPMU29LSZPWmES07M0I8KmF90
 OY/vYS56jYNhqmcyz10rI3MfQ//i7cGoLOSh2lyTR4D2jhckwooSAn4ZIGHzw4jI0Oe4LtO
 6QEej1UNSbrrcZVkuMg2EI5VJwEdb8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CE7A3C92DB
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 21:46:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 468DB3C932C
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 21:45:49 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20CB4100023B
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 21:45:49 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1033807f8f.2
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742849148; x=1743453948; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wJoQ88tIzGSM8RiOIPqoXxd/TD2j90OnjTWM292p1YM=;
 b=eroO3TwNuo8lZ8Zi3RlY3TZs2aitHhgxGsgxeL1thu0RTjItvFhQawfYeLi8vkxnUs
 2SQ1tCKgw2fvzXUASOLniooPcL+OLav0RO1uH9jT+zFMtsm70XctXuFNRsfzr/xN+xAY
 kQCx/8Z+vGXm3tuQ9oL77AczpxcU+XReyU7r1VdSwsA6OxFasiueA/EZfemwlrXCXols
 iViOBkR3XOJ1eAdZe7GveeVHerCWgw+JGe4Y5/ODF25so36FCOYXjjjf9Mq+V4zwhRtA
 RYz2YTSFgPMD3h35eK5axVWrqrEl305GCoycy4bYG0dFJ3Ev70CuQ8ecLjpM32JZaJbk
 wRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849148; x=1743453948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJoQ88tIzGSM8RiOIPqoXxd/TD2j90OnjTWM292p1YM=;
 b=dv8QFqjppWCYv7kTr1h6dhNW3uvQ0FIq92rTlzZjsoLf6d4WOkqDAlV4i3bkelMmUP
 lEMWXnhZebul2+G9XLYZiuth8ZYhZYiBoqrYz1QDe/5bbmy/Nwhda4Q49xbYh3lOVtTQ
 g+ses0HdAP/TQkUoy7F3mqmNA0cfO1zu/ohlTSKA0eWT1MlfpiDHuxUfL3NWDtlRsubX
 B0IKYWR3yARMFmLcQ32cUVg4F88SJs1BMElgUSnx12K2bLUs7ROandyPez7hZKWVDXrt
 wgsgKkIMQUgypzGyfjd7D9VqB/r79wZbyejzgcWlEAz58ytD6sidjAAk5J7tcSnT7CL3
 GLHA==
X-Gm-Message-State: AOJu0Yz/Z7E07Lhs2GYBNOhBlbwDktQM26B3i16RRIHdPwqIptm+Y6qD
 6M1YcIiZn6W+iC3ipWJuth4bprXj9xW5XV1dsUHtfCKCnOQI3u4pUgyIAHNbR0wNgMrycpTvifm
 E
X-Gm-Gg: ASbGncuC3a0n+OMxc3WkHujraw/Sxd7COTJm3aV97xbB7F3KakdNl3OMcoKE85t2agp
 IzwTiiZZBfDLi77J48m0xi2MQSaIwhMYeWVTv593EfOfDWAN9LN8xApUIJ6v+aWTlh9qkl/95mI
 MAXnNKYo74cQzBrZFap3qwovoCvqLnFTzZouUJh3LvlLuqZT5Z1zR3dxBwWyxZu1xd0e7CE6a8O
 fL863pmSZ/D2VgB5nLIn1/q/aCNzuUyhULH9WgEuBOMaL7TWztL9vQkfOPx2x+SwrvQi5LHiSor
 1z0/VVfH5lB6+7fN7ppSf5jnYEL68ImcNQ==
X-Google-Smtp-Source: AGHT+IE5DsaRmSrLzoksB1CaX8K8LjwIV1Yl2M22lzg5SdafgZ3U/v5fO0ds1Iz4x33l/DoNZa4j6g==
X-Received: by 2002:a05:6000:1a8b:b0:391:a43:8bbd with SMTP id
 ffacd0b85a97d-3997f902c6bmr13546788f8f.21.1742849148229; 
 Mon, 24 Mar 2025 13:45:48 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22780f45e0fsm75419415ad.74.2025.03.24.13.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 13:45:47 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:45:34 -0300
MIME-Version: 1.0
Message-Id: <20250324-conversions-modify_ldt-v1-2-8d6d82f10768@suse.com>
References: <20250324-conversions-modify_ldt-v1-0-8d6d82f10768@suse.com>
In-Reply-To: <20250324-conversions-modify_ldt-v1-0-8d6d82f10768@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394; i=rbm@suse.com;
 h=from:subject:message-id; bh=wNCw0JNORsIp94dYoL3rD8UQfOP4ap6+y4qT3kc43co=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn4cRyZ0yOMe7JsDCqJBDxliqZOe1moCRQvaFWr
 ClKC10PJ8CJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+HEcgAKCRDJC4p8Y4ZY
 piCHD/9zDGPqGrx4fvZbz2msJaSwVnFTKtMMDS1S/RIf80um1hQ4lJxNFfNTfc42eQVYHTxiCsQ
 09LohUSOE6p+hkR0Q1fZo4OXUQV4NbXJ8GNa30IR4ltU30T6IyiUgFUosT9C2G6NKz+r2H2Qvo1
 3fpvvi98bI4oG4F8CptQYXv9l8yPA55hYB6NuV/imEvEzQ12p1TAEaWtj3tiqRRLHi/ev+Es/ve
 1cmA5cFLTZENjbMQDcPcjec4QTFR6jDIysrmc4DivJmwaypFA00C+TUdiPtvm/og49wcKRYlU2D
 fmSsDU5G+ydVvTlgDr5AhmkalpJ8ZtqOyasKPmBVL6Wq2GsEpk9WJ8Dv63OqgKn12czfLRbZByD
 dWORDhwhFYuWGdEQRrPISKfdaDtq5jstm021LhUPA1YUKnVq4mOJ3YIxyFxAED+13xfkiPJZ+f9
 xibHQHoeh4+i1j36FdLiH5RT7d34aOGQpb8MUMvPVqKIVjOAwNQ4dn0BsrhFmF5PcPjyAteudML
 Wxg9evYyhUgWTQtMngbdqS/8sGft/iuELHjYX/TKoWUA79/AlR1yA9AGD5ztZGx7yDixE8oRqe2
 gwhHRSHtaeqbiF2Zo+7zs6cx84GM1SMOmKChmAO3i4XvqGVDC985ZEc0GzRw2r9VS7XXkcQQtIJ
 AMEQRXQOETQGjgw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] syscalls/modify_ldt: Refactor modify_ldt03 into
 new API
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogLi4uL2tlcm5lbC9zeXNj
YWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMy5jICAgICAgfCAxMTQgKysrKy0tLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgOTQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlm
eV9sZHQwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9s
ZHQwMy5jCmluZGV4IDAxNzMwZTBlMTRhZTk4YTkzNGU3YjY2YzkwNTg0NTQ1MDZiYmUwNjQuLjZl
Y2ZhMWU5Zjk4N2E2ZmMzNDllNTUxYjRmMGUxNzVkMTRlNjI2NDIgMTAwNjQ0Ci0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDMuYworKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAzLmMKQEAgLTEsMTA1
ICsxLDMxIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgor
CiAvKgotICogQ29weXJpZ2h0IChjKSAyMDE0IEZ1aml0c3UgTHRkLgotICogQXV0aG9yOiBaZW5n
IExpbmdnYW5nIDx6ZW5nbGcuanlAY24uZnVqaXRzdS5jb20+Ci0gKgotICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQKLSAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzCi0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbi4KLSAqCi0gKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhh
dCBpdCB3b3VsZCBiZSB1c2VmdWwsIGJ1dAotICogV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgotICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJ
VE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLgotICoKLSAqIFlvdSBzaG91bGQgaGF2ZSBy
ZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCi0g
KiB3aXRoIHRoaXMgcHJvZ3JhbS4KLSAqLwotLyoKLSAqIERFU0NSSVBUSU9OCi0gKglCYXNpYyB0
ZXN0IGZvciBtb2RpZnlfbGR0KDIpIHVzaW5nIGZ1bmM9MCBhcmd1bWVudC4KKyAqIENvcHlyaWdo
dCAoYykgMjAxNCBGdWppdHN1IEx0ZC4gWmVuZyBMaW5nZ2FuZyA8emVuZ2xnLmp5QGNuLmZ1aml0
c3UuY29tPgorICogQ29weXJpZ2h0IChjKSAyMDI1IFNVU0UgTExDIFJpY2FyZG8gQi4gTWFybGnD
qHJlIDxyYm1Ac3VzZS5jb20+CiAgKi8KIAotI2luY2x1ZGUgImNvbmZpZy5oIgotI2luY2x1ZGUg
InRlc3QuaCIKLQotY2hhciAqVENJRCA9ICJtb2RpZnlfbGR0MDMiOwotaW50IFRTVF9UT1RBTCA9
IDE7Ci0KLSNpZiBkZWZpbmVkKF9faTM4Nl9fKSAmJiBkZWZpbmVkKEhBVkVfTU9ESUZZX0xEVCkK
LQotI2lmZGVmIEhBVkVfQVNNX0xEVF9ICi0jIGluY2x1ZGUgPGFzbS9sZHQuaD4KLSNlbmRpZgot
ZXh0ZXJuIGludCBtb2RpZnlfbGR0KGludCwgdm9pZCAqLCB1bnNpZ25lZCBsb25nKTsKLQotI2lu
Y2x1ZGUgPGFzbS91bmlzdGQuaD4KLSNpbmNsdWRlIDxzdHJpbmcuaD4KLSNpbmNsdWRlIDxzeXMv
d2FpdC5oPgotI2luY2x1ZGUgPGVycm5vLmg+Ci0jaW5jbHVkZSAic2FmZV9tYWNyb3MuaCIKLQot
I2lmZGVmIEhBVkVfU1RSVUNUX1VTRVJfREVTQwotIyBkZWZpbmUgU0laRSBzaXplb2Yoc3RydWN0
IHVzZXJfZGVzYykKLSNlbHNlCi0jIGRlZmluZSBTSVpFIDE2Ci0jZW5kaWYKLQotc3RhdGljIGNo
YXIgYnVmW1NJWkVdOwotc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKTsKLXN0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpOwotCi1pbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikKLXsKLQlpbnQgbGM7Ci0K
LQl0c3RfcGFyc2Vfb3B0cyhhYywgYXYsIE5VTEwsIE5VTEwpOwotCi0Jc2V0dXAoKTsKLQotCWZv
ciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7Ci0KLQkJdHN0X2NvdW50ID0gMDsK
LQotCQlURVNUKG1vZGlmeV9sZHQoMCwgYnVmLCBTSVpFKSk7CisvKlwKKyAqIFZlcmlmeSB0aGF0
IGEgc2ltcGxlIHJlYWQgKGZ1bmM9MCkgd29ya3Mgd2hlbiBjYWxsaW5nIG1vZGlmeV9sZHQuCisg
Ki8KIAotCQlpZiAoVEVTVF9SRVRVUk4gPCAwKSB7Ci0JCQl0c3RfcmVzbShURkFJTCB8IFRURVJS
Tk8sCi0JCQkJICJtb2RpZnlfbGR0KCkgZmFpbGVkIHdpdGggZXJybm86ICVzIiwKLQkJCQkgc3Ry
ZXJyb3IoVEVTVF9FUlJOTykpOwotCQl9IGVsc2UgewotCQkJdHN0X3Jlc20oVFBBU1MsICJtb2Rp
ZnlfbGR0KCkgdGVzdGVkIHN1Y2Nlc3MiKTsKLQkJfQotCX0KKyNpbmNsdWRlICJ0c3RfdGVzdC5o
IgogCi0JY2xlYW51cCgpOwotCXRzdF9leGl0KCk7Ci19CisjaWZkZWYgX19pMzg2X18KKyNpbmNs
dWRlICJsYXBpL2xkdC5oIgogCi1zdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQordm9pZCBydW4odm9p
ZCkKIHsKLQl0c3Rfc2lnKE5PRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOworCWNoYXIgYnVm
W3NpemVvZihzdHJ1Y3QgdXNlcl9kZXNjKV07CiAKLQlURVNUX1BBVVNFOworCVRFU1QobW9kaWZ5
X2xkdCgwLCBidWYsIHNpemVvZihidWYpKSk7CisJVFNUX0VYUF9FUV9MSShUU1RfUkVULCAwKTsK
IH0KIAotc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQotewotfQorc3RhdGljIHN0cnVjdCB0c3Rf
dGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1biwKK307CiAKLSNlbGlmIEhBVkVfTU9ESUZZ
X0xEVAotCi1pbnQgbWFpbih2b2lkKQotewotCXRzdF9icmttKFRDT05GLAotCQkgTlVMTCwgIm1v
ZGlmeV9sZHQgaXMgYXZhaWxhYmxlIGJ1dCBub3QgdGVzdGVkIG9uIHRoZSBwbGF0Zm9ybSB0aGFu
ICIKLQkJICJfX2kzODZfXyIpOwotfQotCi0jZWxzZSAvKiBpZiBkZWZpbmVkKF9faTM4Nl9fKSAq
LwotCi1pbnQgbWFpbih2b2lkKQotewotCXRzdF9yZXNtKFRJTkZPLCAibW9kaWZ5X2xkdDAzIHRl
c3Qgb25seSBmb3IgaXg4NiIpOwotCXRzdF9leGl0KCk7Ci19Ci0KLSNlbmRpZiAvKiBpZiBkZWZp
bmVkKF9faTM4Nl9fKSAqLworI2Vsc2UKK1RTVF9URVNUX1RDT05GKCJUZXN0IHN1cHBvcnRlZCBv
bmx5IG9uIGkzODYiKTsKKyNlbmRpZiAvKiBfX2kzODZfXyAqLwoKLS0gCjIuNDkuMAoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
