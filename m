From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Mar 2020 05:56:21 +0100
Subject: [LTP] [PATCH v2] hugeshmctl01: Small refactor and remove
 stat_time
In-Reply-To: <1d808289-aa4b-a47d-55cd-81908aaa532c@cn.fujitsu.com>
References: <20200306071221.GA13530@dell5510>
 <1583490720-10003-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ce95Uyi1cZumF4drQ7NtehVwWyhcTM5L7cEjcb7he+oA@mail.gmail.com>
 <1d808289-aa4b-a47d-55cd-81908aaa532c@cn.fujitsu.com>
Message-ID: <20200309045621.GA3631484@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Xu,

> > Thanks for the quick work on refactoring. I'd suggest using the new
> > '.request_hugepages'? in the testcase, would mind having a try?
+1

> OK. But I think we can merge this patch( it has a new line before func_stat,
> remove ..) firstly and then I will use this library api in next patch for
> all related  hugepage cases.
Yes, I also think this should be separated, thus merged this fix.

Kind regards,
Petr
