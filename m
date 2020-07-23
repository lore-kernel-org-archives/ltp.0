From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Jul 2020 15:51:14 +0800
Subject: [LTP] [PATCH 1/3] lib: add function to check for kernel lockdown
In-Reply-To: <8c72fb72-c7aa-f21f-e08c-d97c28e4c375@redhat.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <CAEemH2c1Sz+pkcLnCoWWCaMCte7QsmUTOoUxU6fzCF32nrrG+w@mail.gmail.com>
 <98eaa723-1349-272d-3021-d2fef6e1abdd@redhat.com>
 <CAEemH2e0nwt_aOytJz0WzB3CYSirxa4myOZoQqCPTAVBL11gbQ@mail.gmail.com>
 <8c72fb72-c7aa-f21f-e08c-d97c28e4c375@redhat.com>
Message-ID: <CAEemH2dB00x1-Ap7ZpyBzwPKDTzeJFQbea9rV4gWS81JufntBA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 22, 2020 at 11:52 PM Erico Nunes <ernunes@redhat.com> wrote:

> ...
> > So maybe we could simply do detect the /sys/kernel/../loackdown file as
> > your patch,
> > but adding an extra warning print when test failed on older than
> > kernel-v5.4.
>
> I like the idea of the warning. The only thing to consider is that the

warning would also show up on all old kernels that don't even support


lockdown and then don't have the file. So would you suggest this message
> to be something like a tst_res(TWARN, ...) or TINFO or some other less
> noisy way?
>
Thanks, but I did not suggest to show the warning in any system without the
lockdown file. I mean if test getting FAIL on the no 'lockdown' file
system, then could consider throwing a warning as a hint.
And this could be achieved in the test case but not the library.

For indicating the 'lockdown' file exist or no-exist, the 'TINFO' is enough.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200723/2a96b60d/attachment-0001.htm>
