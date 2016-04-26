From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Apr 2016 05:47:34 -0400 (EDT)
Subject: [LTP] [PATCH v3 5/5] kernel/syscalls: add new test with 'open()
 + O_TMPFILE'
In-Reply-To: <20160425150735.GE20158@rei.lan>
References: <1454069150-27889-1-git-send-email-alexey.kodanev@oracle.com>
 <1454069150-27889-6-git-send-email-alexey.kodanev@oracle.com>
 <1689676802.79541.1461594932412.JavaMail.zimbra@redhat.com>
 <571E33E0.5040807@oracle.com> <20160425150735.GE20158@rei.lan>
Message-ID: <1962140078.296306.1461664054799.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> Cc: "Jan Stancek" <jstancek@redhat.com>, "vasily isaenko" <vasily.isaenko@oracle.com>, ltp@lists.linux.it
> Sent: Monday, 25 April, 2016 5:07:35 PM
> Subject: Re: [LTP] [PATCH v3 5/5] kernel/syscalls: add new test with 'open() + O_TMPFILE'
> 
> Hi!
> > If the issue with mode... it can be because glibc doesn't process mode
> > argument unless O_CREAT is found. In our case we have O_TMPFILE instead.
> > 
> > Here is the link to bugzilla:
> > 
> > "open() and openat() ignore 'mode' with O_TMPFILE"
> > https://sourceware.org/bugzilla/show_bug.cgi?id=17523

Thanks. Jeff Bastian independently found this BZ as well. 
systemtap confirms, that mode remains 0, even when testcase is
passing non-zero values.

sys_openat ., dfd=0xffffffffffffff9c filename=0x40ac50 flags=0x404002 mode=0x0

> 
> What I see matches the the behavior in Comment 5.

I'm on aarch64, so that may explain why both fail for me.

After applying this patch:
  https://sourceware.org/git/gitweb.cgi?p=glibc.git;h=65f6f938cd562a614a68e15d0581a34b177ec29d
both testcases passed.

Regards,
Jan
