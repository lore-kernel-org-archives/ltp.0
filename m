From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Mar 2020 14:11:03 +0800
Subject: [LTP] [PATCH] hugeshmctl01: Revert "hugeshmctl: Use loop from
 the API"
In-Reply-To: <20200305172142.GA24302@dell5510>
References: <1583402023-22461-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200305172142.GA24302@dell5510>
Message-ID: <CAEemH2f+tOCEm=6k9p+xZNAKgKcCu95ZdDdyy1RQqtqRYD+zOA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 6, 2020 at 1:21 AM Petr Vorel <pvorel@suse.cz> wrote:

> ..
> I'd personally prefer to keep .tcnt = ARRAY_SIZE(tcases),
>

+1 Me too. I don't think we should revert the patch. Just fix the problem
and do refactor or improvement will make the code more readable.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200306/be828b3f/attachment.htm>
