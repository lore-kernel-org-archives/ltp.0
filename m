From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Oct 2019 11:54:05 +0200
Subject: [LTP] [PATCH 1/2] lib: Add support for test tags
In-Reply-To: <CAEemH2e+xD2OCFZs14ejmppKu2rLXKsr16Vfc3tqw-YoesWuJg@mail.gmail.com>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-2-chrubis@suse.cz>
 <CAEemH2e+xD2OCFZs14ejmppKu2rLXKsr16Vfc3tqw-YoesWuJg@mail.gmail.com>
Message-ID: <20191015095405.GB14021@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void print_test_info(void)
> >
> 
> print_test_info sounds like general information for the test, maybe
> print_tags() is a better/precise name?

I named it as such in a case that we will add anything else there, but I
do not have a strong opinion, I can change that if you insist.

> > +static void print_failure_hints(void)
> > +{
> > +       unsigned int i;
> > +       const struct tst_tag *tags = tst_test->tags;
> > +
> > +       if (!tags)
> > +               return;
> > +
> > +       for (i = 0; tags[i].name; i++) {
> > +               if (!strcmp(tags[i].name, "linux-git")) {
> > +                       printf("\n");
> > +                       print_colored("HINT: ");
> 
> +                       printf("This is a regression test for linux kernel,
> > see commit:\n\n"
> > +                              LINUX_GIT_URL "%s\n", tags[i].value);
> >
> 
> This sentence 'HINT: This is a ...' will be printed many times if there are
> many commits in tags, I prefer to see only once in front of these
> linux-kernel links.

Good catch, I will do something about this.

-- 
Cyril Hrubis
chrubis@suse.cz
