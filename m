From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Sep 2021 07:06:51 +0200
Subject: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
In-Reply-To: <YT9laHIulnmtBSgK@yuki>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de>
 <3b789dc4-5232-a6d6-d864-7f75c5a0a030@suse.cz>
 <YT9laHIulnmtBSgK@yuki>
Message-ID: <YUAt6/LvtDTVENJB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > >> -?????? if (getpwnam("bin") == NULL) {
> > >> -?????????????? tst_brkm(TBROK, NULL, "bin must be a valid user.");
> > >> +?????? if (TST_ERR != tc->exp_errno) {
> > > nit: checkpatch complains (TST_ERR should be second)

> > checkpatch.pl wrongly assumes that TST_ERR is a constant.

> Good catch, I guess that we will have to patch checkpatch to ignore
> macros that start with TST_, what about?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 88cb294dc..87572b2f4 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5462,7 +5462,9 @@ sub process {
>                         my $comp = $3;
>                         my $to = $4;
>                         my $newcomp = $comp;
> -                       if ($lead !~ /(?:$Operators|\.)\s*$/ &&
> +
> +                       if ($const !~ /^\QTST_/ &&
> +                           $lead !~ /(?:$Operators|\.)\s*$/ &&
>                             $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
>                             WARN("CONSTANT_COMPARISON",
>                                  "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&

Yep, that works, thanks!

Kind regards,
Petr
