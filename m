From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Aug 2019 14:55:25 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: use .needs_tmpdir and
 MAX_LEN
In-Reply-To: <1566541374-2225-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1566541374-2225-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2fT1_ATcKB5bD9OvsnJP1vsRbib_MGyB1Bk_U=Ccd1VVg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Seems you have to apply Petr's patch first, then do a new
modification. Because that patch fixes another compiling issue.

[1] http://lists.linux.it/pipermail/ltp/2019-August/013239.html

--
Regards,
Li Wang
