From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Jun 2021 16:43:46 +0800
Subject: [LTP] [PATCH] syscalls/fchown: Make output nicer and add checks
 before SAFE_CLOSE(fd)
In-Reply-To: <20210607080742.21377-1-xieziyao@huawei.com>
References: <20210607080742.21377-1-xieziyao@huawei.com>
Message-ID: <CAEemH2cuUTYpgv2qiSw=_pWNkBqLGoiSVUHe3grrPKCnJBYg+Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao <xieziyao@huawei.com> wrote:

> 1. Print values not variable names in TST_EXP_PASS().
> 2. Check if the fd has been opened in cleanup().

I helped tweak the format and pushed, thanks!

-- 
Regards,
Li Wang

