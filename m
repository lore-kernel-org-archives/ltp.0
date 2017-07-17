From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Jul 2017 02:50:29 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/setrlimit: add setrlimit04
In-Reply-To: <CAEemH2eH7tYAzwbcBt+Ootjw3eEWx3xuwKWiYiF6YA4q0=9X3w@mail.gmail.com>
References: <efe5be914c757f391b9f0eba0630548dea309f1b.1500030543.git.jstancek@redhat.com>
 <CAEemH2eH7tYAzwbcBt+Ootjw3eEWx3xuwKWiYiF6YA4q0=9X3w@mail.gmail.com>
Message-ID: <1008257811.53320687.1500274229249.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Fri, Jul 14, 2017 at 7:12 PM, Jan Stancek <jstancek@redhat.com> wrote:
> > Early patches for stack guard gap caused that gap size was contributing
> > towards stack limit. This caused failures for new processes (E2BIG) when
> > ulimit was set to anything lower than size of gap.
...
> > +static struct tst_test test = {
> > +       .test_all     = test_setrlimit,
> > +       .forks_child  = 1,
> > +       .needs_root = 1,
> 
> seems we need to filter out the suitable kernel:
> 
> .min_kver = "4.12.0",

Why, shouldn't this work on any kernel version?
