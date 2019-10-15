From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Oct 2019 11:52:25 +0200
Subject: [LTP] [PATCH 2/2] testcases/kernel: Add linux git and CVE tags
In-Reply-To: <CAEemH2f0ZXYEwsvcxWhdE33EzLJKr=EeeG91Uq_8rBZOsx57NQ@mail.gmail.com>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-3-chrubis@suse.cz>
 <CAEemH2f0ZXYEwsvcxWhdE33EzLJKr=EeeG91Uq_8rBZOsx57NQ@mail.gmail.com>
Message-ID: <20191015095225.GA14021@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
> > index 6997fffe4..012cbb7cd 100644
> > --- a/testcases/cve/cve-2014-0196.c
> > +++ b/testcases/cve/cve-2014-0196.c
> > @@ -141,4 +141,9 @@ static struct tst_test test = {
> >         .setup = setup,
> >         .cleanup = cleanup,
> >         .test_all = run,
> > +       .tags = (const struct tst_tag[]) {
> > +               {"linux-git", "4291086b1f08"},
> > +               {"CVE", "2014-0196"},
> > +               {}
> >
> 
> Some of the tests use {NULL, NULL} to terminate tag array but some not,
> maybe we need to keep consistent in usage.

I guess I missed some when I was converting {NULL, NULL} to just {}. I
will fix that in v2.

-- 
Cyril Hrubis
chrubis@suse.cz
