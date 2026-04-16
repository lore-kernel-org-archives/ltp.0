Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B01CF8A140
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 08:19:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78E743E263B
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:19:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49F543D87C1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:19:28 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB81820093D
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:19:27 +0200 (CEST)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8acb3daf2aaso56938706d6.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 01:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776327566; cv=none;
 d=google.com; s=arc-20240605;
 b=Ywes82TUGvWGi+AZqxXNha2eCtVtV7B3PQdL4nHykFzxr0qFDWEp2Uo18XcrixvAi7
 FAaGDvrOuLQDEAoXXprhMh4gu+xvVItaXo0i629QQo9IlG+B5bKWzCBhqEqKCOwWbm6o
 YcMn4CnSN/4WYM/G2pKh1sJu2y1eFIYVUxPyArOy40faxPG6qk1C3/7+I7vIMqNwBTd0
 JD8iftzbizRPj0jujeuY/S5urTE7xiWkRe3r+LUgbFNczbqv5gyUHE5/D1UFwUViapS2
 tqvf5xLzHIRzWut7OgN4ftF9sYZOwccEhtiomRm1hhjn7JxD83CSxHKM0J37RN99nX3i
 uo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vzp2PuepE9j/QhbDFWfyYY1TVW4y6EdlX7CwqPrRdYg=;
 fh=N9bUlhF3ThpKYITf0XF/maeL4tEEMgTPBOdm0GXjzqI=;
 b=iWepe9lQeT102q2lFlH0boM6esXU40DyhsCpznPgG2Iz5ZP8GFXYiHtcGToTaJJeem
 iAUP+9Q/qlKDBKX7qu3qF+PcQlvVi6EAaO8XXqHvIWF0iERNnv0+Z86E/pJRM5jJyqDa
 watK0uWsC+KzbAmB3UxHujVJZUz2kNp7Jto9jphBl8pyRp0YOH/vgmxwk+i2SISLVOS3
 nzFjP0e5RX3S2FsGnFs/wWK/VDpBbJ9cbDOQrC+Zy4CHaN1v1jaYQ1CyZIP8FZoDSfj4
 YBvsR21eArA8P9A1fadHMLQoxJNEwZm9zr52XK3trfnQyGfdax0kjaLn2ncubU01mq3r
 oa4g==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776327566; x=1776932366; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vzp2PuepE9j/QhbDFWfyYY1TVW4y6EdlX7CwqPrRdYg=;
 b=PKNNMrJ8p/8v3NWtpFDV3KWsHHrwaANLjXkT0T+Wl+3H5erSddMGNSGiiG2BycWONW
 cJPeCFaZ0y5rgQ/1+tHl4Plab3U+kBFeJu3vQojKlXv23Pnzaq4FHeFAxTCa9ouRJAni
 7WsVzkhaor0/Qj7LEAHlg2F5qr3432rVtJHpvdNNFwBm0sXH31FZ06IjEKDkVdUZUCnu
 1xAqsZC8e/B6qDdBAcSMi5CtrVa2dkjFNQ5AEjbMQu1j3X+Co9YYRnsEyGdyzUi4g1XQ
 htSFGzY+5dvcPQocUIcgwvqvggbm5lAg5ZSoYPPqp6y/uSGiph8u/fYqy60nzT0fBQQd
 aEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776327566; x=1776932366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzp2PuepE9j/QhbDFWfyYY1TVW4y6EdlX7CwqPrRdYg=;
 b=VEynyIRmIUPgcQmFTpX7UWU2whlNGcBiyLJKBSH0zyZK+j3kL7D6gWGjMUm8OUJZSk
 wSlYsFIQSrHx7bOuaPACO1Ip4ep/gVwKJSobJfyhlUnqQBEDks12QjpeLhyvR7JaFwhD
 zXUTBg1jeFy+TjZGuYrmS+o5mJZRFx58td0l0JP8Qc061pjn2M8B+ppwN65GrF7+xdqN
 SrDXzo2xYkr9D3KgGhUWRN5sgjdCZUnPryeSXYiTxeW1oNVNbkG7L33wSdpl8cbqPsS6
 BSlJ3byWAg+MRFT1B85PyEIYJYLHX4hhGmBWAh3Gy0THekSZPDNMhS27yEaq7Om8kBfs
 cPNw==
X-Gm-Message-State: AOJu0YzZkm7gSjA5YI0Awsxt85Gnj2n8+QZPSA+WQuWJn4mkvhNGCv0A
 FPbCgFGQXGiBceAt98POtJgxM13IoULpH+YHi46eYuqyZxLGTD5de6yKNrT6GY/CJCNoCKC+om1
 a2yOTJinKLgFUMtEpAcJ8y2XuXeSEglhhHYH09iQM5i29uY7s
