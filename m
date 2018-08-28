From: Li Wang <liwan@redhat.com>
Date: Tue, 28 Aug 2018 20:34:13 +0800
Subject: [LTP] [PATCH v2 1/2] lib: add tst_get_timeout()
In-Reply-To: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
References: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
Message-ID: <CAEemH2eKpzcfKmcCgA_YN903mW_urpZE3V9vyrj7ML6BHhwkig@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 28, 2018 at 7:07 PM, Jan Stancek <jstancek@redhat.com> wrote:

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
...
> +{
> +       return results->timeout;
> +}
>

Patch set looks good to me.

At the beginning, I thought to use tst_timeout_mul() function which will be
introduced by Richard's new 1/5 patch 'lib: Allow user to easily get
LTP_TIMEOUT_MUL value". But after looking at this tst_get_timeout(), it
seems more useful to ltp testcase in future. So I stand by this method.

And, test get pass on kernel 4.19.0-rc1+ x86_64.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180828/3e86d0e8/attachment.html>
