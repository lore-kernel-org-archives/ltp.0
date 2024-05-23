Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B667C25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 14:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9048C3D018E
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 16:38:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B8023D0116
 for <ltp@lists.linux.it>; Thu, 23 May 2024 16:37:48 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E769F1415303
 for <ltp@lists.linux.it>; Thu, 23 May 2024 16:37:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7986522843;
 Thu, 23 May 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7076E13A6B;
 Thu, 23 May 2024 14:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ygQXG7pUT2avYQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 23 May 2024 14:37:46 +0000
Message-ID: <bdcd318e-d71d-420b-bf96-e2571831078e@suse.cz>
Date: Thu, 23 May 2024 16:37:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20240523133132.13978-1-chrubis@suse.cz>
 <20240523133132.13978-3-chrubis@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240523133132.13978-3-chrubis@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7986522843
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/msgstress01: Fix timeouts
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
for both patches:
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 23. 05. 24 15:31, Cyril Hrubis wrote:
> Make the test exit if runtime has been exhausted before we finished the
> requested amount of iterations.
> 
> For that to happen we let the main test process to loop while checking
> the runtime and set the stop flag if runtime was exhausted. We also need
> to separte the stop and fail flag and add counter for finished children.
> 
> Also if we exhaust our runtime during the initial fork phase we print a
> warning, since we hardly did a meaningful testing in that case.
> 
> The changes can be tested with -I parameter, e.g. -I 5 should trigger
> the TWARN message and you should be able to get the test to stop in the
> message sending phase with larger -I value.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   .../syscalls/ipc/msgstress/msgstress01.c      | 53 ++++++++++++++++---
>   1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> index 62ffcf63b..fb1d4263d 100644
> --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> @@ -50,6 +50,9 @@ static char *str_num_iterations;
>   static int num_messages = 1000;
>   static int num_iterations = MAXNREPS;
>   static volatile int *stop;
> +static volatile int *fail;
> +static int *finished;
> +static int *flags;
>   
>   static int get_used_sysvipc(void)
>   {
> @@ -77,6 +80,10 @@ static void reset_messages(void)
>   
>   	for (int i = 0; i < num_messages; i++)
>   		ipc_data[i].id = -1;
> +
> +	*stop = 0;
> +	*fail = 0;
> +	*finished = 0;
>   }
>   
>   static int create_message(const int id)
> @@ -112,6 +119,8 @@ static void writer(const int id, const int pos)
>   			tst_brk(TBROK | TERRNO, "msgsnd() failed");
>   		}
>   	}
> +
> +	tst_atomic_inc(finished);
>   }
>   
>   static void reader(const int id, const int pos)
> @@ -138,6 +147,7 @@ static void reader(const int id, const int pos)
>   			tst_res(TFAIL, "Received the wrong message type");
>   
>   			*stop = 1;
> +			*fail = 1;
>   			return;
>   		}
>   
> @@ -145,6 +155,7 @@ static void reader(const int id, const int pos)
>   			tst_res(TFAIL, "Received the wrong message data length");
>   
>   			*stop = 1;
> +			*fail = 1;
>   			return;
>   		}
>   
> @@ -155,6 +166,7 @@ static void reader(const int id, const int pos)
>   					buff->msg.data.pbytes[i]);
>   
>   				*stop = 1;
> +				*fail = 1;
>   				return;
>   			}
>   		}
> @@ -163,6 +175,8 @@ static void reader(const int id, const int pos)
>   		tst_res(TDEBUG, "msg_recv.type = %ld", msg_recv.type);
>   		tst_res(TDEBUG, "msg_recv.data.len = %d", msg_recv.data.len);
>   	}
> +
> +	tst_atomic_inc(finished);
>   }
>   
>   static void remove_queues(void)
> @@ -196,12 +210,37 @@ static void run(void)
>   
>   		if (*stop)
>   			break;
> +
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TWARN, "Out of runtime during forking...");
> +			*stop = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!(*stop))
> +		tst_res(TINFO, "All processes running.");
> +
> +	for (;;) {
> +		if (tst_atomic_load(finished) == 2 * num_messages)
> +			break;
> +
> +		if (*stop)
> +			break;
> +
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TINFO, "Out of runtime, stopping processes...");
> +			*stop = 1;
> +			break;
> +		}
> +
> +		sleep(1);
>   	}
>   
>   	tst_reap_children();
>   	remove_queues();
>   
> -	if (!(*stop))
> +	if (!(*fail))
>   		tst_res(TPASS, "Test passed. All messages have been received");
>   }
>   
> @@ -242,14 +281,16 @@ static void setup(void)
>   		MAP_SHARED | MAP_ANONYMOUS,
>   		-1, 0);
>   
> -	stop = SAFE_MMAP(
> +	flags = SAFE_MMAP(
>   		NULL,
> -		sizeof(int),
> +		sizeof(int) * 3,
>   		PROT_READ | PROT_WRITE,
>   		MAP_SHARED | MAP_ANONYMOUS,
>   		-1, 0);
>   
> -	reset_messages();
> +	stop = &flags[0];
> +	fail = &flags[1];
> +	finished = &flags[2];
>   }
>   
>   static void cleanup(void)
> @@ -260,7 +301,7 @@ static void cleanup(void)
>   	remove_queues();
>   
>   	SAFE_MUNMAP(ipc_data, sizeof(struct sysv_data) * num_messages);
> -	SAFE_MUNMAP((void *)stop, sizeof(int));
> +	SAFE_MUNMAP(flags, sizeof(int) * 3);
>   }
>   
>   static struct tst_test test = {
> @@ -271,7 +312,7 @@ static struct tst_test test = {
>   	.max_runtime = 180,
>   	.options = (struct tst_option[]) {
>   		{"n:", &str_num_messages, "Number of messages to send (default: 1000)"},
> -		{"l:", &str_num_iterations, "Number iterations per message (default: 10000)"},
> +		{"l:", &str_num_iterations, "Number iterations per message (default: " TST_TO_STR(MAXNREPS) ")"},
>   		{},
>   	},
>   };

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
