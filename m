From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Sep 2019 10:51:21 +0800
Subject: [LTP] [PATCH] madvise09:Change PAGES size to the value more
 than 32
In-Reply-To: <20190911111900.GA19244@rei.lan>
References: <1567576823-10080-1-git-send-email-shuang.qiu@oracle.com>
 <CAEemH2fiJkau0A3yQH+nHVPXMwtTzyV3_weTQRniZFR+EJqN_g@mail.gmail.com>
 <20190911111900.GA19244@rei.lan>
Message-ID: <CAEemH2eMYmquWXAHXUuPQ1Li2DSfvHpV01O4GMQFZ0Z0s=8+hw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 11, 2019 at 7:19 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I'm not sure why 64 pages is a proper value? Can you explain more?
>
> I've just talked to Michal Hocko and the conclusion is that we should
> allocate several megabytes to avoid depending kernel implementation
> details, which would mean allocating thousands of pages.
>

Sounds reasonable. Allocating thousands of pages must trigger the MADV_FREE
page reclaiming.

@shuang.qiu, Hi Shuang, would you mind to rewrite the patch, or should I do
that?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190912/2100c785/attachment.htm>
