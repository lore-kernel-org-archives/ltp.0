Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4C3F94CBE
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 07:09:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B30E3E2D77
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 09:09:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9A2E3E1AA2
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:09:24 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6F97D1000980
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:09:24 +0200 (CEST)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-506aa685d62so32517921cf.0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 00:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776928163; cv=none;
 d=google.com; s=arc-20240605;
 b=aW7jYYoIqpnLF1vKBx4j2uGg8rMwnG9FQu9NMQI9RtRT126SfIxh8R0fXUZVEynbOu
 /CrAqz2GqZZGnvsKI/s1UDYid+V0434tkO+aUPy1L/gfTq2cbNMb2M0mBX1kLUWTYfGV
 7AX+aanH895JgQe3r7GD3FzBdU8DehNIFqbo2AneNpCBBrpAX5B90OthKCZ2bGBSgsFT
 3xRm4h3WNcDEaD4HtH0G4+zE3TNsYI470keP7Sb7TwyJncQsThibd0gWaPdebJO7Y+C1
 /qioCP6SYUiBYFxB21v/YVJB7FoGGUsyU6JshappBRwMa/01ExN3rnvQXPW7It+vUmwJ
 BvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K3Sogjg9Z7+Es0dS29mKJNMYFtjYxFfJp21sfBobZEA=;
 fh=CuExz54ljsO/o995PG49UG+i4lYrQxd0nQjicfLDGOA=;
 b=WY5S5GKXJCiW+0Z0rJv/A+voFb2rZzCko68RDixniRAbnpnwThvUvc7+sW+GzrPwbm
 e1UNah1Ti7i7xCuaqR5zOaamvxnkfx+5vlnO4HEk0eSwccQoA0CT+8abvs572dfWHimy
 lvBLMa0N9ihbRuXDvoSPue3G4UBAoxI0jp+Top9zcQt3xyhnSZtBlXVa3Wulp7llvoid
 MR5XqCMi9Y/NQXF6xjCJvQMjq3TvS23jfvZN2Q9QycL1XTkzfYyIwmxtSE6EUsjCdThN
 7mv3bl2LYAupr6yxTfkO4wzOVPCvNdYgNAOPlodnQSVhzuRMeMo0LnqJqFv1lZrrnAhq
 nl7g==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776928163; x=1777532963; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K3Sogjg9Z7+Es0dS29mKJNMYFtjYxFfJp21sfBobZEA=;
 b=hVa+zpCiDYg1Zzj1f1WGvuP5Q1tCD8dWiPEz1L3VFCB9YGbzYRtVbo3RN7v5pukA5A
 Zoo7TVeXkcq25Ae3QOu3jAUfxO7G3aKbXzX3sfm/GGMIkrhUn780G4nVSqdeFrlv0wkv
 rHX0SzGN/fcCQQMZA3g+g4aXQCGfai7xOfoJvmbbbpB1Wb+obqXYewVFMXqdNYlfHg02
 swpc/fMQ7d12Bjq0FUucpyih0xOW47DF+dbrXL0or7vfTyEUrnFc0YcYXJv4uIwbFE2Z
 Z+7371r1ZRK3E6S8gGL54bhcY7wtulayUpd98JwFH4+aGqE+QmxiA1HCwf7oSXh9iRma
 DhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776928163; x=1777532963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3Sogjg9Z7+Es0dS29mKJNMYFtjYxFfJp21sfBobZEA=;
 b=p229d3iIt+KdLa8cTu3KiMTrs2fdHh/Bnoua/FtzDBNC/yaG1V7WR0jM0Q/Lveqpdg
 jivIyIcuJtLQO3gJU8I9NAVisCCBkPkjzi22q2FMPkw0f/JTcgTp4MFFzV/AcK0f5g/a
 Wfo4rHa6tM1Iw3n7uv3AAb1WaKT9AvoD8j6c0xWN8A7bpj68xB7MaIAlaQB0UNuVuaio
 +eCEs84KA5kfAnD1aA7rSSAul8z65WwMkCeLUdMN3+lJ0H470AassRJ24pjmcHrPCrTK
 pRUbhSZkVeYO0GphjwwoF0K2nfhGfCEKK0YRIMNglUSRlrJ668cIVCz92OK7ggPyaVkG
 6Nrw==
X-Gm-Message-State: AOJu0YyWYSjJedndrLBAx7CKvwwySUc200ogcXvEjY2f6VhgY3TfgHzx
 qjYtrGsY4fyENp9tIAsHy3geu6qnWyaoogdJ/G8/bYebBlsrCt4rlwqutnkb7fdyDB3KxgvcYWr
 0eaqPmVqslFsgjFdrXIJTfCznIxpnsQ==
