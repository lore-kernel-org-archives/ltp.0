From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Aug 2020 11:43:50 +0800
Subject: [LTP] [PATCH 2/4] syscalls/kill03,
 04: Cleanup && Convert to new library
In-Reply-To: <a6f38749-60fd-94b2-ea2c-c7c9f9a6dd1f@cn.fujitsu.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1597919168-10702-2-git-send-email-zhufy.jy@cn.fujitsu.com>
 <CAEemH2eUd3yCuxt3iawHPXKUSryiJprud3HvneSr=JK_1wFhXg@mail.gmail.com>
 <43a404a1-dd4b-d091-5723-e756604fbbc8@cn.fujitsu.com>
 <CAEemH2fjgYGLD0+JozNcMqv3Eo0eAwK8+BKOCo0QZihUPiP6eg@mail.gmail.com>
 <ebb95886-a352-ab26-2d40-8a3e2e7fa62f@cn.fujitsu.com>
 <CAEemH2dzPyHYdnMJa1A15dLrLrt2m5q5HKo6PY+nrVzBuJjv0g@mail.gmail.com>
 <a6f38749-60fd-94b2-ea2c-c7c9f9a6dd1f@cn.fujitsu.com>
Message-ID: <CAEemH2d+SSFQnodfY+5QWKdbcr6m_ep_Bi65ynt1AxNQh3N8eQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 21, 2020 at 11:34 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> ...
> Yes. I think using current process id instead of 0 is more easier
> because the invalid signal can't kill process forever.
>
> static void setup(void)
> {
>          real_pid = getpid();
>

Agreed!


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200821/1cb95f23/attachment.htm>
