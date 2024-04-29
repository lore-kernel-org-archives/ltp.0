Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70059C04FFE
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 14:43:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C0D83C8658
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 16:43:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 550473C07A6
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 16:42:59 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5DEB81A00EAB
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 16:42:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3ADA1F442;
 Mon, 29 Apr 2024 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714401777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPzLjGynEeiptnKYvtfIFaQSbkJf/q66niEchMrsccw=;
 b=Pnp091WyXkQArtdVvMSrwCtIQe/7BPJB09gR0rxKDmdTUBkIH6Fi/Z0RdbOTKlxYjtAupm
 AkehNQyNFzCI9nJNeJyEZPgubnY16Fa+SvaG9ofDb3+cSwV5U378qux4Kp2GK1U7RU+kNm
 ug3q+Hbt9kY5ADqj976nHArlcMnha7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714401777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPzLjGynEeiptnKYvtfIFaQSbkJf/q66niEchMrsccw=;
 b=0wykWfdNiGs+uwnv2VwV6jqOt5qXxrbPcLe3llHFOD2eJ8wMSWXLwWter7JDNjsbBMRJwt
 hkZ2ctIZ1OwVE2Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714401777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPzLjGynEeiptnKYvtfIFaQSbkJf/q66niEchMrsccw=;
 b=Pnp091WyXkQArtdVvMSrwCtIQe/7BPJB09gR0rxKDmdTUBkIH6Fi/Z0RdbOTKlxYjtAupm
 AkehNQyNFzCI9nJNeJyEZPgubnY16Fa+SvaG9ofDb3+cSwV5U378qux4Kp2GK1U7RU+kNm
 ug3q+Hbt9kY5ADqj976nHArlcMnha7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714401777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPzLjGynEeiptnKYvtfIFaQSbkJf/q66niEchMrsccw=;
 b=0wykWfdNiGs+uwnv2VwV6jqOt5qXxrbPcLe3llHFOD2eJ8wMSWXLwWter7JDNjsbBMRJwt
 hkZ2ctIZ1OwVE2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5AC138A7;
 Mon, 29 Apr 2024 14:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I0WfIfGxL2bWDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Apr 2024 14:42:57 +0000
Date: Mon, 29 Apr 2024 16:42:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Zi-xur-p2H4kWjjQ@yuki>
References: <20240422053611.3581473-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240422053611.3581473-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kallsyms01: Utilize ksymbol table for
 unauthorized address access
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
> +struct kallsym {
> +	unsigned long addr;
> +	char type;
> +	char name[128];
> +};
> +
> +struct ksymstbl {
> +	struct kallsym symbol;
> +	struct ksymstbl *next;
> +};
> +
> +static struct ksymstbl *sym_table;
> +static unsigned int nr_symbols;
> +static sigjmp_buf jmpbuf;
> +volatile sig_atomic_t segv_caught = 0;
> +
> +static void segv_handler(int sig)
> +{
> +	if (sig == SIGSEGV)
> +		segv_caught++;
> +	else
> +		tst_res(TFAIL, "Unexpected signal %s", strsignal(sig));
> +
> +	siglongjmp(jmpbuf, 1);
> +}
> +
> +static struct ksymstbl *read_kallsyms(unsigned int *nr_symbols)
> +{
> +	FILE *stream;
> +	char *line = NULL;
> +	size_t len = 0;
> +	unsigned int nr_syms = 0;
> +	struct ksymstbl *head, *item, *i;
> +
> +	item = head = calloc(1, sizeof(*head));
> +	if (head == NULL)
> +		goto out;
> +
> +	stream = SAFE_FOPEN("/proc/kallsyms", "r");
> +
> +	while (getline(&line, &len, stream) != -1) {
> +		i = item;
> +
> +		sscanf(line, "%lx %c %s",
> +				&i->symbol.addr, &i->symbol.type, i->symbol.name);
> +
> +		item = calloc(1, sizeof(*i));
> +		if (item == NULL)
> +			tst_brk(TBROK, "In calloc[]");

We should add SAFE_CALLOC() to the test library. Or maybe
SAFE_ZEROED_MALLOC() because we actually mis-use the calloc() here to
get the memory initialized to zero.

Also it may be actually faster to read the file twice, first time only
to count the addresses and allocate an array of the symbols instead.
That way we avoid all the allocation and list traversal.

static unsigned int read_kallsyms(struct ksymbtl *table, unsigned int table_size)
{
	FILE *stream = SAFE_FOPEN("/proc/kallsyms", "r");
	unsigned int nr_syms = 0;

	while (getline(&line, &len, stream) != -1) {

		if (table && nr_syms < table_size) {
			sscanf(line, "%lx %c %s",
			       &table[nr_syms].addr,
			       ...);
		}

		nr_syms++;
	}

	return nr_syms;
}


static void setup(void)
{
	unsigned int nr_syms;

	nr_syms = read_kallsyms(NULL, 0);

	sym_table = SAFE_MALLOC(sizeof(*sym_table) * nr_syms);

	if (nr_syms != read_kallsyms(sym_table, nr_syms))
		tst_res(TWARN, "/proc/kallsyms changed size!?");
}

> +		i->next = item;
> +		nr_syms += 1;
> +	}
> +
> +	*nr_symbols = nr_syms;
> +	SAFE_FCLOSE(stream);
> +out:
> +	return head;
> +}
> +
> +static void setup(void)
> +{
> +	sym_table = read_kallsyms(&nr_symbols);
> +	if (!sym_table)
> +		tst_brk(TBROK, "Failed to read kernel symbols");
> +}
> +
> +static void access_ksymbols_address(struct ksymstbl *sym_table)
> +{
> +	if (sigsetjmp(jmpbuf, 1) == 0) {
> +		*(volatile unsigned long *)sym_table->symbol.addr = 0;
> +
> +		tst_res(TFAIL, "Successfully accessed kernel addr 0x%lx (%s)",
> +			sym_table->symbol.addr, sym_table->symbol.name);
> +	}
> +
> +}
> +
> +static void test_access_kernel_address(void)
> +{
> +	struct ksymstbl *current;
> +	struct sigaction sa;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler = segv_handler;
> +	sigaction(SIGSEGV, &sa, NULL);
> +
> +	current = sym_table;
> +	while (current->next != NULL) {
> +		access_ksymbols_address(current);
> +		current = current->next;
> +	}
> +
> +	if (segv_caught == (sig_atomic_t)nr_symbols)
> +		tst_res(TPASS, "Caught %d times SIGSEGV in access ksymbols addr", segv_caught);
> +}
> +
> +static void cleanup(void)
> +{
> +	while (sym_table != NULL) {
> +		struct ksymstbl *temp = sym_table;
> +		sym_table = sym_table->next;
> +		free(temp);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.max_runtime = 60,
> +	.test_all = test_access_kernel_address,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
