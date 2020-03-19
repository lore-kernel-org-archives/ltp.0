From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Mar 2020 23:00:06 +0100
Subject: [LTP] [PATCH v2 5/9] syscalls/sysinfo03: Add time namespace test
In-Reply-To: <CAEemH2f_Md7hkEWgLYABD+TLbDJvvR-aMfuuNqLNeyWSWK1EnQ@mail.gmail.com>
References: <20200318153801.3529-1-chrubis@suse.cz>
 <20200318153801.3529-6-chrubis@suse.cz>
 <CAEemH2f_Md7hkEWgLYABD+TLbDJvvR-aMfuuNqLNeyWSWK1EnQ@mail.gmail.com>
Message-ID: <20200319220006.GA29386@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static struct tst_test test = {
> > +       .tcnt = ARRAY_SIZE(offsets),
> > +       .test = verify_sysinfo,
> > +       .needs_root = 1,
> > +       .forks_child = 1,
> > +       .needs_kconfigs = (const char *[]) {
> > +               "CONFIG_TIME_NS=y"
> >
> 
> Shouldn't end with 'NULL' in kconfig struct?
> If not that will mislead arrary_len to recognise wrong number of arrry(cnt)
> and caused segmentation fault in test.
> 
> 
> 
> > +       }
> >
> 
> A comma is required here ^, otherwise it'd be failing in the build phase.
> 
> +       .tags = (const struct tst_tag[]) {
> > +               {"linux-git", "ecc421e05bab"},
> >
> 
> Ending with '{}' in tags struct?

Of course, thanks for catching that!

I will fix these before applying, if the patchset is acked otherwise.

-- 
Cyril Hrubis
chrubis@suse.cz
