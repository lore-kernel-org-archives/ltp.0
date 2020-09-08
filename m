From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Sep 2020 15:45:41 +0800
Subject: [LTP] LTP release
In-Reply-To: <20200908073138.GB2475@yuki.lan>
References: <20200908073138.GB2475@yuki.lan>
Message-ID: <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 8, 2020 at 3:31 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> As usual we should start preparing for a next release.
>
> As usuall we will have a week or two where we should merge everthing
> that should go in before the release, then git freeze for another week
> and finally a release.
>
> So let's start with a list of things that should go in.
>
> For me it would be:
>
> * ptrace08 fix
>
> * if possible the shmctl() rewrite
>
+1 these rewrite looks good, I will finish my test by the end of today.


>
>
> What else should go in?
>

It may be better to fix ioctl_loop01 too.
https://github.com/linux-test-project/ltp/issues/718

And I'd like to add the MAP_GROWSDOWN test too, but I haven't come up with
a way to solve the segment fault on s390x.
http://lists.linux.it/pipermail/ltp/2020-August/018416.html

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200908/3490a74a/attachment.htm>
