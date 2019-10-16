From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Oct 2019 15:21:39 +0200
Subject: [LTP] [PATCH 2/2] testcases/kernel: Add linux git and CVE tags
In-Reply-To: <20191015095225.GA14021@rei>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-3-chrubis@suse.cz>
 <CAEemH2f0ZXYEwsvcxWhdE33EzLJKr=EeeG91Uq_8rBZOsx57NQ@mail.gmail.com>
 <20191015095225.GA14021@rei>
Message-ID: <20191016132139.GA4526@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > +       .tags = (const struct tst_tag[]) {
> > > +               {"linux-git", "4291086b1f08"},
> > > +               {"CVE", "2014-0196"},
> > > +               {}

> > Some of the tests use {NULL, NULL} to terminate tag array but some not,
> > maybe we need to keep consistent in usage.

> I guess I missed some when I was converting {NULL, NULL} to just {}. I
> will fix that in v2.
+1

Nice work, thanks :).
Reviewed-by: Petr Vorel <pvorel@suse.cz>

nit: I don't that much blank lines, I'd prefer more compact output:

OPTIONS
-h       Prints this help
-i n     Execute test n times
-I x     Execute test for n seconds
-C ARG   Run child process with ARG arguments (used internally)

TAGS
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c461cb727d1
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-2618

Kind regards,
Petr
