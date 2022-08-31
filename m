Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE24ECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 09:21:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93A223CA0B0
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 11:21:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C3CD3CA6CE
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 11:20:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78ECD1000A52
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 11:20:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67DBA2224B;
 Wed, 31 Aug 2022 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661937646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BqhNObxgpxxdaAp7o4G0wuGLVRG6ObRN0CKG2PQaU8=;
 b=OkeJVtkiF3QVYncEY8Yr7RF0YBQLqOiM0P5y7TdpcTnTpbgZNHIOi60ZcZiOCwW+sRQG3W
 PLLzYbOMJh9/u69rQApFGZAVCjrSIGsb6rnX3HeojSMjyOTrjRRJEXY36tbKpxfMchdSe9
 4usCp0udCV65CHJPM8qYLNNj7uSYrS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661937646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BqhNObxgpxxdaAp7o4G0wuGLVRG6ObRN0CKG2PQaU8=;
 b=HM/4V9qFHiz3RkjVtQUpCEALdoqEulVjN9BV/zqBIt8g72eGuKEOwl/aY3qOotXrB5KhxN
 8r/+53U6ntcVeBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52F821332D;
 Wed, 31 Aug 2022 09:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /X7wEu4nD2OWQgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 31 Aug 2022 09:20:46 +0000
Date: Wed, 31 Aug 2022 11:22:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yw8oZYwebeVBPC0P@yuki>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-7-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220830135007.16818-7-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/10] copy_file_range01: Add max_runtime
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

Hi!
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> index 7d27007a3..23a5ec501 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> @@ -232,4 +232,5 @@ static struct tst_test test = {
>  	.all_filesystems = 1,
>  	.test = copy_file_range_verify,
>  	.test_variants = TEST_VARIANTS,
> +	.max_runtime = 20
>  };

I would still make the loops that copy and read the data runtime aware
to make the error messages more obvious. In the case that you want to
keep TBROK return value it would be:

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index 7d27007a3..9b39554d6 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -52,6 +52,10 @@ static int check_file_content(const char *fname1, const char *fname2,
                ch1 = getc(fp1);
                ch2 = getc(fp2);
                count++;
+
+               if (!(count%100) && !tst_remaining_runtime())
+                       tst_brk(TBROK, "Out of runtime, exiting");
+
        } while ((count < len) && (ch1 == ch2));

        SAFE_FCLOSE(fp1);
@@ -135,6 +139,9 @@ static void test_one(size_t len, loff_t *off_in, loff_t *off_out, char *path)
                        return;
                }

+               if (!tst_remaining_runtime())
+                       tst_brk(TBROK, "Out of runtime, exiting");
+
                to_copy -= TST_RET;
        } while (to_copy > 0);

@@ -230,6 +237,7 @@ static struct tst_test test = {
        .mount_device = 1,
        .mntpoint = MNTPOINT,
        .all_filesystems = 1,
+       .max_runtime = 20,
        .test = copy_file_range_verify,
        .test_variants = TEST_VARIANTS,
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
