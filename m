From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Nov 2015 18:21:05 +0800
Subject: [LTP] [PATCH v2] signal: add new testcase signal06.c
In-Reply-To: <748520497.6794885.1447232724888.JavaMail.zimbra@redhat.com>
References: <1447151557-27539-1-git-send-email-liwang@redhat.com>
 <748520497.6794885.1447232724888.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2coOUxU+EasNsedcrhQf_Oydiv4rbHV3X+g5B3ofEFTQA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Wed, Nov 11, 2015 at 5:05 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
>
> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: jstancek@redhat.com
> > Cc: ltp@lists.linux.it
> > Sent: Tuesday, 10 November, 2015 11:32:37 AM
> > Subject: [PATCH v2] signal: add new testcase signal06.c
> >
> > v1 --> v2
> >       1. define LOOPS as 10000
> >       2. use -pthread in Makefile
> >       3. add volatile to FLAGE
> >       4. include linux_syscall_numbers.h
> >       5. use __NR_tkill and SIGHUP
> >       6. use tst_exit() and TEST()
>
> Hi,
>
> just some minor comments below, I missed some in last email.
>

I have read it, agree all.


>
> Other than that it looked ok to me and I could reproduce the bug
> on older kernels.
>

ok, I will sent V3 later. thanks!


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151111/acf1adf3/attachment-0001.html>
