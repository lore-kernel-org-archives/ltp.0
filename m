From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Sep 2021 16:46:33 +0200
Subject: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
In-Reply-To: <3b789dc4-5232-a6d6-d864-7f75c5a0a030@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de>
 <3b789dc4-5232-a6d6-d864-7f75c5a0a030@suse.cz>
Message-ID: <YT9kSW+oEBJVSZkL@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 09. 09. 21 18:32, pvorel wrote:
> >> -??? if (getpwnam("bin") == NULL) {
> >> -??????? tst_brkm(TBROK, NULL, "bin must be a valid user.");
> >> +??? if (TST_ERR != tc->exp_errno) {
> > nit: checkpatch complains (TST_ERR should be second)

> checkpatch.pl wrongly assumes that TST_ERR is a constant.
Yep, variable named upper case is confusing for perl script.
Sorry for not detecting it myself. I suppose we should whitelist
TST_{ERR,PASS,RET} from these checks in our vendored checkpatch.pl.

Kind regards,
Petr
