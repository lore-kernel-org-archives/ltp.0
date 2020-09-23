From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Sep 2020 14:58:17 +0800
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2dFqYRNNSyhQ1bJ_L+wHFUQkOVBgdnm-_6Nqr4rP7UbBg@mail.gmail.com>
References: <20200908073138.GB2475@yuki.lan> <20200922182102.GB12980@yuki.lan>
 <CAEemH2dFqYRNNSyhQ1bJ_L+wHFUQkOVBgdnm-_6Nqr4rP7UbBg@mail.gmail.com>
Message-ID: <CAEemH2cxf2RQz5psmsaUsBHRrtayLJUVTfCo+NvevSyu7bLmvA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CC' people who touched the patches maybe give a hand.

On Wed, Sep 23, 2020 at 2:50 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Wed, Sep 23, 2020 at 2:20 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> As far as I can tell I've pushed the last patch that should have been in
>> the release just now. With that we should have a week worth of
>> pre-release testing since we are aiming for a release at the end of the
>> September. If you haven't tried LTP git HEAD yet, please do so now and
>> report any problems you find.
>>
>
> We still got this persistent fail on some kernels(RHEL8, kernel-v5.9-rc4):
>
> ---
> send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>
> ---
> fanotify10.c:404: TFAIL: group 0 (4) got event: mask 1020 (expected 1000)
> pid=95067 fd=12
> fanotify10.c:404: TFAIL: group 1 (4) got event: mask 1020 (expected 1000)
> pid=95067 fd=12
> fanotify10.c:404: TFAIL: group 2 (4) got event: mask 1020 (expected 1000)
> pid=95067 fd=12
> fanotify10.c:404: TFAIL: group 0 (0) got event: mask 1020 (expected 1000)
> pid=95067 fd=12
> fanotify10.c:404: TFAIL: group 1 (0) got event: mask 1020 (expected 1000)
> pid=95067 fd=12
> fanotify10.c:404: TFAIL: group 2 (0) got event: mask 1020 (expected 1000)
> pid=95067 fd=12
>
> ---
> recvmmsg01.c:86:9: error: request for member ?type? in something not a
> structure or union
>   timeout.type = tv->ts_type;
>
> Otherwise, the latest LTP test good from my side(RHEL8, mainline-kernel).
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200923/e25ccedb/attachment-0001.htm>
