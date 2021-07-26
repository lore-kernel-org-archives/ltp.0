From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Jul 2021 16:48:37 +0800
Subject: [LTP] [PATCH] syscalls/memcmp01: Convert to new API
In-Reply-To: <20210726034928.15766-1-zhanglianjie@uniontech.com>
References: <20210726034928.15766-1-zhanglianjie@uniontech.com>
Message-ID: <CAEemH2cmbm701govDvsV15oPQ9SWJCwSfo24rowyyBhd2pUprg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lianjie,

Given the fact that the return value of memcmp() is possible
to less than, equal to, and greater than zero in str1 and str2
comparison.

So I made a change on the return value check to make
it more accurate in the testing.

e.g.

(!memcmp(str1, str2, n))  ==> (memcmp(str1, str2, n) <= 0);    str > str2
(!memcmp(str1, str2, n))  ==> (memcmp(str1, str2, n) >= 0);    str < str2

Besides that, I applied your patch with some cleanup work as well.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210726/551fdafe/attachment-0001.htm>
