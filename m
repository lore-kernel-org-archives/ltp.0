Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30608CA0FE7
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756127882; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MhJCwmLix4QB2rYTQojN0sUCObjvN+XGHO5qYx1RDhU=;
 b=JI0EtSkIgqvQDXYLxCEu/pFxMZwhJCxv2VGVi9l/iEDHAp92KgCGTWPDYSNwYMh9zP748
 ZjiGG7oy7/iHqiontrGWi9a4m/U5Ug4Cebr9GULNg5Qy4Nd/SddAATmFGVjE+shXJcSQrEy
 Th1vgApwbs+FVaWVfVJVmjfrHMFOwFg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BF363CD09A
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 15:18:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43D633C018D
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 15:17:40 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BED9600543
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 15:17:39 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3c84925055aso1001634f8f.2
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756127859; x=1756732659; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ng8ViTfJzd428CRojncGIG6eRadixwONskO33Qh7iKk=;
 b=QRgSg7So7x1oWBFmejSPoWNB/d6nICU15Ldtpd+DXhYutPyGWynfLOV5Deb7K4tpfF
 qm5bUgXNOmisIx8cXVs9k1arwJSEpVYHxBg6C44i6pONvFnB3xrrnJv4aWw6OZAfL1VR
 lpoSZqHEg1CbfJhOVwQFxqWHETvEc6isZo0D5pnwTBSK0e7UBUkMYPjAv1WKfxU+5B8w
 Om9uFVCn2jWSFR2FZBBfo1GrCjuC0cLp9NT2RmFE304NGIjS/JsREu7gL4UUaC0Yj7TQ
 /I3iUMw/cEUjfmMZ43nQlbQNq5jxMgi8KF1iXleF17MoIRQO0DRYsTJSlykoOwHMlXh9
 oYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756127859; x=1756732659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ng8ViTfJzd428CRojncGIG6eRadixwONskO33Qh7iKk=;
 b=aYmEr4m2uyTqsrbMYZv6jybJbBIquC475aUTMIfKO2r1ejQU9evey5sbdjiIOVg0ic
 jdBxkYbSuwzh2uNHLcZXcZL0UXcLgOTwg/vdrlzTXwkhHdsRjLDohb1xBiSXH04OgM50
 ySVyUujJllF+OdPsitXrRdaHc1anuSvZkjejx9XXZEPcJ9qDPPehfnFRwxiCy8cq1m/y
 dWi1fwmjN+hEKonavW8x+nMyMdoo7LXoLoUEd8IUPAyuarhbxAjQ7dh0lEnVFWlKqgzv
 ItXtK20k9CkrhWoTgHYEa4ETlggcPeMKYTr7cesyDf+ucJgpn1Ax3drADvi6vyTC7aRS
 odmw==
X-Gm-Message-State: AOJu0Yy8TOfVKfKRS9oU1665SQAFfPgKiFbhc1rTYOz7dH073pFTQaR9
 IcngS7k/ZIirhm1cKMquTBmyNGXb6W4ojFh8vFL5GZvwZVyX6Sf4lg6BBu8Mxelz9Yc0GtbQ78W
 PruGusLw=
X-Gm-Gg: ASbGncva5pDFq8JfP7Mav023iChqlUrX85a3H0mCJX20ALeSgR9qlnbw48Xykpcju0r
 RX+zvkRiXkBwdTXpCIz8LcPyI6u1gXqxRc1lIUDjfWIHJMnThoOuadla67Zj0WPXuD5WObkOaFL
 DJNK8qEq5X+ypXIjzqhNmE1TJ5BDiZVV1WnHvMbFRFaE4h6DTIQD3Z9h2XUkMOuoTPCHuC6Le3A
 fTycGEpAzO3UpuztJdrsisGxYaRsTNawl5EXqJpUfnCazCJTRZp8rhNkqe/07sysVNSgGKHHLXn
 KzJVK5cR4Cw0mkZC6Tb4Vj1vGRP9qMXvvBJvHkqkClMKR7d9Hptfun28hZL9m7RbQ9rr6XRLobA
 pzaCBt4FkV373X5BY0iOWsg==
