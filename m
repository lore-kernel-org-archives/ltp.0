Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E51C83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 04:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752725394; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=S02P3NHOnA/3hyWhTz7LG1g46zO5oughGyXKuklJy9w=;
 b=BIJgo9cOOZgLqaF2VM1XyVt+SZ9Li1rOntZHpq9lDqxqgZMOOLOeRNlVXHTblykVQT0PI
 okZn81XSNeWMbNUSfnxjhJmzFpz/onP9OHcd4zYATpkxpwMfjG2OUMTsHyw0XSI1vlDILer
 OJQDIGYd+aR5SuXzTYybQU07mqrNv+Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D1393CC17D
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 06:09:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B5223C64EF
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 06:09:32 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA3436002CD
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 06:09:31 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d54214adso2892835e9.3
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 21:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752725371; x=1753330171; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k6rsfRah7tQZa7iVIpOzrjeRDWOIID241jAL8IeklOU=;
 b=YHIpXHfF8x0t+PBYvC/wbjOEkP/hwruvUnBXbn+Qk0OSHjBmqXTL3nS/l3Kp5oLxPD
 kIb4/8xZwEGTodMHhxfKBxwDC53bsubpX5mjM9ApB5wztWioMdsuU/drHJD/puvCBuQY
 SzbWkU/qvpEVODCu5Kf6qiuCkF7dC+crFvr4OnLCRVqP7gxWg2BM/5ah5GDjvk/RuZsW
 qfn3hyMFr5Ke/sJjtMTQTNFv4e9SY1fsQMv6Wflnh8EfIl6m7gJczZvX9QAxtwgEGANp
 mSTVVPLvla4XlJA4Sd+qYjnxbAqx0qUdldk4TaRXfWIQHE2JFRpMXzvDliS6XxGHVq0I
 dOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752725371; x=1753330171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6rsfRah7tQZa7iVIpOzrjeRDWOIID241jAL8IeklOU=;
 b=v78lLNaCBPHm/cBGmfZUiX5R23F88CpR7Vern8w69Ti08PTWnk0ETOX1s8VfPxuh0G
 ZilqgzdQjlvRUQvKWqVmJGBHjrnfXFtibQZsSJ/VeghrdceIk+zxko+Qa4k7qZwXsmqL
 MXFmSOqasF/WRNjGWTU9hwf15UHPXsXrfc3c5GHMGQqe4sWwj8kXbDi9fh2eXRcIXavl
 vHoYZnRYQ13FCpFOql+jrhWcAHy+RFYI2xlWrRWXOKQoIIJ325poLr1gdHaDP/mFhxvp
 iOFymtIoCARqzFl4bOIYTqmsCJrF1HGggWYGZLfgPbHBWcAlpX2flpnJQ9Kq17Jt2MCP
 nZeQ==
X-Gm-Message-State: AOJu0YxnKH+o6nTA2vxvTQcveNSwrwc8DrP0amZSHY3pQ5gZQh1n8/vZ
 sV8slnWsw6anCs+kdIe30NKHcTgMyB7VgLwaOU9sslXsJJlVPpkVbnqXXKFD2ALb6w==
X-Gm-Gg: ASbGnct1ziTU3Ih6d+mnmcD4YI8mwr2P0w5jS4rFVWlwrfnvzXp8xXvLYSsYv2WsUNI
 Hoc2DaOUwIG3ArC4GCuD6pw3SXNXa90dmfWS53zcjEu0Img4rW62FVkqU1UbbOH+ywqXxVvHMm4
 AX4kTf/O9ULPut36Oaj4gqSMQwjFpBVdxrE75u83xr9ipcOzEipPdLu4Ibj2j6LzUixt1hGkZWO
 tdy6YAqi+D8I5JhcbkxkIy4E5vJolIahoBqltG7C+rslFMZhICwn05bdHqf87G73xclmvtX2gTw
 FKQ7tKF3wvsoItd9PgZBR0Sgv9KlzMnYo4THggs9qU/DIpTnCjPZx7Pdtv3ekw6aGCQyf1AlZXv
 aVNNZu8aF6/AruuzixQaeNw==
X-Google-Smtp-Source: AGHT+IFG9I5j0SNJX7quuIRwsrKiXNF9gcZVMOfT/SK+RcJ8qEotb2E066zMZuY5FkVEgp08X0yJ6Q==
X-Received: by 2002:a05:6000:490d:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3b613eac813mr858032f8f.57.1752725370935; 
 Wed, 16 Jul 2025 21:09:30 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8b990sm15196906b3a.153.2025.07.16.21.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 21:09:30 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:08:46 -0400
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <aHkgDtMtVINthghW@MiWiFi-CR6608-srv>
References: <20250716072846.600659-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250716072846.600659-1-florian.schmaus@codasip.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sigrelse01: Fix out-of-bounds read when
 invoking write()
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

On Wed, Jul 16, 2025 at 09:28:46AM +0200, Florian Schmaus via ltp wrote:
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
> 
> Changes in v2:
>     - remove unnecessary '\n' in tst_resm
> 
>  testcases/kernel/syscalls/sigrelse/sigrelse01.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> index 95754212053e..68d69c3ef5e7 100644
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
> +			tst_resm(TBROK, "write() pipe failed. error:%d %s.", errno, strerror(errno));
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
Thanks for your update. I don't see any obvious mistakes.
Reviewed-by: Wei Gao <wegao@suse.com>
> -- 
> 2.49.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
