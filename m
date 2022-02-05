Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9312C433F5
	for <ltp@archiver.kernel.org>; Sat,  5 Feb 2022 03:07:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 262193C9AD9
	for <ltp@archiver.kernel.org>; Sat,  5 Feb 2022 04:07:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3473F3C896C
 for <ltp@lists.linux.it>; Sat,  5 Feb 2022 04:07:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97FB060004B
 for <ltp@lists.linux.it>; Sat,  5 Feb 2022 04:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644030452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWcqmU5z526qz/nNYQgDl4Ok5N0OjOT5WZImlDvX+Oo=;
 b=ViBR7i3DLJ7xmbnWHVyA8NyZZVP/wCUIyPhvDUWF25+54r0TkkjAx1xyVIBpsk0NwV0sZ5
 A9kMQcIRSoNelZeoy/vP6p7Ddr0NrZLzHOpSvYjrmCX1AG/BCw7IG+KAVTgFphkD7t9aBk
 gk0wLEl/duCKaoy1lPURpsoCZkcuNlU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-6eTFLd4PM2mI4VN0g5dpAg-1; Fri, 04 Feb 2022 22:07:28 -0500
X-MC-Unique: 6eTFLd4PM2mI4VN0g5dpAg-1
Received: by mail-yb1-f198.google.com with SMTP id
 t91-20020a25aae4000000b0061963cce3c1so16979089ybi.11
 for <ltp@lists.linux.it>; Fri, 04 Feb 2022 19:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FWcqmU5z526qz/nNYQgDl4Ok5N0OjOT5WZImlDvX+Oo=;
 b=iNweV8QSh+EhfQux7L81g5cR2HsiCm7PdrbQGEmO7jPy+qlItpmt+m1QzQYn0MnXoB
 LHdP35EFEOgF5ID26oNqA4Ci/qiwMOs3i74+wq+WLkNl7iCqHlcdnsUZobzWh4FRQtPP
 U1kFoQvmOSYQpo77LIabBgUkv9TQzulP8CjTrGDgrpPT+i8lD3cVrlGtfc29JkjFvIkJ
 Xfhd8f53txa9Pv4tAXfKgLUBVtgO7tK/OW5gVDrAEvU4s4XW/7BYxU74yOJIvQBla85/
 A1bkEnTCsdaNz1mX3bn04tgYhH6s63lYPuOqSnec/fMtGUM2Hs2/xSH5qYuPskM99Fzt
 wc4w==
X-Gm-Message-State: AOAM530Ui0AjaNKv0Ej2qhGw2lbFMMLEcJU5LBBPAqWAJeCNeLo0k6px
 icrC3MsuMf4WMCQVkSunKoe1whemg9GawjaBOqYPv5AwAz8Byyken0Yp+jCyu3epC27Mt4gkAqD
 mBuSBmJ9xdImr2Sr+eClENCUiues=
X-Received: by 2002:a0d:df97:: with SMTP id i145mr2009670ywe.90.1644030447853; 
 Fri, 04 Feb 2022 19:07:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeC6Y1hMk6fiMc0VJIdqevzJHrDLAnib+21FaRGRxBSK+UQxlFvv9qTrAMtWgl7dYfQWkh9WCmC3xih3YmpCc=
X-Received: by 2002:a0d:df97:: with SMTP id i145mr2009651ywe.90.1644030447544; 
 Fri, 04 Feb 2022 19:07:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643980361.git.jstancek@redhat.com>
 <b10d44db50b76cf5332cff491b5f22500b2b88c6.1643980361.git.jstancek@redhat.com>
In-Reply-To: <b10d44db50b76cf5332cff491b5f22500b2b88c6.1643980361.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 5 Feb 2022 11:07:14 +0800
Message-ID: <CAEemH2f7=baDouBjo_VwBgVw0a_oT5YSFuOcF=CcWRZGFNi+bQ@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_test_macros: add TST_EXP_FAIL_SILENT
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
Content-Type: multipart/mixed; boundary="===============0308888036=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0308888036==
Content-Type: multipart/alternative; boundary="000000000000d3891605d73caaae"

--000000000000d3891605d73caaae
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 4, 2022 at 9:14 PM Jan Stancek <jstancek@redhat.com> wrote:

