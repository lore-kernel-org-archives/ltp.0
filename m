From: Li Wang <liwang@redhat.com>
Date: Fri, 29 Nov 2019 14:49:42 +0800
Subject: [LTP] [PATCH] Unshare KSM pages before setting max_page_sharing
In-Reply-To: <20191128163147.4377-1-mdoucha@suse.cz>
References: <20191128163147.4377-1-mdoucha@suse.cz>
Message-ID: <CAEemH2ecHFwkTi3eFsc=McU0xJmDA5D9bn2ntuKzbqLTtLz7rA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 29, 2019 at 12:32 AM Martin Doucha <mdoucha@suse.cz> wrote:

> Setting max_page_sharing is possible only when there are no KSM shared
> pages
> in the system. Otherwise writing to max_page_sharing SysFS file will fail
> with EBUSY.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191129/5fd0585d/attachment.htm>
