Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29777CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725265882; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=jACvKghdh8dhA/qE/Xme+nzdKCm4OS2mxLe+vyJkUyA=;
 b=eDAop6k1WhN/ntLVid+vSQyhnDmigfe+lDalQHJHg98QB2T3M1airTckumu/xWRAuExbK
 GxbOl7kj5u/a74pzlyyHzAleOuDpcKDTc7+IZqRFZB8ABaf3UCBR0EaLkn7y6Hu+B/6DTn/
 EeWuRIqyVZfvojlpFLe+z3KE9dDYJfk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A7563C32B1
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 10:31:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30F323C2FE1
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:31:02 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 332F4140171F
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:30:52 +0200 (CEST)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f3e071eb64so53721531fa.1
 for <ltp@lists.linux.it>; Mon, 02 Sep 2024 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725265851; x=1725870651; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yhmhexU+tkFbYoxC9gZZxe9+VifXTcUTaz+YNbMqyEM=;
 b=Uaswmv1JfN0MiKYdKcpbb5IcLfzG6wyTFA1u+MKTY6Ro8TP9gFVjEPi75l9AxJvkGn
 RkiU/HGwcsB5imCO1Fp8ueQOzlgruqsV/SzfE/6xvYVhL4d+W+VKmmZTHpC/VejAI5Uq
 HO6YVW6q2tGIJliidgI28Xdi2ZdIpHdGuVba95JxKRsK7YaSgHr/COsiHCEwCp6JglR9
 RUWtVFVdRxfUfNVk0FAPVKZTq7pKXzoOtqz2AEgghZc7V1dJERxDccVZ/5WZFteve2pu
 PuMrhGAeLN/dmMLaM4O4Zv+bP3U1HbD3aHmJSu/iAkiYWbVQ95+4gCwSxbvgEoLH7Yt0
 TVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725265851; x=1725870651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yhmhexU+tkFbYoxC9gZZxe9+VifXTcUTaz+YNbMqyEM=;
 b=Nacl4WY3CkLw2h637Rc3RJOsQJxWIIB+ej2rvlJPhMeUmecaFE8SeFuFzHpbPDaxYz
 KxfedCdFbuKlDvzt8U2mDR/BRTDFFFCOx/vRZ697mWlZzpkDE0TWuLBpdc+AqLttJ0oY
 Mq+3U8AmkU/FVueH5T473b5M9FWqqaeW+DNBOonyffNxMGS5Zd96zmCqaAcauBCgnjIH
 HbDXMn8LnSy+uyXqH9pcPgNmaSQe6spg813MbjELCqXNvaLGayfJZczGVIP8Nk6hxZ1B
 2e1nJuEc8kVb4f2lypA7SCvWd0nPTvFvEfhdIusEQupGObDzCNvQ1HasoZVheNA3JY+5
 vznw==
X-Gm-Message-State: AOJu0Yyo2LYD0/+aDdSp8sJtUiZuijTvc7Ro8k6Ylu8MYekCbCmn8FXU
 nR7jqHU/BDcLCue9EX5MxzZnme8uyiY/GxJD6+km01FxWAdX+qCd9+lAvEpsQ/0=
X-Google-Smtp-Source: AGHT+IERIbKi3intg/JhIEaPkJCLQey59IPao78tNbt/F2wPns8Z3qyBxFcVs/QhGEY9iyOMGRAbSQ==
X-Received: by 2002:a2e:515a:0:b0:2f3:cf43:c2a8 with SMTP id
 38308e7fff4ca-2f6108ae2a1mr84231481fa.42.1725265850524; 
 Mon, 02 Sep 2024 01:30:50 -0700 (PDT)
Received: from [192.168.178.49] ([213.220.148.179])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8988fea68dsm523762566b.26.2024.09.02.01.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 01:30:50 -0700 (PDT)
Message-ID: <f3a459fc-1777-4106-8313-0bd4395c309d@suse.com>
Date: Mon, 2 Sep 2024 10:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240515114339.19708-1-andrea.cervesato@suse.de>
 <ZtHQIQE--xS0MAve@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZtHQIQE--xS0MAve@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite fcnt14 test
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

Hi!

