From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Sep 2021 07:38:26 +0200
Subject: [LTP] [PATCH] ftruncate04: require
 CONFIG_MANDATORY_FILE_LOCKING=y
In-Reply-To: <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
References: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
 <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
Message-ID: <CAASaF6weZ3DTLCRkpYfBbYwT+0b2EdDvm6Z0Q--oDyYC2fY+1w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 7, 2021 at 4:20 AM Li Wang <liwang@redhat.com> wrote:

>
>
> On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>> commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
>> removed mandatory file locking support, but mount option
>> is still allowed and produces no error. There's a warning
>> in dmesg but it's pr_warn_once() so we can't rely to always
>> find it there.
>>
>> Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.
>>
>
> I'm wondering, if the SUT without CONFIG_MANDATORY_FILE_LOCKING
> enabling, why the mount-check in setup() didn't report EPERM?
>

Because kernel commit f7e33bdbd6d1 removed that code, it generates
warning message instead.


>
> And, should we drop the mount-check for EPERM from setup after adding
> this .needs_kconfigs?
>

I'd keep it, it doesn't hurt anything and older kernels could get EPERM
for other reason (like running test in namespace where you don't have
CAP_SYS_ADMIN)



>
> --
> Regards,
> Li Wang
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210907/b1de7d4a/attachment.htm>
