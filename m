From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Jun 2019 10:46:42 +0800
Subject: [LTP] [PATCH v3 2/3] lib: rename ltp_clone_malloc to
	ltp_clone_alloc
In-Reply-To: <20190613135740.GB29926@rei.lan>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <fd8b05453a0c72f2810a53e49ca1dc9467d9dbf9.1560410182.git.jstancek@redhat.com>
 <CAEemH2f_oMYubEDLdOmhxrEguKkc+3smx682LF7D9uiwZ26OAQ@mail.gmail.com>
 <20190613135740.GB29926@rei.lan>
Message-ID: <CAEemH2e7yfW3fd2kRFh-6tq8Y+sZeBvSB4Eu4JN6Htdo4_=K5g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 13, 2019 at 9:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > @@ -170,5 +170,5 @@ int ltp_clone_quick(unsigned long clone_flags, int
> > > (*fn) (void *arg), void *arg)
> > >  {
> > >         size_t stack_size = getpagesize() * 6;
> > >
> > > -       return ltp_clone_malloc(clone_flags, fn, arg, stack_size);
> > > +       return ltp_clone_alloc(clone_flags, fn, arg, stack_size);
> > >  }
> > >
> >
> > There is another legacy problem maybe we need take care.
> >
> > Any thought about how releasing the stack memory[1] after calling
> > ltp_clone_quick() in a test?
> >
> > [1] which allocated memory in ltp_clone_alloc().
>
> Well, we can free the memory in ltp_clone_alloc() if the child runs in a
> separate memory space, but if CLONE_VM was passed in flags there is no
> way how to free the memory...
>

A stupid way come up to my mind is just to export the stack as global
pointer and releasing in do_cleanup() if possible.

diff --git a/include/tst_clone.h b/include/tst_clone.h
index fd52097..c98eb44 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
diff --git a/include/tst_clone.h b/include/tst_clone.h
index fd52097..c98eb44 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -24,6 +24,8 @@
 #ifndef TST_CLONE_H__
 #define TST_CLONE_H__

+void *tst_clone_stack;
+
 /* Functions from lib/cloner.c */
 int ltp_clone(unsigned long flags, int (*fn)(void *arg), void *arg,
                size_t stack_size, void *stack);
diff --git a/lib/cloner.c b/lib/cloner.c
index 8469745..4534982 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -142,19 +142,17 @@ int
 ltp_clone_alloc(unsigned long clone_flags, int (*fn) (void *arg), void
*arg,
                 size_t stack_size)
 {
-       void *stack;
        int ret;
        int saved_errno;
-
-       stack = ltp_alloc_stack(stack_size);
-       if (stack == NULL)
+       tst_clone_stack = ltp_alloc_stack(stack_size);
+       if (tst_clone_stack == NULL)
                return -1;

-       ret = ltp_clone(clone_flags, fn, arg, stack_size, stack);
+       ret = ltp_clone(clone_flags, fn, arg, stack_size, tst_clone_stack);

        if (ret == -1) {
                saved_errno = errno;
-               free(stack);
+               free(tst_clone_stack);
                errno = saved_errno;
        }

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 95f389d..e96a9c7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -909,6 +909,9 @@ static void do_cleanup(void)
        if (mntpoint_mounted)
                tst_umount(tst_test->mntpoint);

+       if (tst_clone_stack)
+               free(tst_clone_stack);
+
        if (tst_test->needs_device && tdev.dev)
                tst_release_device(tdev.dev);

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190614/8e97e3c0/attachment-0001.html>