X-Gm-Gg: AeBDieu+ELBL4OzEeFmzISCa9gjf6b172QXWS6GuWppy+O+WJ4RmW7CWU0bZjY1edpC
 Lpv2xV+R+e3OP8j0qnUylIbQmUNFGhfaWPOQSJ6uyPp2cDIZ0f/t+9tRS3MCK+A+gIh2j6Lx5XP
 VPiU6oFmR5bi/u48E506Iyex0QKaKdZGpcnivs5s/e059jv5PNqa65FhlsRBX1RDE0r5maYDpUU
 Y7OeJXGb6tlhdymFpDb8Yn9Cmo7bGgxTD8jjdKwf6lPo/DFSIAyWm8EQRuXWIyFB3k4UmZTjSGG
 F1obfJjABCjUvWrK2g==
X-Received: by 2002:a05:622a:1646:b0:50f:ae60:25ab with SMTP id
 d75a77b69052e-50fae6029fbmr203921651cf.12.1776928163122; Thu, 23 Apr 2026
 00:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260422141234.632195-1-pvorel@suse.cz>
 <20260422141234.632195-6-pvorel@suse.cz>
In-Reply-To: <20260422141234.632195-6-pvorel@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 23 Apr 2026 15:09:11 +0800
X-Gm-Features: AQROBzCHO_EVSkCOaJu43wAzSjPKn208oqkn7x4aDUJHByK9dQj3L6g-Q3Y7dzs
Message-ID: <CANgNiRygF3v7V3jAPJ10J+FW1-0fTQf4pq08jJSo8gtKHWmkZQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/5] lib: Merge functionality of LTP_QUIET into
 LTP_REPRODUCIBLE_OUTPUT
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
Cc: ltp@lists.linux.it, Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

> LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
> help valgrind to use LTP for testing. It discards the actual content of
> the messages printed by the test (removes everything after printing
> TINFO/TPASS/TFAIL/... flag).
>
> Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
> TINFO, and TDEBUG messages.

In this patch, I didn't find that it suppresses TWARN messages.
Should we add it as well?


> Valgrind project uses both variables but no need to handle them
> separately. Therefore merge functionality of LTP_QUIET into
> LTP_REPRODUCIBLE_OUTPUT.
>
> LTP_QUIET was not even documented in HTML doc (no need to update docs).
>
> Implements: https://github.com/linux-test-project/ltp/issues/1306
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v4.
>
>  lib/tst_test.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 12f7489d4e..51d64e8414 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -68,7 +68,6 @@ static int iterations = 1;
>  static float duration = -1;
>  static float timeout_mul = -1;
>  static int reproducible_output;
> -static int quiet_output;
>
>  struct context {
>         int32_t lib_pid;
> @@ -307,7 +306,7 @@ static void print_result(const char *file, const int lineno, int ttype,
>                 res = "TBROK";
>         break;
>         case TCONF:
> -               if (quiet_output)
> +               if (reproducible_output)
>                         return;
>                 res = "TCONF";
>         break;
> @@ -315,12 +314,12 @@ static void print_result(const char *file, const int lineno, int ttype,
>                 res = "TWARN";
>         break;
>         case TINFO:
> -               if (quiet_output)
> +               if (reproducible_output)
>                         return;
>                 res = "TINFO";
>         break;
>         case TDEBUG:
> -               if (quiet_output)
> +               if (reproducible_output)
>                         return;
>                 res = "TDEBUG";
>         break;
> @@ -676,8 +675,8 @@ static void print_help(void)
>         fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
>         fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
>         fprintf(stderr, "LTP_DEBUG                Print debug messages (set 1(y) or 2)\n");
> -       fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
> -       fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");

> +       fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TCONF, TWARN, TINFO, and TDEBUG messages and");
> +       fprintf(stderr, "                         discards the actual content of all other messages");

I guess this two-line format is a bit strange when printing.
Maybe we need to combine into a single fprintf()?


>         fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
>         fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
>         fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
> @@ -1398,7 +1397,6 @@ static void do_setup(int argc, char *argv[])
>  {
>         char *tdebug_env = getenv("LTP_DEBUG");
>         char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
> -       char *quiet_env = getenv("LTP_QUIET");
>
>         if (!tst_test)
>                 tst_brk(TBROK, "No tests to run");
> @@ -1429,10 +1427,6 @@ static void do_setup(int argc, char *argv[])
>             (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
>                 reproducible_output = 1;
>
> -       if (quiet_env &&
> -           (!strcmp(quiet_env, "1") || !strcmp(quiet_env, "y")))
> -               quiet_output = 1;
> -
>         assert_test_fn();
>
>         TCID = tcid = get_tcid(argv);
> --
> 2.53.0
>


--
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
