From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Aug 2020 14:16:07 +0800
Subject: [LTP] [PATCH] setxattr03: TCONF if failed to set immutable flag
In-Reply-To: <20200820015211.u7xdye5ggbe34fsp@xzhoux.usersys.redhat.com>
References: <20200820015211.u7xdye5ggbe34fsp@xzhoux.usersys.redhat.com>
Message-ID: <CAEemH2faf5g0JUdBFNvqrNRHB5orbTvHnrwHCm5enF7tt7N=YA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Murphy,

On Thu, Aug 20, 2020 at 9:52 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:

> Instead of TBROK, probably the underlying filesystem not support this flag.
>

Which filesystem do you mean here? What kind of error it was given?
Maybe we should confirm the errno is EINVAL or ENOTSUP before TCONF.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200820/94a06732/attachment-0001.htm>
