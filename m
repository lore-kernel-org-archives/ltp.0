From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Mar 2019 15:04:43 +0800
Subject: [LTP] [RFC PATCH] mm: rewrite mtest01 with new API
In-Reply-To: <269593361.3808924.1551429852336.JavaMail.zimbra@redhat.com>
References: <20190228074002.14351-1-liwang@redhat.com>
 <646940042.3510845.1551391739985.JavaMail.zimbra@redhat.com>
 <CAEemH2d1NFFP8aQs96W-4r-OSBoXkd86TD92wp3ZZxzrhygQyw@mail.gmail.com>
 <138010263.3799706.1551427391091.JavaMail.zimbra@redhat.com>
 <CAEemH2cx0mPzhgAUKq01_4JXOnanQjK79JqEdPZ5N0kpO4A_QA@mail.gmail.com>
 <269593361.3808924.1551429852336.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2f+wNLrEcBQ08SRsAAW-QbVT5hj190+ZGucyfzUvM3uYA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 1, 2019 at 4:44 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> > if (dowrite) {
> >                 pre_free - post_free check...
>
> This doesn't look very accurate. Other system processes can influence this.
>
> Do we need to check it at all? If a child didn't complete allocation
> it's not going to signal parent.
>

Sounds reasonable, if the parent exit from the loop correctly that means
children finished their memory allocation.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190305/c97248e5/attachment.html>
