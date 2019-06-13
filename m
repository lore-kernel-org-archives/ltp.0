From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Jun 2019 15:57:40 +0200
Subject: [LTP] [PATCH v3 2/3] lib: rename ltp_clone_malloc to
 ltp_clone_alloc
In-Reply-To: <CAEemH2f_oMYubEDLdOmhxrEguKkc+3smx682LF7D9uiwZ26OAQ@mail.gmail.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <fd8b05453a0c72f2810a53e49ca1dc9467d9dbf9.1560410182.git.jstancek@redhat.com>
 <CAEemH2f_oMYubEDLdOmhxrEguKkc+3smx682LF7D9uiwZ26OAQ@mail.gmail.com>
Message-ID: <20190613135740.GB29926@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > @@ -170,5 +170,5 @@ int ltp_clone_quick(unsigned long clone_flags, int
> > (*fn) (void *arg), void *arg)
> >  {
> >         size_t stack_size = getpagesize() * 6;
> >
> > -       return ltp_clone_malloc(clone_flags, fn, arg, stack_size);
> > +       return ltp_clone_alloc(clone_flags, fn, arg, stack_size);
> >  }
> >
> 
> There is another legacy problem maybe we need take care.
> 
> Any thought about how releasing the stack memory[1] after calling
> ltp_clone_quick() in a test?
> 
> [1] which allocated memory in ltp_clone_alloc().

Well, we can free the memory in ltp_clone_alloc() if the child runs in a
separate memory space, but if CLONE_VM was passed in flags there is no
way how to free the memory...

-- 
Cyril Hrubis
chrubis@suse.cz
