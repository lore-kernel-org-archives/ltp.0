From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Sep 2021 12:13:26 +0800
Subject: [LTP] [PATCH] lib: tst_virt: Add option to override virt
 detection
In-Reply-To: <20210914150220.2467-1-chrubis@suse.cz>
References: <20210914150220.2467-1-chrubis@suse.cz>
Message-ID: <CAEemH2cfT85O5HFPwG1d1Fso+JQBPi2h+cNFKRxhgsmW2j8f4w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 14, 2021 at 11:02 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> There seems to be cases where systemd-detect-virt does not detect
> virtualization correctly. To work around this bugs this commit adds a
> a support for LTP_VIRT_OVERRIDE environment variable that if set is used
> instead of the output from the systemd-detect-virt command.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210915/07263be2/attachment.htm>
