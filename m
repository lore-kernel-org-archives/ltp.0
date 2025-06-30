Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6BBC8302F
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751289391; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yt64H4hpRHOe8PUUWIyPtNHXiYF7dtMTFcLjMZL/+s0=;
 b=cXhLgyufJfEppmHUVJC7J4abv1Zi0tSbaXnAe/Q8TPOMsPrtrjVPTzWV2AbxZmT2XdSoZ
 XKDMoSJX3UbpRPA+be9o/h4Ov/+er82COfPf66KP1veZE1yalHVnNRIqk5297mVo9JiH5QV
 w+p5h5CWjUgfA3pKdBjidsiq8mJA9W8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B6613C5EC0
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 15:16:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4F473C5A96
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:13:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EFAC71A005E2
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:13:41 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso2390087f8f.2
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751289221; x=1751894021; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=frROmKW2PIsBmQe37QVxAinpVFSrssJRyn6uCiqdkVg=;
 b=RKPEZGHlF6PCIlRAFhG/2U5sCkFQe/Yr+qURPBF9mp+FPkYzKXblmyfA14Q/Eol7Sw
 zc1jAD6UCqyJ2v2oXi4Rw+AVf5l+HjXzrWg+kQNxNlsnnAc2173sGsrq0bG7h0VFJKVm
 0FI50iae42nP1Ro50SgRT6pD7r8FMiN59U0IVqOCkgPfzALLYAWdlYA3IZ7YUJM/8uBN
 7wdwHomOEGSqbrcVGPp6tSoEdxSaxE1cEQAxvmGtEBA6hGX/9DuFXqtpdEYvqs8Do+G0
 zEJTItqlr/XPyXGTAfh3uIGqm2Tylp4PO6/wgSTWVUM4twSPdup/rBspWrxzGH6klOek
 D8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289221; x=1751894021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frROmKW2PIsBmQe37QVxAinpVFSrssJRyn6uCiqdkVg=;
 b=peUvB0RtGoVgGySCH+lk6BQ/ibEalOJ6MFE0/ecAIEHuwrfmgHEY9yOvsVPG06w2AN
 z/hcX4kYsMm0coR/SgAT94iE6gGm24P1+XWUUH3/3kCkO+BeydIRGXtYIianJoELh70l
 a2F3XDSiJYNrd8gOLcOG/Iw4+4xk/QqzqvBZOpncRPs/IldOOUC5X+or/P/SEopTR2KT
 +pRtfCGMWCwp1xGR8u0rawBvok27Qael0xxIAKCLZj5kw6jH1lnnV37kq9LXyIjyBh9P
 3ucQhFg1R2DRW4iGqaCBYDHcUHFatxRh2jYe2XXrGEtYP7UZ186/wYl6YWP2x08K13vb
 QbEA==
X-Gm-Message-State: AOJu0YyiUBF9AHSqkg7Pt/VVPSxofjoZhLTZgHRoTHf03XFlSrKUD7Zn
 YfybePk6z8J+wY4pCbhv2LQbGszH9A3StlBezYMHsCR487oST4rh1ZhgFVGydWxEJEEhttelvXR
 X9eO9
X-Gm-Gg: ASbGnctmCBL19yHTcrLcivKaadM9AyQyObNID1bE0zukILnKSn8YhSGHp0mzx77UYOM
 bsc/rIOZyYI5r2xORjFv1ML+1rv70riIiknaNs7z28GLURcBSa5oUYMgqGkWPTn8gHvnACRhVYs
 UkFCV/qOZj1Lvdy6Rji4jJ49RU0hTtSgt3Ax4CCz7EHEQnFalDXKiTyIJbTIWjSNEJ5H9bmoqp4
 RSS27XBOfNitc54QE2KwV5q87ETQz0cfHJlYkufzM/5p2iYSfff8hqq3nMCYH+7ePz61n5akYXs
 JdDpTnsQ3WKT3hmJJ1Bk87EP5ybYGxNeR4Hi3iZrn06qUQ6SAQ==
X-Google-Smtp-Source: AGHT+IFGeIFq2eCxw89LGU8+p68LMx6TkkY1oUe8T3yP/PX3EDo/NmZ/gm5z3qOOdJd/lCWOflnfHw==
X-Received: by 2002:a05:6000:65c:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a8ffdbf0b1mr11035175f8f.31.1751289220633; 
 Mon, 30 Jun 2025 06:13:40 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-6fd771abd15sm67964906d6.29.2025.06.30.06.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 06:13:40 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:13:14 -0300
