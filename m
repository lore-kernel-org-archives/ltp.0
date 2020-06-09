From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Jun 2020 20:27:01 +0800
Subject: [LTP] [PATCH] read_all: scale down how many times we read by
 default
In-Reply-To: <33c4abf347e2de96f89b9acea02d731e47dbf2a9.1591700131.git.jstancek@redhat.com>
References: <33c4abf347e2de96f89b9acea02d731e47dbf2a9.1591700131.git.jstancek@redhat.com>
Message-ID: <CAEemH2cnbDcqWMo2tLRzTsfMgFxecqP8QMEUFdchS7MxMGErCA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[Cc Richard] in case he has extra suggest.

On Tue, Jun 9, 2020 at 6:56 PM Jan Stancek <jstancek@redhat.com> wrote:

> read_all is running into timeouts on high cpu systems, where
> access to some per-cpu files is protected by a lock. Latest
> example is /sys/kernel/tracing/per_cpu/*.
>
> At the moment we read each file 10 times, and we have been
> excluding files that take too long. Rather than expanding
> blacklist, scale the default down to 3.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200609/b70c248a/attachment.htm>
