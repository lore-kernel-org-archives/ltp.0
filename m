Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D2AC27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718025461; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=uk9yINX0oec7fAj93s9jOaUSZCPmrXN+HUm1tnfvsuo=;
 b=BSic6c79qMzLnbkE6fUSPSvMG5F7kaul4ytQ43b8+WTZ1GrthUNletJ6zXVIClb03osne
 JAJpXRVMC62Eh6fcezpd9cCuTrXtVuUgpLvKIQRCfF4m96hIOo6hUpRKAz1zpNcaNNavTOq
 xuO40M3D5g7YLIIDnmGRzre9V6kjS/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F0043D0B2D
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 15:17:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 283723C9430
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 15:17:20 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 552E8600693
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 15:17:19 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6f04afcce1so216511466b.2
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718025439; x=1718630239; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JpDcXZEXRh5XmDE3NGCrEmmj0wqRWDLyqDzQ9rZm5OQ=;
 b=KIx36+XXCv9jRlV5N6Uc/1r9YKVm5zpUEHEjvxAkLRQrfyGSG+U55p3/eCcEDrIAd/
 DQuDJUtUwy9cXKxkTxC71jI0KjtLIVc0plJmWnicSY+yu/GW4L42iANiDz7AI6ARc7J3
 J1Gi76MzhpgoIOvBr1VaUQwOvzrzaPvZraO0pSQpGk6ajau0+ViHBRJu44aqMe8fVak1
 jLOtYXh39mLJNuXgxWMmBuN2BsCL8dIgXMqeKtTNLyvSC36KZnduCG9ItBgo9a5zC8Md
 kzChkS1Y2qzjyjBlLI7qwiJdLrbRf+l2f16rscqrv/qkx2boDJucF0EGl2S0eEcUxGFg
 alcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718025439; x=1718630239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpDcXZEXRh5XmDE3NGCrEmmj0wqRWDLyqDzQ9rZm5OQ=;
 b=M5s4urNvt0Vw/2wonFG9xtwCiEWDBmDAAh+fceqUwKg9+iTwQJ8JxszadOkp7U3KUF
 tw1dexqm3LWIyjOxPTDy3ky3sRtrn2rBey+fVMLkMWHw+BI1O6MGSir9m/21WQb/Q8iQ
 n2pn28ZWTAfaZs4kh/QM9RXtfMZc10qVAfZ6pKlsjtBvcfi0vanlqLGGxkVyvJSUfeRn
 r/RUz8dZsFvQeP+w7jEwheBddFYsIcG790sRM/eQnLng0JHO1LJzdu7IpHTzwVCymmwx
 K2QcJFFLVZNNJybfuNpQ7Zgm2H8i4qmhoMuhO8JF+/fpRkJVsaaJGT0znAg9bM9QVRBu
 c1Ig==
X-Gm-Message-State: AOJu0Yz/SEEYOHwn1a9MRhAs3GAka2gkduhA1CK/mEKeYKND/7A644n7
 jravcK2rYZvqi1oz3NAv73aEbP5qdBARZBEUCOfPybD/LYW8QxHUj//Dqr7CLfU=
X-Google-Smtp-Source: AGHT+IHtIGr/tjbJQ8cD/fih0yfh0yJIDUUw+ZqtFgMw6DbHaib6ghBeIMCjvjwTGa/Tzn1rZAILHg==
X-Received: by 2002:a17:907:7e82:b0:a6f:d57:aedc with SMTP id
 a640c23a62f3a-a6f0d57afc6mr510553566b.57.1718025438519; 
 Mon, 10 Jun 2024 06:17:18 -0700 (PDT)
