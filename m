Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA50CC83F27
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 06:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752648442; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=o3b8P5luhleE3JhdBb+dE0PZIWzCjKSiX+kHdlLPujY=;
 b=eGCqkme21gANnLDEhZ4xDWxhihkEWGcf6S8x8ge6ilG8fWgAPbzgSRf6SHtl+CzB9fNtN
 wVUhacw4RRDp7H23Civswf3R28fnBr0XWOVdxTX7COzgOZiovTZs7i/Ua78Pdb13p1pjiLh
 MO88h6spxvhZ/ADA6f9e27fftpsgZ5Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 125BB3CBD0D
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 08:47:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3436A3C9B01
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:47:00 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 231621000C1F
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:46:59 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4561607166aso23723055e9.2
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752648418; x=1753253218; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HUg1mhAjJjs05RckNcFA81kslKLxjVX5Zzh0P1p46+A=;
 b=XyNJSMGY/jqcmA5dl/GClBrU3tV+4Qz9FTweCCXeAERp2lebWSfZtrksh14wqauG3h
 KN8n4QYc4CPJeltYHBnc3Ia1B8TiT7D8eX3Yn1IWO5drf58eQS4CeQwu33OuS8OmFwTf
 x/sUIhcyIj5gtIRL79UrYuSxwH8ScnmWyWCWweDXPBSJwTn8FXspy2dQYKiqTsIBzCCG
 NqbM1RKGaULHy17uvSrcGpFe+lu6Rq64GKRkKUh2QlO4IM5Ttbah052HT8AnB1yeDlpF
 RMNNzcSbQ3L3/CeOB5S4WXBCd9X0UFr107QMlgIxYTaJjY/13LfkIr50d4dXhEF/Iwts
 OEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752648418; x=1753253218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUg1mhAjJjs05RckNcFA81kslKLxjVX5Zzh0P1p46+A=;
 b=GBlRUffiT+cKihXAktZCqKRvUScyf+OyX/vxRpbzqi6ThjcJmXynyUnYc6tcn7AoEg
 8yq2+qXXMWuTag2xO3Ln8FW+wPqNKO4Zq+T7nUvHJN90ssrboEhu1og5EbqzpkBQnFny
 Msk90y+kWdEzaybSJ/YjbIjg3uJlE9yl2z31koiZkhjzce07oYP3DZx0BxW82as+Qy53
 2SvbP8ylzIpMzL6K67qneh61QgVjJ+UUYwQApIi0X1qMKd2CLEp2YtkzRfRTIzu3jhX0
 iMYMiUwpRMfgcTbsxLUewJCcoweF6XAll72I4MsAu/TxCwlh+Lz4qVg6FeYaHBNVFc+z
 +vqw==
X-Gm-Message-State: AOJu0YwNQZ3dA2pX+h/aIEPGTmn0EzWTzXny6pjSKluDWfg5zbBfmNFr
 pRZglw0bgWEDgpP5fskAXqqoaV/YgNVXgqBqLzI8NO1ABWvIUcbqLFwNFw4h9OB8jBJfEYCh/s4
 HJW6pIQ==
X-Gm-Gg: ASbGnculrgH2aSMGE5l1+VlJET76w45frKJdl2alNnk8SqXQy8mK/5SI3JppLaN0GjA
 He+b23xQDPYOncejtigM/aPabINymDRdzo/f2U7XF4sjBaTdmnUAJDLDr3XTVvVGFGq+JBqA3Qy
 9fwNimaZ4FqnoacKEho5p+CEVWLzEzXJjW3Bqgd8lIiAv2IejNAmrPfpnynql8aRQ472Ew1O/FT
 H/0UE07k+Y3Q4ChUAxKnYlYwkBh6djkboQBya2DSj9w22VyN3oOoCpoMWOsvyu5vNIr8lkH1yBq
 eOKvPCBUvbqEpxpcnoeyTBBMcJZmeYFWS5kpxNYYbxp4sRZShW589NWsUQDMf6ggFkqcLnUDlEI
 vdtOp0VZNBOjGCammPQVFzA==
