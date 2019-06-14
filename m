From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 Jun 2019 17:24:28 +0200
Subject: [LTP] [PATCH v3 2/3] lib: rename ltp_clone_malloc to
 ltp_clone_alloc
In-Reply-To: <CAEemH2e7yfW3fd2kRFh-6tq8Y+sZeBvSB4Eu4JN6Htdo4_=K5g@mail.gmail.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <fd8b05453a0c72f2810a53e49ca1dc9467d9dbf9.1560410182.git.jstancek@redhat.com>
 <CAEemH2f_oMYubEDLdOmhxrEguKkc+3smx682LF7D9uiwZ26OAQ@mail.gmail.com>
 <20190613135740.GB29926@rei.lan>
 <CAEemH2e7yfW3fd2kRFh-6tq8Y+sZeBvSB4Eu4JN6Htdo4_=K5g@mail.gmail.com>
Message-ID: <20190614152428.GA12655@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Well, we can free the memory in ltp_clone_alloc() if the child runs in a
> > separate memory space, but if CLONE_VM was passed in flags there is no
> > way how to free the memory...
> >
> 
> A stupid way come up to my mind is just to export the stack as global
> pointer and releasing in do_cleanup() if possible.

This only works if you call the function only once, if you clone two or
more you end up in the very same situation as before.

Also we will have to figure out similar problem as a part of
https://github.com/linux-test-project/ltp/issues/531 anyways, so I
wouldn't bother at this point.

-- 
Cyril Hrubis
chrubis@suse.cz
