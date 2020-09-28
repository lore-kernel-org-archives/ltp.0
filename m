From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Sep 2020 14:34:20 +0800
Subject: [LTP] [PATCH] cpuset_inherit_test: compatibility fix for DASH
In-Reply-To: <20200928054043.17058-1-po-hsu.lin@canonical.com>
References: <20200928054043.17058-1-po-hsu.lin@canonical.com>
Message-ID: <CAEemH2dfGU3ieQhrFY7t+=1oUp_rji_eAY37tt30z=QzpeYrQA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 28, 2020 at 1:41 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> The /bin/sh was symbolically link to dash in Ubuntu, in which the
> "let" expression does not work, it will complain about:
>     cpuset_inherit_testset.sh: let: not found
>
> Fix it with double parentheses arithmetic expansion to improve the
> compatibility.
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>

Pushed, thanks!


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200928/6af8a1f1/attachment.htm>
