From: Li Wang <liwan@redhat.com>
Date: Thu, 11 Jan 2018 13:47:53 +0800
Subject: [LTP] [PATCH] endian_switch01: rewrite to newlib
In-Reply-To: <0db42a518baa79cd6139f566482e2dab11cfb4bd.1515587913.git.jstancek@redhat.com>
References: <0db42a518baa79cd6139f566482e2dab11cfb4bd.1515587913.git.jstancek@redhat.com>
Message-ID: <CAEemH2eNi3unPaEyfHH8rraPaKM3QgKO+ikHZL-2k+zNf0SeJQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Jan 10, 2018 at 8:42 PM, Jan Stancek <jstancek@redhat.com> wrote:

> Also check that syscall is supported (doesn't return ENOSYS),
> before running actual test. This is to address kernels where
> this syscall is disabled by default:
>   commit 727f13616c45 ("powerpc: Disable the fast-endian switch syscall by
> default")
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>

​Works fine on kernels with/without fast endian-switch syscall​ support.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180111/761e72fd/attachment.html>