> This variant does not print TPASS messages when
> SCALL fails as expected.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  doc/c-test-api.txt        |  3 +++
>  include/tst_test_macros.h | 15 ++++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 6f4de3f80f95..9119e094dbfd 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -298,6 +298,9 @@ The 'TST_EXP_FAIL2()' is the same as 'TST_EXP_FAIL()'
> except the return value is
>  expected to be non-negative integer if call passes. These macros build
> upon the
>  +TEST()+ macro and associated variables.
>
> +'TST_EXP_FAIL_SILENT()' and 'TST_EXP_FAIL2_SILENT()' variants are less
> verbose
> +and do not print TPASS messages when SCALL fails as expected.
> +
>  [source,c]
>
>  -------------------------------------------------------------------------------
>  TEST(socket(AF_INET, SOCK_RAW, 1));
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index ec8c38523344..f7de8d00a666 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -163,7 +163,7 @@ extern void *TST_RET_PTR;
>                         TST_MSG_(TPASS, " passed", #SCALL,
> ##__VA_ARGS__);     \
>         } while (0)
>     \
>
> -#define TST_EXP_FAIL_(PASS_COND, SCALL, SSCALL, ERRNO, ...)
>       \
> +#define TST_EXP_FAIL_(SILENT, PASS_COND, SCALL, SSCALL, ERRNO, ...)
>       \
>

I think maybe the better way is to define TST_EXP_FAIL_SILENT_
but not add a new SILENT parameter. So that it keeps consistent with
the existing TST_EXP_PASS_SILENT_ macros.

How about this:
(changed base on your patch)

--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -163,7 +163,7 @@ extern void *TST_RET_PTR;
                        TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);
    \
        } while (0)
   \

-#define TST_EXP_FAIL_(SILENT, PASS_COND, SCALL, SSCALL, ERRNO, ...)
     \
+#define TST_EXP_FAIL_SILENT_(PASS_COND, SCALL, SSCALL, ERRNO, ...)
    \
        do {
    \
                TEST(SCALL);
    \

   \
@@ -181,9 +181,6 @@ extern void *TST_RET_PTR;
                }
   \

   \
                if (TST_ERR == (ERRNO)) {
   \
-                       if (!SILENT)
    \
-                               TST_MSG_(TPASS | TTERRNO, " ",
    \
-                                       SSCALL, ##__VA_ARGS__);
   \
                        TST_PASS = 1;
   \
                } else {
    \
                        TST_MSGP_(TFAIL | TTERRNO, " expected %s",
    \
@@ -192,13 +189,23 @@ extern void *TST_RET_PTR;
                }
   \
        } while (0)

-#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(0, TST_RET == 0,
SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL(SCALL, ERRNO, ...)
     \
+       do {
    \
+               TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, ERRNO,
##__VA_ARGS__); \
+               if (TST_PASS)
   \
+                       TST_MSG_(TPASS | TTERRNO, " ", #SCALL,
##__VA_ARGS__); \
+       } while (0)

-#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(0, TST_RET >= 0,
SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL2(SCALL, ERRNO, ...)
    \
+       do {
    \
+               TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL, ERRNO,
##__VA_ARGS__); \
+               if (TST_PASS)
   \
+                       TST_MSG_(TPASS | TTERRNO, " ", #SCALL,
##__VA_ARGS__); \
+       } while (0)

-#define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...) TST_EXP_FAIL_(1, TST_RET ==
0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...)
TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__) \

-#define TST_EXP_FAIL2_SILENT(SCALL, ERRNO, ...) TST_EXP_FAIL_(1, TST_RET
>= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL2_SILENT(SCALL, ERRNO, ...)
TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__) \

 #define TST_EXP_EXPR(EXPR, FMT, ...)
    \
        tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "
FMT, ##__VA_ARGS__);

-- 
Regards,
Li Wang

