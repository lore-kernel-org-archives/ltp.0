From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jul 2020 21:19:17 +0800
Subject: [LTP] [PATCH 1/3] lib: add function to check for kernel lockdown
In-Reply-To: <98eaa723-1349-272d-3021-d2fef6e1abdd@redhat.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <CAEemH2c1Sz+pkcLnCoWWCaMCte7QsmUTOoUxU6fzCF32nrrG+w@mail.gmail.com>
 <98eaa723-1349-272d-3021-d2fef6e1abdd@redhat.com>
Message-ID: <CAEemH2e0nwt_aOytJz0WzB3CYSirxa4myOZoQqCPTAVBL11gbQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Erico,

On Tue, Jul 21, 2020 at 4:57 PM Erico Nunes <ernunes@redhat.com> wrote:

> ...
>
> > Maybe renaming the function to tst_lockdown_enabled() is better? Then we
> > can return 1 if confirm kernel under lockdown mode otherwise 0.
>

How do you think about this suggestion? ^^

Another reason to name it as tst_lockdown_enabled() is, we can give more
flexible
to test case, because not all tests need a simple skip in lockdown mode(in
future).

i.e.
if (tst_lockdown_enabled()) {
   // skip or not,
   // do what they wanted in this mode
}


> After thinking over, I guess it's not enough to only check
> > /sys/../lockdown file. Seems we need to consider the situation that
> > system without supporting this file?
> >
> > i.e.
> >   Test on RHEL8 (no /sys/../lockdown file) with kernel parameter
> > "lockdown" and got the restriction error too.
> >
> > # cat /proc/cmdline
> > BOOT_IMAGE=(hd0,msdos1)/vmlinuz-4.18.0-226.el8.x86_64
> > root=/dev/mapper/rhel_bootp--73--3--209-root ro console=ttyS0,115200
> > ... lockdown
> >
> > # ll /sys/kernel/security/lockdown
> > ls: cannot access '/sys/kernel/security/lockdown': No such file or
> directory
>
> To my understanding, the parameter to enable lockdown through kenrel
> parameters is "lockdown={integrity|confidentiality}", not just
> "lockdown", at least on upstream kernels:
>

Good to know this.


>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aefcf2f4b58155d27340ba5f9ddbe9513da8286d
>


>
> If /sys/kernel/security/lockdown doesn't exist, I'm not sure there is
> much we can do easily, or that is worth doing now. I think it is ok to
> fall back and fail like it has been happening since the feature was
> merged upstream.
>

Yes, it looks a bit tricky.


> I can't see a tweak that would enable the feature but not the sysfs file
> in the kernel source. Maybe that kernel only had partial support?
>

Seems you're right, there are many differences between mainline-kernel
and some distros in lockdown code. The reason that some distribution
(i.e RHEL, Ubuntu) partly customizes the LSM feature, it does not support
lockdown features completely so far.

But one point we're sure is that the /sys/kernel/../lockdown file was
introduced from kernel-v5.4.

So maybe we could simply do detect the /sys/kernel/../loackdown file as
your patch,
but adding an extra warning print when test failed on older than
kernel-v5.4.

Or, if others can provide a better way I'd happy to hear.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200721/88b05af2/attachment.htm>
