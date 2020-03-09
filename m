From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Mar 2020 14:04:03 +0800
Subject: [LTP] [PATCH v2] hugeshmctl01: Small refactor and remove
 stat_time
In-Reply-To: <20200309045621.GA3631484@x230>
References: <20200306071221.GA13530@dell5510>
 <1583490720-10003-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ce95Uyi1cZumF4drQ7NtehVwWyhcTM5L7cEjcb7he+oA@mail.gmail.com>
 <1d808289-aa4b-a47d-55cd-81908aaa532c@cn.fujitsu.com>
 <20200309045621.GA3631484@x230>
Message-ID: <CAEemH2e+hb1xAan-osBFVj7NDoe_G_DBod-wQWM+xZjEw23vng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 9, 2020 at 12:56 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li, Xu,
>
> > > Thanks for the quick work on refactoring. I'd suggest using the new
> > > '.request_hugepages'  in the testcase, would mind having a try?
> +1
>
> > OK. But I think we can merge this patch( it has a new line before
> func_stat,
> > remove ..) firstly and then I will use this library api in next patch for
> > all related  hugepage cases.
>

That would be great!

> Yes, I also think this should be separated, thus merged this fix.
>

Thanks Petr for helping merge that.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200309/2b589033/attachment.htm>