X-Gm-Gg: AeBDievP469/0DAuuzICiI6sSXQiLsrgKs9rijDE/CWoqI35uwUQpbBEqN+pSrdGGlj
 vA9gdiwgV+2ehJjSBYLjdlEzH7Bny0Gb3tEl9mQvXxz0fsvSiFTM6okOhC2vhQAS7T+csbE64ox
 BwELSnmaDD0cABpKGjqivoA+IEUzN6+VCP2MHi/PlfhNJrkky2Lhsuoe46kavOTX0q2IoBTpvhZ
 IFLF31Go0VPKXA071Jf8IdkZCS4Xg3HRcdf4RoD/aE9pv5jz0aY59c3PjPwC20zxqrDkkvk11/N
 IrRNA2tU7clnMD63
X-Received: by 2002:a05:6214:478c:b0:89a:ff2:b8cf with SMTP id
 6a1803df08f44-8ac862c7f40mr364353416d6.44.1776327566576; Thu, 16 Apr 2026
 01:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250224100016.2857704-1-pvorel@suse.cz>
 <20260416070128.GA286748@pevik>
In-Reply-To: <20260416070128.GA286748@pevik>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 16 Apr 2026 16:19:15 +0800
X-Gm-Features: AQROBzDOhXk9_znGRd9L3tTF2ZlUP6iG15wGgVDwcmr660wEz_X9vJBcjhtJ9aI
Message-ID: <CANgNiRzpCv55Urf3wDA9SdRaHw2Mh8QCB5ogCmpS2cQQMk+iWA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

> > Allow to test only single struct tst_test->test_variants.
> > This is a similar feature to $LTP_SINGLE_FS_TYPE.
>
> > Value is ignored when test does not specify test_variants.
> > When value is higher than test_variants value lastest variant is used.
>
> Gently ping for this patch. IMHO it can be useful in some corner case debugging.

Agreed.

> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -581,6 +581,7 @@ static void print_help(void)
> >       fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
> >       fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> >       fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
> > +     fprintf(stderr, "LTP_SINGLE_VARIANT   Testing only - specifies tst_variant to be run\n");

How about name it as: LTP_VARIANT_START ?

> >       fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
> >       fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
> >       fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
> > @@ -1887,6 +1888,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> >       int ret = 0;
> >       unsigned int test_variants = 1;
> >       struct utsname uval;
> > +     const char *only_variant;
>
> >       lib_pid = getpid();
> >       tst_test = self;
> > @@ -1899,7 +1901,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>
> >       tst_res(TINFO, "LTP version: "LTP_VERSION);
>
> > -
> >       uname(&uval);
> >       tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
>
> > @@ -1908,10 +1909,20 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>
> >       set_overall_timeout();
>
> > -     if (tst_test->test_variants)
> > +     if (tst_test->test_variants) {
> >               test_variants = tst_test->test_variants;
> > +             only_variant = getenv("LTP_SINGLE_VARIANT");
> > +             if (only_variant && only_variant[0] != '\0') {
> > +                     tst_variant = MIN(SAFE_STRTOL((char *)only_variant, 0, INT_MAX),
> > +                                                       test_variants - 1);

Maybe limit the only_variant to range 0~(tst_variants-1)?

I think it'd be better to give a hint of the range rather than
excutiona non-exist number e.g. 99 there.

> > +                     tst_res(TINFO, "WARNING: testing only variant %d of %d",
> > +                                     tst_variant, test_variants - 1);
> > +                     test_variants = tst_variant + 1;
> > +             }
> > +     }
> > +
> > +     for (; tst_variant < test_variants; tst_variant++) {

I guess we need to reset the tst_variant value to zero before each looping.
Because if a test restarts, or manipulates this global state elsewhere,
it won't reset to 0, causing unpredictable behavior or skipped tests.

Then, something maybe like:

 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 {
        unsigned int test_variants = 1;
+       unsigned int variant_start = 0;
        struct utsname uval;

        tst_test = self;
@@ -2057,10 +2059,20 @@ void tst_run_tcases(int argc, char *argv[],
struct tst_test *self)

        set_overall_timeout();

-       if (tst_test->test_variants)
+       if (tst_test->test_variants) {
                test_variants = tst_test->test_variants;

-       for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
+               const char *only = getenv("LTP_SINGLE_VARIANT");
+               if (only && *only) {
+                       variant_start = SAFE_STRTOL((char *)only, 0,
test_variants - 1);
+                       test_variants = variant_start + 1;
+
+                       tst_res(TINFO, "WARNING: testing only variant %d of %d",
+                                       variant_start,
tst_test->test_variants - 1);
+               }
+       }
+
+       for (tst_variant = variant_start; tst_variant < test_variants;
tst_variant++) {
                if (tst_test->all_filesystems || count_fs_descs() > 1)
                        run_tcases_per_fs();
                else



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
