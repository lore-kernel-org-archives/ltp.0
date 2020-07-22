From: Erico Nunes <ernunes@redhat.com>
Date: Wed, 22 Jul 2020 17:52:33 +0200
Subject: [LTP] [PATCH 1/3] lib: add function to check for kernel lockdown
In-Reply-To: <CAEemH2e0nwt_aOytJz0WzB3CYSirxa4myOZoQqCPTAVBL11gbQ@mail.gmail.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <CAEemH2c1Sz+pkcLnCoWWCaMCte7QsmUTOoUxU6fzCF32nrrG+w@mail.gmail.com>
 <98eaa723-1349-272d-3021-d2fef6e1abdd@redhat.com>
 <CAEemH2e0nwt_aOytJz0WzB3CYSirxa4myOZoQqCPTAVBL11gbQ@mail.gmail.com>
Message-ID: <8c72fb72-c7aa-f21f-e08c-d97c28e4c375@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/21/20 3:19 PM, Li Wang wrote:
> On Tue, Jul 21, 2020 at 4:57 PM Erico Nunes <ernunes@redhat.com
> <mailto:ernunes@redhat.com>> wrote:
> 
>     ...
> 
>     > Maybe renaming the function to tst_lockdown_enabled() is better?
>     Then we
>     > can return?1 if confirm kernel under lockdown mode otherwise 0.
> 
> 
> How do you think about this suggestion? ^^
> 
> Another reason?to name it as tst_lockdown_enabled() is, we can give more
> flexible
> to test case, because?not all tests need a simple skip in lockdown
> mode(in future).
> 
> i.e.
> if (tst_lockdown_enabled()) {
> ? ?// skip or not,
> ? ?// do what they wanted in this mode
> }

I like this suggestion, I'll send v2 with this.

>     If /sys/kernel/security/lockdown doesn't exist, I'm not sure there is
>     much we can do easily, or that is worth doing now. I think it is ok to
>     fall back and fail like it has been happening since the feature was
>     merged upstream.
> 
> 
> Yes, it looks a bit tricky.
> ?
> 
>     I can't see a tweak that would enable the feature but not the sysfs file
>     in the kernel source. Maybe that kernel only had partial support?
> 
> 
> Seems you're right, there are many differences between mainline-kernel
> and some distros in lockdown code. The reason that some distribution
> (i.e RHEL, Ubuntu) partly customizes the LSM feature,?it does not support
> lockdown features completely so far.
> 
> But one point we're sure is that the /sys/kernel/../lockdown file was
> introduced from kernel-v5.4.
> 
> So maybe we could simply do detect the /sys/kernel/../loackdown file as
> your patch,
> but adding an extra warning print when test failed on older than
> kernel-v5.4.

I like the idea of the warning. The only thing to consider is that the
warning would also show up on all old kernels that don't even support
lockdown and then don't have the file. So would you suggest this message
to be something like a tst_res(TWARN, ...) or TINFO or some other less
noisy way?

I also thought about limiting to some kernel version but that wouldn't
work with distribution kernels like RHEL which have an earlier version
number but also have the feature...

Erico

