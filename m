Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36307C4332F
	for <ltp@archiver.kernel.org>; Wed, 13 Dec 2023 23:11:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 063D83CF558
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 00:11:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C47333CE5B8
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 00:11:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AED04603585
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 00:11:23 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F97C1F789;
 Wed, 13 Dec 2023 23:11:21 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E3F1391D;
 Wed, 13 Dec 2023 23:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id um8kKRQ6emWwPAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 13 Dec 2023 23:11:16 +0000
Date: Thu, 14 Dec 2023 00:11:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231213231115.GA768049@pevik>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-3-pvorel@suse.cz> <ZXoC6LUE8ePDPRIU@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXoC6LUE8ePDPRIU@rei>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0F97C1F789
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] lib: Add support for TDEBUG tst_res() flag
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > diff --git a/lib/tst_res.c b/lib/tst_res.c
> > index e0896eb05..5125001f7 100644
> > --- a/lib/tst_res.c
> > +++ b/lib/tst_res.c
> > @@ -157,6 +157,7 @@ const char *strttype(int ttype)
> >  		PAIR(TCONF)
> >  		PAIR(TWARN)
> >  		PAIR(TINFO)
> > +		PAIR(TDEBUG)
> >  	};

> >  	PAIR_LOOKUP(ttype_pairs, TTYPE_RESULT(ttype));
> > @@ -174,8 +175,10 @@ static void tst_res__(const char *file, const int lineno, int ttype,
> >  	int len = 0;
> >  	int ttype_result = TTYPE_RESULT(ttype);

> > -	if (file && (ttype_result != TPASS && ttype_result != TINFO))
> > +	if (file && (ttype_result != TPASS && ttype_result != TINFO &&
> > +		     ttype_result != TDEBUG))
> >  		len = sprintf(tmesg, "%s:%d: ", file, lineno);
> > +
> >  	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG - len);

> >  	/*
> > @@ -193,7 +196,7 @@ static void tst_res__(const char *file, const int lineno, int ttype,
> >  	 * Set the test case number and print the results, depending on the
> >  	 * display type.
> >  	 */
> > -	if (ttype_result == TWARN || ttype_result == TINFO) {
> > +	if (ttype_result == TWARN || ttype_result == TINFO || ttype_result == TDEBUG) {
> >  		tst_print(TCID, 0, ttype, tmesg);
> >  	} else {
> >  		if (tst_count < 0)
> > @@ -411,7 +414,7 @@ void tst_exit(void)

> >  	tst_old_flush();

> > -	T_exitval &= ~TINFO;
> > +	T_exitval &= ~(TINFO | TDEBUG);

> >  	if (T_exitval == TCONF && passed_cnt)
> >  		T_exitval &= ~TCONF;

> I woudln't add it to the old library. None of the old tests uses it so
> there is no reason to export it there.

> I suppose that we just abort if we get this flag in old library:

> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index e0896eb05..e87918ed1 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -174,6 +174,11 @@ static void tst_res__(const char *file, const int lineno, int ttype,
>         int len = 0;
>         int ttype_result = TTYPE_RESULT(ttype);

> +       if (ttype_result == TDEBUG) {
> +               printf("%s: %i: TDEBUG is not supported\n", __func__, __LINE__);
> +               abort();
> +       }
> +

> What do you think?

Makes sense, thanks!

> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index c2f8f503f..f5c87ed9e 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -60,6 +60,7 @@ static pid_t main_pid, lib_pid;
> >  static int mntpoint_mounted;
> >  static int ovl_mounted;
> >  static struct timespec tst_start_time; /* valid only for test pid */
> > +static int tdebug;

> >  struct results {
> >  	int passed;
> > @@ -224,6 +225,9 @@ static void print_result(const char *file, const int lineno, int ttype,
> >  	case TINFO:
> >  		res = "TINFO";
> >  	break;
> > +	case TDEBUG:
> > +		res = "TDEBUG";
> > +	break;
> >  	default:
> >  		tst_brk(TBROK, "Invalid ttype value %i", ttype);
> >  		abort();
> > @@ -352,6 +356,9 @@ void tst_res_(const char *file, const int lineno, int ttype,
> >  {
> >  	va_list va;

> > +	if (ttype == TDEBUG && !tdebug)
> > +		return;
> > +
> >  	va_start(va, fmt);
> >  	tst_vres_(file, lineno, ttype, fmt, va);
> >  	va_end(va);
> > @@ -511,6 +518,7 @@ static struct option {
> >  	{"h",  "-h       Prints this help"},
> >  	{"i:", "-i n     Execute test n times"},
> >  	{"I:", "-I x     Execute test for n seconds"},
> > +	{"v",  "-v       Prints debug information"},

> Maybe this should now be called -d since we call it TDEBUG and that will
> avoid having a bit confusing parameters with both -v and -V used.

Yes, I didn't like the flag name does not correspond to the option.
I previously wrote that more tests use -d for something else:

$ git grep '"d:"' $(git grep -l tst_option)
testcases/kernel/fs/read_all/read_all.c:                {"d:", &root_dir,
testcases/kernel/io/ltp-aiodio/aio-stress.c:            { "d:", &str_depth, "Number of pending aio requests for each file (default 64)" },
testcases/network/netstress/netstress.c:                {"d:", &rpath, "Path to file where result is saved"},
testcases/network/nfs/nfs_stress/nfs05_make_tree.c:     {"d:", &d_arg, "Number of subdirs to generate, default: 100"},
testcases/network/stress/route/route-change-netlink.c:          {"d:", &d_opt, "Interface to work on (mandatory)"},

Hopefully all could be changed to -D in separate commits.

$ git grep '"d"' $(git grep -l tst_option)
Also some other tests already use it as debug, this will be trivial to convert
to delete it and use TDEBUG (will have to be in the same commit which introduces
the flag or I would have to remove the debug and print always in commit before
introducing the flag):

testcases/kernel/mem/mmapstress/mmapstress01.c:         {"d", &debug, "Enable debug output"},
testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c:       {"d", &debug, "Enable debug"},
testcases/kernel/syscalls/mq_notify/mq_notify01.c:              {"d", &str_debug, "Print debug messages"},

Also, shell API uses -d

$ git grep "TST_OPTS=.*d"
testcases/network/virt/geneve01.sh:TST_OPTS="hi:d:"
testcases/network/virt/geneve02.sh:TST_OPTS="hi:d:"
testcases/network/virt/vxlan01.sh:TST_OPTS="hi:d:"
testcases/network/virt/vxlan02.sh:TST_OPTS="hi:d:"
testcases/network/virt/vxlan03.sh:TST_OPTS="hi:d:"
testcases/network/virt/vxlan04.sh:TST_OPTS="hi:d:"

=> all for VxLAN destination address in testcases/network/virt/virt_lib.sh
Again, it could be changed to -D in separate commits.

Alternative to all this work would be to have TVERBOSE. But I'm ok to do the job
if you like TDEBUG.

> >  	{"V",  "-V       Prints LTP version"},
> >  	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
> >  };
> > @@ -692,6 +700,10 @@ static void parse_opts(int argc, char *argv[])
> >  			else
> >  				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
> >  		break;
> > +		case 'v':
> > +			tdebug = 1;
> > +			tst_res(TINFO, "Run with -v, printing debug info");
>                                            ^
> 					   Maybe just "Enabling debug info"

+1

If none objects, I hopefully send patch this week.

Kind regards,
Petr

> > +		break;
> >  		case 'V':
> >  			fprintf(stderr, "LTP version: " LTP_VERSION "\n");
> >  			exit(0);
> > -- 
> > 2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