On 8/30/24 15:58, Cyril Hrubis wrote:
> Hi!
>> +fcntl14_01 fcntl14
>> +fcntl14_01_64 fcntl14_64
>> +fcntl14_02 fcntl14 -l
>> +fcntl14_02_64 fcntl14_64 -l
> I would slightly prefer having a .test_variants than adding a command
> line options.
We can make it.
>
>> +#define CHECK_EQ_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS, FAILED) do {\
>> +	TYPE tst_tmp_a__ = VAL_A; \
>> +	TYPE tst_tmp_b__ = VAL_B; \
>> +	if (tst_tmp_a__ != tst_tmp_b__) { \
>> +		tst_res(TFAIL, \
>> +			SVAL_A " == " SVAL_B " (" PFS ")", tst_tmp_a__); \
>> +			*FAILED = 1; \
>> +	} \
>> +} while (0)
>> +
>> +#define CHECK_EQ_SILENT(VAL_A, VAL_B, FAILED) \
>> +		CHECK_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli", FAILED)
> Maybe this should go to the tst_test_macros.h?
I don't know, is a silent version of EQ_LI really needed? It's a 
particular use case, where also *FAILED is set, so I don't know...
>
>> +struct file_conf {
>> +	short type;
>> +	short whence;
>> +	long start;
>> +	long len;
>>   };
>>   
>> -static testcase *thiscase;
>> +struct testcase {
>> +	struct file_conf parent;           /* parent parameters for fcntl() */
>> +	struct file_conf child;            /* child parameters for fcntl() */
>> +	short blocking;                    /* blocking/non-blocking flag */
>> +	long pos;                          /* starting file position */
>> +};
>> +
>> +struct tc_results {
>> +	int num_pass;
>> +	int last_failed;
>> +};
>> +
>> +static const char filepath[] = "unlocked.txt";
>> +static const char filedata[] = "Here some bytes!";
>>   static struct flock flock;
>> -static int parent, child, status, fail = 0;
>> -static int got1 = 0;
>> -static int fd;
>> -static int test;
>> -static char tmpname[40];
>> +static char *str_op_nums;
>> +static char *locking_file;
>> +static int op_nums = 5000;
>> +static int file_mode = 0777;
>> +static struct tc_results *results;
>>   
>> -#define FILEDATA	"ten bytes!"
>> +static void dochild(struct testcase *tc, const int fd, const pid_t parent_pid)
>> +{
>> +	results->last_failed = 0;
>>   
>> -void catch1(int sig);
>> -void catch_alarm(int sig);
>> +	flock.l_type = tc->child.type;
>> +	flock.l_whence = tc->child.whence;
>> +	flock.l_start = tc->child.start;
>> +	flock.l_len = tc->child.len;
>> +	flock.l_pid = 0;
>>   
>> -char *TCID = "fcntl14";
>> -int TST_TOTAL = 1;
>> -int NO_NFS = 1;
>> +	SAFE_FCNTL(fd, F_GETLK, &flock);
>>   
>> -void cleanup(void)
>> -{
>> -	tst_rmdir();
>> -}
>> +	if (tc->blocking) {
>> +		tst_res(TDEBUG, "Child: expecting blocked file by parent");
>>   
>> -void setup(void)
>> -{
>> -	struct sigaction act;
>> -
>> -	tst_sig(FORK, DEF_HANDLER, cleanup);
>> -	signal(SIGHUP, SIG_IGN);
>> -	umask(0);
>> -	TEST_PAUSE;
>> -	tst_tmpdir();
>> -	parent = getpid();
>> -
>> -	sprintf(tmpname, "fcntl2.%d", parent);
>> -
>> -	/* setup signal handler for signal from child */
>> -	memset(&act, 0, sizeof(act));
>> -	act.sa_handler = catch1;
>> -	sigemptyset(&act.sa_mask);
>> -	sigaddset(&act.sa_mask, SIGUSR1);
>> -	if ((sigaction(SIGUSR1, &act, NULL)) < 0) {
>> -		tst_resm(TFAIL, "SIGUSR1 signal setup failed, errno = %d",
>> -			 errno);
>> -		cleanup();
>> -	}
>> +		CHECK_EQ_SILENT(flock.l_pid, parent_pid, &results->last_failed);
>> +		if (results->last_failed)
>> +			return;
>>   
>> -	memset(&act, 0, sizeof(act));
>> -	act.sa_handler = catch_alarm;
>> -	sigemptyset(&act.sa_mask);
>> -	sigaddset(&act.sa_mask, SIGALRM);
>> -	if ((sigaction(SIGALRM, &act, NULL)) < 0) {
>> -		tst_resm(TFAIL, "SIGALRM signal setup failed");
>> -		cleanup();
>> -	}
>> -}
>> +		CHECK_EQ_SILENT(flock.l_type, tc->parent.type, &results->last_failed);
>> +		if (results->last_failed)
>> +			return;
>>   
>> -void wake_parent(void)
>> -{
>> -	if ((kill(parent, SIGUSR1)) < 0) {
>> -		tst_resm(TFAIL, "Attempt to send signal to parent " "failed");
>> -		tst_resm(TFAIL, "Test case %d, errno = %d", test + 1, errno);
>> -		fail = 1;
>> +		flock.l_type = tc->child.type;
>> +		flock.l_whence = tc->child.whence;
>> +		flock.l_start = tc->child.start;
>> +		flock.l_len = tc->child.len;
>> +		flock.l_pid = 0;
>> +
>> +		TST_EXP_FAIL_SILENT(fcntl(fd, F_SETLK, &flock), EWOULDBLOCK);
>> +		if (TST_RET != -1)
>> +			results->last_failed = 1;
>> +	} else {
>> +		tst_res(TDEBUG, "Child: expecting no blocking errors");
>> +
>> +		CHECK_EQ_SILENT(flock.l_type, F_UNLCK, &results->last_failed);
>> +		if (results->last_failed)
>> +			return;
>> +
>> +		CHECK_EQ_SILENT(flock.l_whence, tc->child.whence, &results->last_failed);
>> +		if (results->last_failed)
>> +			return;
>> +
>> +		CHECK_EQ_SILENT(flock.l_start, tc->child.start, &results->last_failed);
>> +		if (results->last_failed)
>> +			return;
>> +
>> +		CHECK_EQ_SILENT(flock.l_len, tc->child.len, &results->last_failed);
>> +		if (results->last_failed)
>> +			return;
>> +
>> +		CHECK_EQ_SILENT(flock.l_pid, 0, &results->last_failed);
>> +		if (results->last_failed)
>> +			return;
> Why do we have to exit after each failed check here? I would just a
> bunch of the checks here without the returns. All that we need is to
> make sure the last_failed is set if child fails so that parent can
> detect it.
>
>
>> +	/* set the initial parent lock on the file */
>> +	flock.l_type = tc->parent.type;
>> +	flock.l_whence = tc->parent.whence;
>> +	flock.l_start = tc->parent.start;
>> +	flock.l_len = tc->parent.len;
>>   	flock.l_pid = 0;
> I wonder if it would be better to use struct flock in the tc directory
> so that we could just assign the structure here. I.e. we would do here
> just:
>
> 	struct flock flock = tc->flock;
>
> 	flock.l_pid = 0;
>
>
>> +	flock.l_type = F_UNLCK;
>> +	flock.l_whence = 0;
>> +	flock.l_start = 0;
>> +	flock.l_len = 0;
>>   	flock.l_pid = 0;
>>   
>> +	SAFE_FCNTL(fd, F_SETLK, &flock);
>> +	SAFE_CLOSE(fd);
> Why bother with unlocking? Aren't the locks dropped when we close the fd
> here anyways?
>
>> +}
>> +
>> +static void genconf(struct file_conf *conf, const int size, const long pos)
>> +{
>> +	conf->type = rand() % 2 ? F_RDLCK : F_WRLCK;
>> +	conf->whence = SEEK_CUR;
>> +
>> +	if (pos > 0 && (rand() % 2)) {
>> +		conf->start = -(rand() % pos);
>> +		conf->len = rand() % (size + conf->start - 1) + 1;
>>   	} else {
>> -		exit(0);
>> +		conf->start = rand() % (size - 1);
>> +		conf->len = rand() % (size - conf->start - 1) + 1;
>>   	}
>>   }
> We have a file in which we seek at pos offset and then need a start
> relative to that and lenght so that it fits into the file.
>
> The start should be just the whole available range, which is random
> offset moved back by pos. Then we need a size which is limited to
> whatever is left in the file and is not relative. So if I'm not mistaken
> we need what is in the else branch but we have to move the start by pos
> at the end, i.e. the whole start and len generation should look like:
>
> 	conf->start = rand() % (size - 1);
> 	conf->len = rand() % (size - conf->start - 1) + 1;
> 	conf->start -= pos;
>
> That way we generate a valid part of the file and make it realtive to
> the pos at the end.
>
>> -void run_test(int file_flag, int file_mode, int seek, int start, int end)
>> +static short fcntl_overlap(
>> +	struct file_conf *parent,
>> +	struct file_conf *child,
>> +	const long pos)
>>   {
>> +	long start[2];
>> +	long length[2];
>> +	short overlap = 0;
>> +
>> +	if (parent->start > child->start) {
>> +		start[0] = pos + child->start;
>> +		start[1] = pos + parent->start;
>> +		length[0] = child->len;
>> +		length[1] = parent->len;
>> +	} else {
>> +		start[0] = pos + parent->start;
>> +		start[1] = pos + child->start;
>> +		length[0] = parent->len;
>> +		length[1] = child->len;
>>   	}
> If you add pos to both of the starts you just move the two ranges by the
> same amount. So the end result is the same regardless of if you add it
> or not.
>
>> +
>> +	overlap = start[0] <= start[1] && start[1] < (start[0] + length[0]);
> Isn't the start[0] <= start[1] because we made it so? We set the
> start[0] to the smaller of the two. So all we need to do is to check
> that that start[0] + lenght[0] does not end before the start[1] which is
> the second part of the equation.
>
> And we do not use lenght[1] either. So maybe we just need:
>
> 	if (child->start < parent->start)
> 		overlap = parent->start < (child->start + child->len);
> 	else
> 		overlap = child->start < (parent->start + parent->len);
>
>> +	if (overlap)
>> +		tst_res(TDEBUG, "child/parent fcntl() configurations overlap");
>> +
>> +	return overlap;
>>   }
>>   
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
