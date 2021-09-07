From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Sep 2021 10:20:35 +0800
Subject: [LTP] [PATCH] ftruncate04: require
 CONFIG_MANDATORY_FILE_LOCKING=y
In-Reply-To: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
References: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
Message-ID: <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek <jstancek@redhat.com> wrote:

> commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
> removed mandatory file locking support, but mount option
> is still allowed and produces no error. There's a warning
> in dmesg but it's pr_warn_once() so we can't rely to always
> find it there.
>
> Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.
>

I'm wondering, if the SUT without CONFIG_MANDATORY_FILE_LOCKING
enabling, why the mount-check in setup() didn't report EPERM?

And, should we drop the mount-check for EPERM from setup after adding
this .needs_kconfigs?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210907/53acf06b/attachment.htm>
