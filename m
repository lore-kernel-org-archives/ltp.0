From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Jul 2018 05:42:31 -0400 (EDT)
Subject: [LTP] [PATCH v2] open08: calling tst_get_bad_addr from LTP API
In-Reply-To: <20180711092835.12062-1-liwang@redhat.com>
References: <20180711092835.12062-1-liwang@redhat.com>
Message-ID: <993114831.31844662.1531302151909.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From open(2) manual, pathname(unmapped_fname) points outside the
> accessible address space, then test will result in failure with EFAULT.
> 
> LTP tst_get_bad_addr() maps a contiguous virtual memory region by using
> PROT_NONE to provide page not be accessed too. Here we can take use of
> it to achieve the same purpose.
> 
> Also fix code comments to match open(2) maunal precisely.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>

Pushed.

Thanks,
Jan
