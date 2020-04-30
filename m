From: Li Wang <liwang@redhat.com>
Date: Thu, 30 Apr 2020 14:57:35 +0800
Subject: [LTP] [PATCH v4 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <36bd1e20-414b-ec24-f7e3-16ef7e2395d9@cn.fujitsu.com>
References: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587552329-21738-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ea_CtRyP9KtpJDjpEzobRyhrodiycDCAxhLbCjuOwhCQ@mail.gmail.com>
 <662aa817-04ff-e924-6880-7c23fa1cfe31@cn.fujitsu.com>
 <CAEemH2cF-kziNEHuN1GayTtzwdxFFzsu0wRGB85yJ=LaKS-XBw@mail.gmail.com>
 <3268f153-6730-708f-ed93-19ca4cf85fdd@cn.fujitsu.com>
 <CAEemH2ee7c55=EQb5qohpu40XMACSOCrSStwWt7u=_GyqjrxLw@mail.gmail.com>
 <CAHk-=wg7u4AjZQd49VjrZXikDMfK-HchOKHYqoUFwcXjsbJ3XQ@mail.gmail.com>
 <36bd1e20-414b-ec24-f7e3-16ef7e2395d9@cn.fujitsu.com>
Message-ID: <CAEemH2d-puNst+Mro8oSCiobw2dhHcQVaS=6YoBX=v2+hVMqzQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

Hi Linus
>
>
> > On Sun, Apr 26, 2020 at 4:59 AM Li Wang <liwang@redhat.com> wrote:
> >>
> >>  From kernel code seems you are right. The pipe indeed takes use of
> PAGE_SIZE(ppc64le: 64kB) to split the writes data in the packetized mode
> (marked by O_DIRECT). But in the manual page, O_DIRECT indicates us the
> PIPE_BUF is the correct atomic unit.
>


> >
> > The manual is correct.
> >
> > PIPE_BUF is the size we _guarantee_ can be used atomically.
> >
> > The fact that in practice we do have bigger buffers on some platforms
> > is an implementation detail.
> >
> > Yes, that implementation detail can be visible, but basically any test
> > code that tries to test for "what if we use a bigger bug that
> > PIPE_BUF" is buggy. It's simply not guaranteed to work any more.
> >
> > O_DIRECT is kind of immaterial, except it's just one of those things
> > where the atomic size is slightly more visible. But basically,
> > packetized pipes with bigger packets than PIPE_BUF is random behavior.
> > It may work. It may not.
>


> Thanks for your explanation. I am more curious about the user scene of
> this flag.
>
>

> @Li, so how to design this test? In this test, we don't have complex
> scene to test this automic unit.
>

As Linus pointed out that "packetized pipes with bigger packets than
PIPE_BUF is random behavior", it looks the way in your test is not
guaranteed to work correctly, so I would drop the pipe2_03.c patch.
But according to the pipe(7) manual page, we could try to verify writing
data less than PIPE_BUF is atomic, and the pipe read end also should
provide us correct data in one packet at a time.

"
PIPE_BUF
  POSIX.1 says that write(2)s of less than PIPE_BUF bytes must be
  atomic: the output data is written to the pipe as a contiguous sequence
  ...
  POSIX.1 requires PIPE_BUF to be at least 512 bytes. (On Linux, PIPE_BUF
is 4096 bytes.)
  ...

  O_NONBLOCK disabled, n <= PIPE_BUF ...

  O_NONBLOCK enabled, n <= PIPE_BUF ...
"
http://man7.org/linux/man-pages/man7/pipe.7.html

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200430/854ddcf7/attachment.htm>