MIME-Version: 1.0
Message-Id: <20250630-conversions-shmt-v2-7-6bb1bf315cce@suse.com>
References: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
In-Reply-To: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4817; i=rbm@suse.com;
 h=from:subject:message-id; bh=AVqGz1UfvQTLYGfQuSaSXPlg2ZNshPDnQL+SnYhvUqo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoYo1rJe04Ys5FH1bXTRqvehxolOrPdSv/VQF/F
 ZcxXF+bIKCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGKNawAKCRDJC4p8Y4ZY
 ph3BD/9nvpKm0i29wc2MLStyrLu/pNgPDPfrJgF2Wfn3TmRl5MEUXeb/q+wEOn2TBrrXTE1BC7s
 8I4qbN5+ZC935VRxTfpkXb7HhC+2X5ho/MvjO7A5E+nGDAvmXO5z7JNFAFb1gyCVQrhN6JbkyaF
 It/OyR0enMiXY747E4nsScFB8ule3Ze4WoQzOfMPHsTi/ZE6lFF+Vij96bWKRuLyyo5RFlmaIOM
 mC3wCJUtaNUxUhW8gjkTz1bqzPQQVZ0U1jtKSazpJ4FreCX0iLzdJA5bMlMlfE47c26Yd/3VyXS
 6vvYUPZ3pGALSiOYJpxgKWTY8Bex9PdQJNgzUPiqnuR/cUqm2bx1MIGAgJAWIKBYwK5O4BOClTU
 zPgFp1/UTx/vGqXToX+wCofdljueLMPbMqJQ6rcm7lJMDbgb3VOHUZfw53kLGZapwC1i2bwaUy6
 7FjS+y1GqVEDFpHQXxMWSQ4B3EXskqz6kzcaBwH6Wz7fio176x0jtB/su1yp9EtBGi6kbJRrIW/
 VL4YcJxhcLZ6THSkLAHAMUTKojT9Y6e33X9yQ6upVtqH4SV0FgqMe1N6e4w1vEFgEkcFOHbSReT
 eJoAEnoi7tpENPMYIt1s2nO1k+P9sLXddZYAiwAFLdg5wMTDyFCQcx7YB4ucHf2ceXHUfghj3O5
 Xs2e1BozudXiB0Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/9] mem: shmt08: Convert to new API
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5l
bC9tZW0vc2htdC9NYWtlZmlsZSB8ICAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L3No
bXQwOC5jIHwgMTI1ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvTWFrZWZpbGUgYi90ZXN0Y2FzZXMva2VybmVs
L21lbS9zaG10L01ha2VmaWxlCmluZGV4IDJjZDY0MGEzMDBlNTNjMmRkMmNjY2JlMTQ3MDE1Nzc5
ODdkMGUxMGIuLmVmMzRmMjNlNmNkZjMzZWYwZTY4MTdkNmFiMjNkMzA1MzUyNTU5NDUgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvTWFrZWZpbGUKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vc2htdC9NYWtlZmlsZQpAQCAtMzEsNSArMzEsNiBAQCBzaG10MDM6IExUUExE
TElCUyA9IC1sbHRwbmV3aXBjCiBzaG10MDQ6IExUUExETElCUyA9IC1sbHRwbmV3aXBjCiBzaG10
MDU6IExUUExETElCUyA9IC1sbHRwbmV3aXBjCiBzaG10MDc6IExUUExETElCUyA9IC1sbHRwbmV3
aXBjCitzaG10MDg6IExUUExETElCUyA9IC1sbHRwbmV3aXBjCiAKIGluY2x1ZGUgJCh0b3Bfc3Jj
ZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDA4LmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10
L3NobXQwOC5jCmluZGV4IDJjM2FlOWQ1NGVkMGM5Mjc2MDBlMWY1YjViMDcxZDhjMTEyZWJmYmMu
LjlmYjJmNmIyMjA2YTRlNjg5MThmNjU4MDU5ZDJlZWJjMzZjZGRiYWUgMTAwNjQ0Ci0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDA4LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vc2htdC9zaG10MDguYwpAQCAtMSwxMTcgKzEsNDIgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCiAvKgotICoKLSAqICAgQ29weXJpZ2h0IChjKSBJbnRl
cm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMgotICoKLSAqICAgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5Ci0gKiAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Ci0gKiAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCi0gKiAgIChhdCB5b3VyIG9w
dGlvbikgYW55IGxhdGVyIHZlcnNpb24uCi0gKgotICogICBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKLSAqICAgYnV0IFdJVEhP
VVQgQU5ZIFdBUlJBTlRZOyAgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCi0g
KiAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4g
IFNlZQotICogICB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWls
cy4KLSAqCi0gKiAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlCi0gKiAgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQotICogICBGb3VuZGF0aW9uLCBJbmMuLCA1
MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNB
CisgKiBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAu
LCAyMDAyCisgKgkxMi8yMC8yMDAyCVBvcnQgdG8gTFRQCXJvYmJpZXdAdXMuaWJtLmNvbQorICoJ
MDYvMzAvMjAwMQlQb3J0IHRvIExpbnV4CW5zaGFyb2ZmQHVzLmlibS5jb20KKyAqIENvcHlyaWdo
dCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgog
ICovCiAKLS8qIDEyLzIwLzIwMDIgICBQb3J0IHRvIExUUCAgICAgcm9iYmlld0B1cy5pYm0uY29t
ICovCi0vKiAwNi8zMC8yMDAxICAgUG9ydCB0byBMaW51eCAgIG5zaGFyb2ZmQHVzLmlibS5jb20g
Ki8KLQotLyoKLSAqIE5BTUUKLSAqCXNobXQwOAotICoKLSAqIENBTExTCi0gKglzaG1jdGwoMikg
c2htZ2V0KDIpIHNobWF0KDIpIHNobWR0KDIpCi0gKgotICogQUxHT1JJVEhNCisvKlwKICAqIENy
ZWF0ZSBhIHNoYXJlZCBtZW1vcnkgc2VnbWVudC4gQXR0YWNoIGl0IHR3aWNlIGF0IGFuIGFkZHJl
c3MKLSAqIHRoYXQgaXMgcHJvdmlkZWQgYnkgdGhlIHN5c3RlbS4gIERldGFjaCB0aGUgcHJldmlv
dXNseSBhdHRhY2hlZAorICogdGhhdCBpcyBwcm92aWRlZCBieSB0aGUgc3lzdGVtLiBEZXRhY2gg
dGhlIHByZXZpb3VzbHkgYXR0YWNoZWQKICAqIHNlZ21lbnRzIGZyb20gdGhlIHByb2Nlc3MuCi0g
KgogICovCiAKLSNpbmNsdWRlIDxzdGRpby5oPgotI2luY2x1ZGUgPHN5cy90eXBlcy5oPgotI2lu
Y2x1ZGUgPHN5cy9pcGMuaD4KLSNpbmNsdWRlIDxzeXMvc2htLmg+Ci0jaW5jbHVkZSA8ZXJybm8u
aD4KLQotI2RlZmluZSBLXzEgIDEwMjQKLQotLyoqIExUUCBQb3J0ICoqLwotI2luY2x1ZGUgInRl
c3QuaCIKKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgorI2luY2x1ZGUgInRzdF9zYWZlX3N5c3ZfaXBj
LmgiCisjaW5jbHVkZSAibGlibmV3aXBjLmgiCiAKLWNoYXIgKlRDSUQgPSAic2htdDA4IjsJCS8q
IFRlc3QgcHJvZ3JhbSBpZGVudGlmaWVyLiAgICAqLwotaW50IFRTVF9UT1RBTCA9IDI7CQkvKiBU
b3RhbCBudW1iZXIgb2YgdGVzdCBjYXNlcy4gKi8KLS8qKioqKioqKioqKioqKi8KKyNkZWZpbmUg
U0hNU0laRSAxNgogCi1rZXlfdCBrZXk7Ci0KLXN0YXRpYyBpbnQgcm1fc2htKGludCk7Ci0KLWlu
dCBtYWluKHZvaWQpCitzdGF0aWMgdm9pZCBydW4odm9pZCkKIHsKLQljaGFyICpjcCA9IE5VTEws
ICpjcDEgPSBOVUxMOworCWNoYXIgKmNwLCAqY3AxOwogCWludCBzaG1pZDsKKwlrZXlfdCBrZXk7
CiAKLQlrZXkgPSAoa2V5X3QpIGdldHBpZCgpOwotCWVycm5vID0gMDsKLS8qLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCi0KLQlpZiAoKHNo
bWlkID0gc2htZ2V0KGtleSwgMjQgKiBLXzEsIElQQ19DUkVBVCB8IDA2NjYpKSA8IDApIHsKLQkJ
cGVycm9yKCJzaG1nZXQiKTsKLQkJdHN0X2Jya20oVEZBSUwsIE5VTEwsCi0JCQkgIkVycm9yOiBz
aG1nZXQ6IHNobWlkID0gJWQsIGVycm5vID0gJWRcbiIsCi0JCQkgc2htaWQsIGVycm5vKTsKLQl9
CisJa2V5ID0gR0VUSVBDS0VZKCk7CiAKLQljcCA9IHNobWF0KHNobWlkLCBOVUxMLCAwKTsKLQlp
ZiAoY3AgPT0gKGNoYXIgKiktMSkgewotCQl0c3RfcmVzbShURkFJTCwgInNobWF0MSBGYWlsZWQi
KTsKLQkJcm1fc2htKHNobWlkKTsKLQkJdHN0X2V4aXQoKTsKLQl9CisJc2htaWQgPSBTQUZFX1NI
TUdFVChrZXksIFNITVNJWkUsIElQQ19DUkVBVCB8IDA2NjYpOworCWNwID0gU0FGRV9TSE1BVChz
aG1pZCwgTlVMTCwgMCk7CisJY3AxID0gU0FGRV9TSE1BVChzaG1pZCwgTlVMTCwgMCk7CiAKLQlj
cDEgPSBzaG1hdChzaG1pZCwgTlVMTCwgMCk7Ci0JaWYgKGNwMSA9PSAoY2hhciAqKS0xKSB7Ci0J
CXBlcnJvcigic2htYXQyIik7Ci0JCXJtX3NobShzaG1pZCk7Ci0JCXRzdF9leGl0KCk7Ci0JfQor
CVNBRkVfU0hNRFQoY3ApOworCVNBRkVfU0hNRFQoY3AxKTsKKwlTQUZFX1NITUNUTChzaG1pZCwg
SVBDX1JNSUQsIE5VTEwpOwogCi0JdHN0X3Jlc20oVFBBU1MsICJzaG1nZXQsc2htYXQiKTsKLQot
LyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSovCi0KLQlpZiAoc2htZHQoY3ApIDwgMCkgewotCQlwZXJyb3IoInNobWR0MiIpOwotCQl0c3Rf
cmVzbShURkFJTCwgInNobWR0OmNwIik7Ci0JfQotCi0JaWYgKHNobWR0KGNwMSkgPCAwKSB7Ci0J
CXBlcnJvcigic2htZHQxIik7Ci0JCXRzdF9yZXNtKFRGQUlMLCAic2htZHQ6Y3AxIik7Ci0JfQot
Ci0JdHN0X3Jlc20oVFBBU1MsICJzaG1kdCIpOwotCi0vKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCi0Jcm1fc2htKHNobWlkKTsKLQl0
c3RfZXhpdCgpOworCXRzdF9yZXMoVFBBU1MsICJBdHRhY2hlZCBhbmQgZGV0YWNoZWQgdHdpY2Ui
KTsKIH0KIAotc3RhdGljIGludCBybV9zaG0oaW50IHNobWlkKQotewotCWlmIChzaG1jdGwoc2ht
aWQsIElQQ19STUlELCBOVUxMKSA9PSAtMSkgewotCQlwZXJyb3IoInNobWN0bCIpOwotCQl0c3Rf
YnJrbShURkFJTCwKLQkJCSBOVUxMLAotCQkJICJzaG1jdGwgRmFpbGVkIHRvIHJlbW92ZTogc2ht
aWQgPSAlZCwgZXJybm8gPSAlZFxuIiwKLQkJCSBzaG1pZCwgZXJybm8pOwotCX0KLQlyZXR1cm4g
KDApOwotfQorc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1
biwKK307CgotLSAKMi41MC4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
