From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 Feb 2020 16:57:03 +0100
Subject: [LTP] [RFC PATCH 1/1] autotools: Move simple definitions out of
 m4/* to configure.ac
In-Reply-To: <e6f7f611-7c2e-04cb-afd9-e11c4423dc3f@cn.fujitsu.com>
References: <20200130110753.20459-1-pvorel@suse.cz>
 <e6f7f611-7c2e-04cb-afd9-e11c4423dc3f@cn.fujitsu.com>
Message-ID: <20200204155703.GA16838@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > TODO
> > on m4 files (in order to use simple declarations which allows to move them to configure.ac):
> > * verify and delete if they're old enough (e.g. ltp-ptrace.m4 and ltp-taskstats.m4 reference 2008, kernel commit 016ae219 from v2.6.27; ltp-signalfd.m4)
> ltp-prctl.m4 for PR_CAPBSET_DROP and PR_CAPBSET_READ also can be removed
> because it introduced since 2.6.25(it is old enough).
OK, that might go next time.

> IMO, move all simple definitions to configure.ac will make this file mess
> likce old .gitnore file. I perfer to add function or header or macro but not
> include struct in configure.ac.
I think .gitignore files are different because it's content cannot be duplicated
when they're split, but m4/ repeated some checks.
+ we already started to move configuration into configure.ac before
(AC_CHECK_HEADERS and AC_CHECK_FUNCS).
IMHO it's easier to search/work with single file than in many files with very little
content.

Kind regards,
Petr