--000000000000d3891605d73caaae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIEZyaSwgRmVi
IDQsIDIwMjIgYXQgOToxNCBQTSBKYW4gU3RhbmNlayAmbHQ7PGEgaHJlZj0ibWFpbHRvOmpzdGFu
Y2VrQHJlZGhhdC5jb20iPmpzdGFuY2VrQHJlZGhhdC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPlRoaXMgdmFyaWFudCBkb2VzIG5vdCBwcmludCBUUEFTUyBtZXNzYWdlcyB3aGVu
PGJyPg0KU0NBTEwgZmFpbHMgYXMgZXhwZWN0ZWQuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTog
SmFuIFN0YW5jZWsgJmx0OzxhIGhyZWY9Im1haWx0bzpqc3RhbmNla0ByZWRoYXQuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+anN0YW5jZWtAcmVkaGF0LmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqBk
b2MvYy10ZXN0LWFwaS50eHTCoCDCoCDCoCDCoCB8wqAgMyArKys8YnI+DQrCoGluY2x1ZGUvdHN0
X3Rlc3RfbWFjcm9zLmggfCAxNSArKysrKysrKysrLS0tLS08YnI+DQrCoDIgZmlsZXMgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0
IGEvZG9jL2MtdGVzdC1hcGkudHh0IGIvZG9jL2MtdGVzdC1hcGkudHh0PGJyPg0KaW5kZXggNmY0
ZGUzZjgwZjk1Li45MTE5ZTA5NGRiZmQgMTAwNjQ0PGJyPg0KLS0tIGEvZG9jL2MtdGVzdC1hcGku
dHh0PGJyPg0KKysrIGIvZG9jL2MtdGVzdC1hcGkudHh0PGJyPg0KQEAgLTI5OCw2ICsyOTgsOSBA
QCBUaGUgJiMzOTtUU1RfRVhQX0ZBSUwyKCkmIzM5OyBpcyB0aGUgc2FtZSBhcyAmIzM5O1RTVF9F
WFBfRkFJTCgpJiMzOTsgZXhjZXB0IHRoZSByZXR1cm4gdmFsdWUgaXM8YnI+DQrCoGV4cGVjdGVk
IHRvIGJlIG5vbi1uZWdhdGl2ZSBpbnRlZ2VyIGlmIGNhbGwgcGFzc2VzLiBUaGVzZSBtYWNyb3Mg
YnVpbGQgdXBvbiB0aGU8YnI+DQrCoCtURVNUKCkrIG1hY3JvIGFuZCBhc3NvY2lhdGVkIHZhcmlh
Ymxlcy48YnI+DQo8YnI+DQorJiMzOTtUU1RfRVhQX0ZBSUxfU0lMRU5UKCkmIzM5OyBhbmQgJiMz
OTtUU1RfRVhQX0ZBSUwyX1NJTEVOVCgpJiMzOTsgdmFyaWFudHMgYXJlIGxlc3MgdmVyYm9zZTxi
cj4NCithbmQgZG8gbm90IHByaW50IFRQQVNTIG1lc3NhZ2VzIHdoZW4gU0NBTEwgZmFpbHMgYXMg
ZXhwZWN0ZWQuPGJyPg0KKzxicj4NCsKgW3NvdXJjZSxjXTxicj4NCsKgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4NCsKgVEVTVChzb2NrZXQoQUZfSU5FVCwgU09DS19SQVcsIDEpKTs8YnI+DQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS90c3RfdGVzdF9tYWNyb3MuaCBiL2luY2x1ZGUvdHN0X3Rlc3Rf
bWFjcm9zLmg8YnI+DQppbmRleCBlYzhjMzg1MjMzNDQuLmY3ZGU4ZDAwYTY2NiAxMDA2NDQ8YnI+
DQotLS0gYS9pbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oPGJyPg0KKysrIGIvaW5jbHVkZS90c3Rf
dGVzdF9tYWNyb3MuaDxicj4NCkBAIC0xNjMsNyArMTYzLDcgQEAgZXh0ZXJuIHZvaWQgKlRTVF9S
RVRfUFRSOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRTVF9NU0df
KFRQQVNTLCAmcXVvdDsgcGFzc2VkJnF1b3Q7LCAjU0NBTEwsICMjX19WQV9BUkdTX18pO8KgIMKg
IMKgXDxicj4NCsKgIMKgIMKgIMKgIH0gd2hpbGUgKDApwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCjxicj4NCi0jZGVmaW5lIFRTVF9FWFBfRkFJTF8oUEFTU19DT05ELCBT
Q0FMTCwgU1NDQUxMLCBFUlJOTywgLi4uKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQorI2RlZmluZSBUU1RfRVhQX0ZBSUxfKFNJTEVOVCwgUEFTU19DT05ELCBTQ0FMTCwgU1ND
QUxMLCBFUlJOTywgLi4uKcKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6
ZTpzbWFsbCI+SSB0aGluayBtYXliZSB0aGUgYmV0dGVyIHdheSBpcyB0byBkZWZpbmUgVFNUX0VY
UF9GQUlMX1NJTEVOVF88L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9u
dC1zaXplOnNtYWxsIj5idXQgbm90IGFkZCBhIG5ldyBTSUxFTlQgcGFyYW1ldGVyLiBTbyB0aGF0
IGl0IGtlZXBzIGNvbnNpc3RlbnQgd2l0aDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQi
IHN0eWxlPSJmb250LXNpemU6c21hbGwiPnRoZSBleGlzdGluZyBUU1RfRVhQX1BBU1NfU0lMRU5U
XyBtYWNyb3MuPC9kaXY+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
PSJmb250LXNpemU6c21hbGwiPkhvdyBhYm91dCB0aGlzOjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPSJmb250LXNpemU6c21hbGwiPihjaGFuZ2VkIGJhc2Ugb24geW91ciBw
YXRjaCk8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6
ZTpzbWFsbCI+LS0tIGEvaW5jbHVkZS90c3RfdGVzdF9tYWNyb3MuaDxicj4rKysgYi9pbmNsdWRl
L3RzdF90ZXN0X21hY3Jvcy5oPGJyPkBAIC0xNjMsNyArMTYzLDcgQEAgZXh0ZXJuIHZvaWQgKlRT
VF9SRVRfUFRSOzxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUU1RfTVNH
XyhUUEFTUywgJnF1b3Q7IHBhc3NlZCZxdW90OywgI1NDQUxMLCAjI19fVkFfQVJHU19fKTsgwqAg
wqAgXDxicj7CoCDCoCDCoCDCoCB9IHdoaWxlICgwKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+wqA8YnI+LSNkZWZpbmUgVFNUX0VYUF9GQUlMXyhTSUxFTlQsIFBBU1NfQ09O
RCwgU0NBTEwsIFNTQ0FMTCwgRVJSTk8sIC4uLikgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPisjZGVm
aW5lIFRTVF9FWFBfRkFJTF9TSUxFTlRfKFBBU1NfQ09ORCwgU0NBTEwsIFNTQ0FMTCwgRVJSTk8s
IC4uLikgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCBkbyB7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgVEVTVChTQ0FMTCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPkBAIC0xODEs
OSArMTgxLDYgQEAgZXh0ZXJuIHZvaWQgKlRTVF9SRVRfUFRSOzxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8
YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKFRTVF9FUlIgPT0gKEVSUk5PKSkgeyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIVNJTEVOVCkgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRTVF9NU0df
KFRQQVNTIHwgVFRFUlJOTywgJnF1b3Q7ICZxdW90OywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFNTQ0FMTCwgIyNfX1ZBX0FSR1NfXyk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUU1RfUEFTUyA9IDE7IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2UgeyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRTVF9NU0dQXyhU
RkFJTCB8IFRURVJSTk8sICZxdW90OyBleHBlY3RlZCAlcyZxdW90OywgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj5AQCAtMTkyLDEzICsxODksMjMgQEAgZXh0ZXJuIHZvaWQgKlRTVF9SRVRfUFRSOzxi
cj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgXDxicj7CoCDCoCDCoCDCoCB9IHdoaWxlICgwKTxicj7CoDxicj4tI2RlZmluZSBUU1Rf
RVhQX0ZBSUwoU0NBTEwsIEVSUk5PLCAuLi4pIFRTVF9FWFBfRkFJTF8oMCwgVFNUX1JFVCA9PSAw
LCBTQ0FMTCwgI1NDQUxMLCBFUlJOTywgIyNfX1ZBX0FSR1NfXyk8YnI+KyNkZWZpbmUgVFNUX0VY
UF9GQUlMKFNDQUxMLCBFUlJOTywgLi4uKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDCoCDCoCBkbyB7IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBUU1RfRVhQX0ZBSUxfU0lMRU5UXyhUU1RfUkVUID09IDAsIFNDQUxMLCAjU0NBTEwsIEVS
Uk5PLCAjI19fVkFfQVJHU19fKTsgXDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChUU1Rf
UEFTUykgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgVFNUX01TR18oVFBBU1MgfCBUVEVSUk5PLCAmcXVvdDsgJnF1b3Q7LCAjU0NBTEwsICMj
X19WQV9BUkdTX18pOyBcPGJyPisgwqAgwqAgwqAgfSB3aGlsZSAoMCk8YnI+wqA8YnI+LSNkZWZp
bmUgVFNUX0VYUF9GQUlMMihTQ0FMTCwgRVJSTk8sIC4uLikgVFNUX0VYUF9GQUlMXygwLCBUU1Rf
UkVUICZndDs9IDAsIFNDQUxMLCAjU0NBTEwsIEVSUk5PLCAjI19fVkFfQVJHU19fKTxicj4rI2Rl
ZmluZSBUU1RfRVhQX0ZBSUwyKFNDQUxMLCBFUlJOTywgLi4uKSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPisgwqAgwqAgwqAgZG8g
eyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPisgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgVFNUX0VYUF9GQUlMX1NJTEVOVF8oVFNUX1JFVCAmZ3Q7PSAwLCBTQ0FM
TCwgI1NDQUxMLCBFUlJOTywgIyNfX1ZBX0FSR1NfXyk7IFw8YnI+KyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoVFNUX1BBU1MpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFRTVF9NU0dfKFRQQVNTIHwgVFRFUlJOTywgJnF1b3Q7ICZxdW90
OywgI1NDQUxMLCAjI19fVkFfQVJHU19fKTsgXDxicj4rIMKgIMKgIMKgIH0gd2hpbGUgKDApPGJy
PsKgPGJyPi0jZGVmaW5lIFRTVF9FWFBfRkFJTF9TSUxFTlQoU0NBTEwsIEVSUk5PLCAuLi4pIFRT
VF9FWFBfRkFJTF8oMSwgVFNUX1JFVCA9PSAwLCBTQ0FMTCwgI1NDQUxMLCBFUlJOTywgIyNfX1ZB
X0FSR1NfXyk8YnI+KyNkZWZpbmUgVFNUX0VYUF9GQUlMX1NJTEVOVChTQ0FMTCwgRVJSTk8sIC4u
LikgVFNUX0VYUF9GQUlMX1NJTEVOVF8oVFNUX1JFVCA9PSAwLCBTQ0FMTCwgI1NDQUxMLCBFUlJO
TywgIyNfX1ZBX0FSR1NfXykgXDxicj7CoDxicj4tI2RlZmluZSBUU1RfRVhQX0ZBSUwyX1NJTEVO
VChTQ0FMTCwgRVJSTk8sIC4uLikgVFNUX0VYUF9GQUlMXygxLCBUU1RfUkVUICZndDs9IDAsIFND
QUxMLCAjU0NBTEwsIEVSUk5PLCAjI19fVkFfQVJHU19fKTxicj4rI2RlZmluZSBUU1RfRVhQX0ZB
SUwyX1NJTEVOVChTQ0FMTCwgRVJSTk8sIC4uLikgVFNUX0VYUF9GQUlMX1NJTEVOVF8oVFNUX1JF
VCAmZ3Q7PSAwLCBTQ0FMTCwgI1NDQUxMLCBFUlJOTywgIyNfX1ZBX0FSR1NfXykgXDxicj7CoDxi
cj7CoCNkZWZpbmUgVFNUX0VYUF9FWFBSKEVYUFIsIEZNVCwgLi4uKSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKg
IMKgIMKgIHRzdF9yZXNfKF9fRklMRV9fLCBfX0xJTkVfXywgKEVYUFIpID8gVFBBU1MgOiBURkFJ
TCwgJnF1b3Q7RXhwZWN0OiAmcXVvdDsgRk1ULCAjI19fVkFfQVJHU19fKTs8YnI+PC9kaXY+PC9k
aXY+PGRpdj48YnI+PC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWdu
YXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+UmVnYXJkcyw8YnI+PC9kaXY+PGRpdj5MaSBXYW5n
PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pg0K
--000000000000d3891605d73caaae--


--===============0308888036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0308888036==--

