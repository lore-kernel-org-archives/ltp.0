From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Jul 2018 02:49:12 -0400 (EDT)
Subject: [LTP] [PATCH] madvise: remove the min_kver check
In-Reply-To: <20180723054000.13760-1-liwang@redhat.com>
References: <20180723054000.13760-1-liwang@redhat.com>
Message-ID: <707244754.35082963.1532328552303.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> For the reason that most of LTS enterprise linux distribution backport
> this MADV_WIPEONFORK feature, here let's cancel the kernel limitation
> to make madvise(..., MADV_WIPEONFORK) test more widely.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>

We can do that, EINVAL should be quite clear here. I opened
https://github.com/linux-test-project/ltp/issues/371 to add
the other scenarios that could lead to EINVAL.

Patch pushed.

Regards,
Jan
