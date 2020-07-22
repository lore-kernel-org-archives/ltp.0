From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jul 2020 17:58:08 +0200
Subject: [LTP] [PATCH 1/3] lib: add function to check for kernel lockdown
In-Reply-To: <8c72fb72-c7aa-f21f-e08c-d97c28e4c375@redhat.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <CAEemH2c1Sz+pkcLnCoWWCaMCte7QsmUTOoUxU6fzCF32nrrG+w@mail.gmail.com>
 <98eaa723-1349-272d-3021-d2fef6e1abdd@redhat.com>
 <CAEemH2e0nwt_aOytJz0WzB3CYSirxa4myOZoQqCPTAVBL11gbQ@mail.gmail.com>
 <8c72fb72-c7aa-f21f-e08c-d97c28e4c375@redhat.com>
Message-ID: <20200722155808.GA3864@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So maybe we could simply do detect the /sys/kernel/../loackdown file as
> > your patch,
> > but adding an extra warning print when test failed on older than
> > kernel-v5.4.
> 
> I like the idea of the warning. The only thing to consider is that the
> warning would also show up on all old kernels that don't even support
> lockdown and then don't have the file. So would you suggest this message
> to be something like a tst_res(TWARN, ...) or TINFO or some other less
> noisy way?

TWARN will cause the test to exit with non-zero status, which will
probably show up as a failure in some environments, so I would go for
TINFO.

> I also thought about limiting to some kernel version but that wouldn't
> work with distribution kernels like RHEL which have an earlier version
> number but also have the feature...

We also have an interface to match different kernel versions per
distribution, have a look at tst_kern_exv structure in inotify04.c
testcase.

-- 
Cyril Hrubis
chrubis@suse.cz