Received: from [10.232.133.65] ([88.128.88.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6efe3d3cafsm352855266b.158.2024.06.10.06.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 06:17:18 -0700 (PDT)
Message-ID: <cdf96b5d-5995-4be5-8913-cfc9385480d4@suse.com>
Date: Mon, 10 Jun 2024 15:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
 <20240607-shutdown-v2-1-a09ce3290ee1@suse.com>
 <20240610131348.GA732398@pevik>
Content-Language: en-US
In-Reply-To: <20240610131348.GA732398@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add shutdown01 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

I agree with the proposed changes. Thanks, feel free to merge.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 6/10/24 15:13, Petr Vorel wrote:
> Hi Andrea,
>
> TL;DR: generally LGTM, I have few minor details, which I offer to fix before
> merge (diff below).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> +++ b/testcases/kernel/syscalls/shutdown/shutdown01.c
> ...
>> +static struct tcase {
>> +	int shutdown_op;
>> +	int recv_flag;
>> +	int recv_err;
>> +	int send_flag;
>> +	int send_err;
>> +	char *flag_str;
>> +} tcases[] = {
>> +	{SHUT_RD, 0, 0, 0, 0, "SHUT_RD"},
>> +	{SHUT_WR, MSG_DONTWAIT, EWOULDBLOCK, MSG_NOSIGNAL, EPIPE, "SHUT_WR"},
>> +	{SHUT_RDWR, 0, 0, MSG_NOSIGNAL, EPIPE, "SHUT_RDWR"}
> Would you mind to use
> 1) designated initializers (e.g. .recv_flag = MSG_DONTWAIT,)
> 2) stringify macro
>
> IMHO it helps readability, that's why it's often used.
>
> #define OP_DESC(x) .shutdown_op = x, .desc = #x
> static struct tcase {
> 	int shutdown_op;
> 	int recv_flag;
> 	int recv_err;
> 	int send_flag;
> 	int send_err;
> 	char *desc;
> } tcases[] = {
> 	{OP_DESC(SHUT_RD)},
> 	{OP_DESC(SHUT_WR), .recv_flag = MSG_DONTWAIT, .recv_err = EWOULDBLOCK,
> 		.send_flag = MSG_NOSIGNAL, .send_err = EPIPE},
> 	{OP_DESC(SHUT_RDWR), .send_flag = MSG_NOSIGNAL, .send_err = EPIPE}
> };
>
>> +};
>> +
>> +static struct sockaddr_un *sock_addr;
>> +
>> +static void run_server(void)
>> +{
>> +	int server_sock;
>> +
>> +	server_sock = SAFE_SOCKET(sock_addr->sun_family, SOCK_STREAM, 0);
>> +
>> +	SAFE_BIND(server_sock,
>> +		(struct sockaddr *)sock_addr,
>> +		sizeof(struct sockaddr_un));
>> +	SAFE_LISTEN(server_sock, 10);
>> +
>> +	tst_res(TINFO, "Running server on socket file");
>> +
>> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>> +
>> +	SAFE_CLOSE(server_sock);
>> +	SAFE_UNLINK(SOCKETFILE);
>> +}
>> +
>> +static int start_test(void)
>> +{
>> +	int client_sock;
>> +
>> +	if (!SAFE_FORK()) {
>> +		run_server();
>> +		_exit(0);
>> +	}
>> +
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	tst_res(TINFO, "Connecting to the server");
>> +
>> +	client_sock = SAFE_SOCKET(sock_addr->sun_family, SOCK_STREAM, 0);
>> +	SAFE_CONNECT(client_sock,
>> +		(struct sockaddr *)sock_addr,
>> +		sizeof(struct sockaddr_un));
>> +
>> +	return client_sock;
>> +}
>> +
>> +static void run(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +	int client_sock;
>> +	char buff[MSGSIZE] = {0};
>> +
>> +	client_sock = start_test();
>> +
>> +	tst_res(TINFO, "Testing %s flag", tc->flag_str);
>> +
>> +	TST_EXP_PASS(shutdown(client_sock, tc->shutdown_op));
>> +
>> +	if (!tc->recv_err)
>> +		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
>> +	else
>> +		TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, tc->recv_flag), tc->recv_err);
> very nit:
>
> 	if (tc->recv_err)
> 		TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, tc->recv_flag), tc->recv_err);
> 	else
> 		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
>
> If you agree, I can merge with following changes.
>
> Kind regards,
> Petr
>
> diff --git testcases/kernel/syscalls/shutdown/shutdown01.c testcases/kernel/syscalls/shutdown/shutdown01.c
> index ba3853d9c..8e58f23e6 100644
> --- testcases/kernel/syscalls/shutdown/shutdown01.c
> +++ testcases/kernel/syscalls/shutdown/shutdown01.c
> @@ -19,17 +19,19 @@
>   #define MSGSIZE 4
>   #define SOCKETFILE "socket"
>   
> +#define OP_DESC(x) .shutdown_op = x, .desc = #x
>   static struct tcase {
>   	int shutdown_op;
>   	int recv_flag;
>   	int recv_err;
>   	int send_flag;
>   	int send_err;
> -	char *flag_str;
> +	char *desc;
>   } tcases[] = {
> -	{SHUT_RD, 0, 0, 0, 0, "SHUT_RD"},
> -	{SHUT_WR, MSG_DONTWAIT, EWOULDBLOCK, MSG_NOSIGNAL, EPIPE, "SHUT_WR"},
> -	{SHUT_RDWR, 0, 0, MSG_NOSIGNAL, EPIPE, "SHUT_RDWR"}
> +	{OP_DESC(SHUT_RD)},
> +	{OP_DESC(SHUT_WR), .recv_flag = MSG_DONTWAIT, .recv_err = EWOULDBLOCK,
> +		.send_flag = MSG_NOSIGNAL, .send_err = EPIPE},
> +	{OP_DESC(SHUT_RDWR), .send_flag = MSG_NOSIGNAL, .send_err = EPIPE}
>   };
>   
>   static struct sockaddr_un *sock_addr;
> @@ -82,23 +84,22 @@ static void run(unsigned int n)
>   
>   	client_sock = start_test();
>   
> -	tst_res(TINFO, "Testing %s flag", tc->flag_str);
> +	tst_res(TINFO, "Testing %s flag", tc->desc);
>   
>   	TST_EXP_PASS(shutdown(client_sock, tc->shutdown_op));
>   
> -	if (!tc->recv_err)
> -		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
> -	else
> +	if (tc->recv_err)
>   		TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, tc->recv_flag), tc->recv_err);
> -
> -	if (!tc->send_err)
> -		SAFE_SEND(MSGSIZE, client_sock, buff, MSGSIZE, tc->send_flag);
>   	else
> +		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
> +
> +	if (tc->send_err)
>   		TST_EXP_FAIL(send(client_sock, buff, MSGSIZE, tc->send_flag), tc->send_err);
> +	else
> +		SAFE_SEND(MSGSIZE, client_sock, buff, MSGSIZE, tc->send_flag);
>   
>   	SAFE_CLOSE(client_sock);
>   	TST_CHECKPOINT_WAKE(0);
> -
>   }
>   
>   static void setup(void)

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