X-Google-Smtp-Source: AGHT+IGPTHi6lmPk2FEnP8shYYTDI4M2yLddh7mX/qym/Id/a0fempBOB9VgVvBhCPIZJyUB27hCuA==
X-Received: by 2002:a5d:64cf:0:b0:3c4:39cc:366 with SMTP id
 ffacd0b85a97d-3c5daa292d1mr9040778f8f.15.1756127858899; 
 Mon, 25 Aug 2025 06:17:38 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-541051e8f15sm618820e0c.17.2025.08.25.06.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 06:17:38 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:17:31 -0300
MIME-Version: 1.0
Message-Id: <20250825-conversions-lchown-v3-1-2d261b3de236@suse.com>
References: <20250825-conversions-lchown-v3-0-2d261b3de236@suse.com>
In-Reply-To: <20250825-conversions-lchown-v3-0-2d261b3de236@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=rbm@suse.com;
 h=from:subject:message-id; bh=l21wVCPK4pGamOhwOYgm2qesQx2DK6DXuUzzK7nu6SA=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBorGJsUifg4cL3CZlJtrGkUnbks240dz0LNlyeU
 jJXdZTaPo+JAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaKxibBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZpmQ//aS8woLa5/byE+ZpNbHoIOq6fvN5pjWu
 dhWJIHI1oiSUfoJsucZs93Ct7Ft3tkOV9w7uvWLIipa3XCFJY2N5HKCWsetjaTJLbFQkR/Y+Z02
 JnMGVQA713CgAntO31jipVNxFkQ54kJ0wdbDtOQC79MWU3P2bd0c/0WDzKAEqOPHxNMidlyh3gg
 /jkj+vbH+9KaT71MptF08TjsUVk0ReCU4zCutkb1JERo8Nd73ZFCAvV5Ulbzt19dnzhyXD6lgYg
 /kVmNFze0s//KbGcQiAxbVcCvtQaLLOBZMt1Xivc2rg7P4Pql/24TquGRCMSBJ3Lsw/e77T4Iby
 0W1oX1yuFv1MP/fIj2fcRKVxICuqm14dfoXA9mh6zQTbZDgaynS4IXDfoa5oR8frJ3yWFYWmlog
 W+IbxlX+jOo0sSSHHKPFlXnMziwUOUGm6MXnYjR/S8b826UqezhSGadP2IjEC5ow+xbjFISPF0x
 ZLRO4BGhISeT5PlodjrvG7Y06KSyniH0VZoLM2YiMMKJlRdO2qxvuTFQDZCRP0iqUwFjc+WOAc+
 q/O8r0qsvZJP0Q7aMLHgEQa6YFDLM5F09auDpcOK5ApVDYpg91O+XQy50h7AfiifgXezedJ+q/V
 v3UlkxU1sN1YGMAl2helpmu689jsbW5IASZS8LIYZAAOeHtBbgBA=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] lib: Add SAFE_LCHOWN
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgpTaWduZWQtb2ZmLWJ5
OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KIGluY2x1ZGUvc2FmZV9t
YWNyb3NfZm4uaCAgfCAgMyArKysKIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggfCAgMyArKysK
IGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCiAzIGZp
bGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NhZmVf
bWFjcm9zX2ZuLmggYi9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKaW5kZXggZDI1NjA5MWI3NmFk
MTBiMDZiMjllM2ZkNWZhZDg4NTNmYWExNGMwOC4uMzc5OTg3M2EyNDhmMzZlMGZmMzFjODYyZGUy
NzAzYTEzZmVlMWJmZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oCisrKyBi
L2luY2x1ZGUvc2FmZV9tYWNyb3NfZm4uaApAQCAtMTUxLDYgKzE1MSw5IEBAIGludCBzYWZlX2No
b3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFudXBfZm4p
KHZvaWQpLAogaW50IHNhZmVfZmNob3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5l
bm8sIHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLAogICAgICAgICAgICAgICAgIGludCBmZCwgdWlk
X3Qgb3duZXIsIGdpZF90IGdyb3VwKTsKIAoraW50IHNhZmVfbGNob3duKGNvbnN0IGNoYXIgKmZp
bGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKKwkJY29uc3Qg
Y2hhciAqcGF0aCwgdWlkX3Qgb3duZXIsIGdpZF90IGdyb3VwKTsKKwogcGlkX3Qgc2FmZV93YWl0
KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFudXBfZm4pKHZv
aWQpLAogICAgICAgICAgICAgICAgIGludCAqc3RhdHVzKTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS90c3Rfc2FmZV9tYWNyb3MuaCBiL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKaW5kZXggMTk1
MDRiZWI1N2FkMzc5YzgzNWExM2VkNWQzNWZlMDZlNDJhNmVkNi4uNDFkMTdiMWNhNDU5MDQ1OGNm
NjUxYTU5YTZlMzc3YzIxNTcyNzA5NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS90c3Rfc2FmZV9tYWNy
b3MuaAorKysgYi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCkBAIC0yMjAsNiArMjIwLDkgQEAg
aW50IHNhZmVfZ2V0Z3JvdXBzKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGlu
dCBzaXplLCBnaWRfdCBsaXN0W10pOwogI2RlZmluZSBTQUZFX0ZDSE9XTihmZCwgb3duZXIsIGdy
b3VwKSBcCiAJc2FmZV9mY2hvd24oX19GSUxFX18sIF9fTElORV9fLCBOVUxMLCAoZmQpLCAob3du
ZXIpLCAoZ3JvdXApKQogCisjZGVmaW5lIFNBRkVfTENIT1dOKHBhdGgsIG93bmVyLCBncm91cCkg
XAorCXNhZmVfbGNob3duKF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHBhdGgpLCAob3duZXIp
LCAoZ3JvdXApKQorCiAjZGVmaW5lIFNBRkVfV0FJVChzdGF0dXMpIFwKIAlzYWZlX3dhaXQoX19G
SUxFX18sIF9fTElORV9fLCBOVUxMLCAoc3RhdHVzKSkKIApkaWZmIC0tZ2l0IGEvbGliL3NhZmVf
bWFjcm9zLmMgYi9saWIvc2FmZV9tYWNyb3MuYwppbmRleCA3MjZjOWFlOGVlNTM3NTliYTk4MzMz
OTY2MmE2YjQxZTk0ZWFjZDdhLi42MGQyOGI1YmRmMmJkNmZkZDM0OGZhZDUwYmU0NWNhNjZmYjE1
OWExIDEwMDY0NAotLS0gYS9saWIvc2FmZV9tYWNyb3MuYworKysgYi9saWIvc2FmZV9tYWNyb3Mu
YwpAQCAtNzc1LDYgKzc3NSwyNSBAQCBpbnQgc2FmZV9mY2hvd24oY29uc3QgY2hhciAqZmlsZSwg
Y29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCiAJcmV0dXJuIHJ2YWw7
CiB9CiAKK2ludCBzYWZlX2xjaG93bihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5v
LCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKKwkJCWNvbnN0IGNoYXIgKnBhdGgsIHVpZF90IG93
bmVyLCBnaWRfdCBncm91cCkKK3sKKwlpbnQgcnZhbDsKKworCXJ2YWwgPSBsY2hvd24ocGF0aCwg
b3duZXIsIGdyb3VwKTsKKworCWlmIChydmFsID09IC0xKSB7CisJCXRzdF9icmttXyhmaWxlLCBs
aW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBjbGVhbnVwX2ZuLAorCQkJImxjaG93biglcywlZCwlZCkg
ZmFpbGVkIiwgcGF0aCwgb3duZXIsIGdyb3VwKTsKKwl9IGVsc2UgaWYgKHJ2YWwpIHsKKwkJdHN0
X2Jya21fKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sIGNsZWFudXBfZm4sCisJCQkiSW52
YWxpZCBsY2hvd24oJXMsJWQsJWQpIHJldHVybiB2YWx1ZSAlZCIsIHBhdGgsCisJCQlvd25lciwg
Z3JvdXAsIHJ2YWwpOworCX0KKworCXJldHVybiBydmFsOworfQorCiBwaWRfdCBzYWZlX3dhaXQo
Y29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9p
ZCksCiAgICAgICAgICAgICAgICAgaW50ICpzdGF0dXMpCiB7CgotLSAKMi41MC4xCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