X-Google-Smtp-Source: AGHT+IH63G7+JeXq0Z49uxLVgF1D34ufbd1TpeJeXQdSysD98l5AmVJqK03KRlyN5E23QYrg4VW3/Q==
X-Received: by 2002:a05:6000:4305:b0:3a4:d0dc:184d with SMTP id
 ffacd0b85a97d-3b60dd95c4dmr1325248f8f.27.1752648418431; 
 Tue, 15 Jul 2025 23:46:58 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8ce06sm13588186b3a.157.2025.07.15.23.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 23:46:57 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:46:13 -0400
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <aHfzdQIGbChfW13s@MiWiFi-CR6608-srv>
References: <fef71466-54df-4561-a19f-e904c6f79c3b@suse.com>
 <20250715092015.505957-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250715092015.505957-1-florian.schmaus@codasip.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigrelse01: Fix out-of-bounds read when invoking
 write()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 15, 2025 at 11:20:15AM +0200, Florian Schmaus via ltp wrote:
> The sigrelse01 test would invoke write(fd, msg, MAXMESG), where
> MAXMESG=512. However, msg is often as short as "ready", i.e., 6
> bytes (5 bytes + \0).
> 
> This mismatch causes write() to read additional bytes outside the *msg
> buffer and write everything to the file descriptor. For example, the
> strace output of sigrelese01 contains the following:
> 
>     write(6, "ready\0Unable to tell child to go"..., 512)
> 
> Fix the out-of-bounds read in sigrelse01 by invoking write() with the
> correct number of bytes to (read and) write by using strlen(). There
> is one case where sigrelese01 invoked write_pipe() not passing a
> string: when the child sends sig_array to its parent process. We
> convert this case from write_pipe() to write() using the proper
> arguments. After doing so, the memcpy() of sig_array is no longer
> required.
> 
> We identified this issue on a CHERI [1] system, which provides
> fine-grained memory protection through architectural
> capabilities. Unlike traditional MMU-based protection, which would not
> detect this specific out-of-bounds access, CHERI precisely bounds
> memory regions. In sigrelse01's case, CHERI correctly identified that
> the 6-byte buffer containing "ready" was being overread. Consequently,
> this out-of-bounds read during the write() syscall would cause the
> Linux kernel to return -EFAULT, revealing this hidden bug.
> 
> 1: https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/
> 
> Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
> ---
>  testcases/kernel/syscalls/sigrelse/sigrelse01.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> index 95754212053e..f7fdfbab3a28 100644
> --- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> +++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> @@ -486,12 +486,14 @@ static void child(void)
>  	 * then PASS, otherwise FAIL.
>  	 */
>  
> -	if (exit_val == EXIT_OK) {
> -		(void)memcpy(note, (char *)sig_array, sizeof(sig_array));
> -	}
> -
>  	/* send note to parent and exit */
> -	if (write_pipe(pipe_fd[1], note) < 0) {
> +	if (exit_val == EXIT_OK) {
> +		if (write(pipe_fd[1], sig_array, sizeof(sig_array)) < 0) {
> +			tst_resm(TBROK, "write() pipe failed. error:%d %s.\n", errno, strerror(errno));
tst_resm will add "\n" at the end of string so you do not need add it.
> +			exit(WRITE_BROK);
> +		}
> +	}
> +	else if (write_pipe(pipe_fd[1], note) < 0) {
>  		/*
>  		 * write_pipe() failed.  Set exit value to WRITE_BROK to let
>  		 * parent know what happened
> @@ -622,7 +624,7 @@ static int write_pipe(int fd, char *msg)
>  	printf("write_pipe: pid=%d, sending %s.\n", getpid(), msg);
>  #endif
>  
> -	if (write(fd, msg, MAXMESG) < 0) {
> +	if (write(fd, msg, strlen(msg) + 1) < 0) {
>  		(void)sprintf(mesg, "write() pipe failed. error:%d %s.",
>  			      errno, strerror(errno));
>  
> -- 
> 2.49.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
