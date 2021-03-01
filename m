From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Mar 2021 14:36:07 +0800
Subject: [LTP] [PATCH] syscalls/getpid02: Also check the fork() retval
In-Reply-To: <20210226153711.13645-1-chrubis@suse.cz>
References: <20210226153711.13645-1-chrubis@suse.cz>
Message-ID: <CAEemH2ebeC=fi0U_OahsOBz=c4RKF7J29gbJBsb7c3nrcroFLw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

The return value from fork() in parent must be equal to getpid() in child.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210301/ad9cb211/attachment.htm>
