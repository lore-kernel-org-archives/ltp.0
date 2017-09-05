From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Sep 2017 16:13:05 +0800
Subject: [LTP] [PATCH] hugemmap/hugemmap05.c: fix warnings in cleanup()
In-Reply-To: <1504148379-8552-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1504148379-8552-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <CAEemH2dPvftsAwOim7S-hxU+qGqfPDn2VyAApsm0S9+R3YYCiA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After applying this patch, the warning is gone. Thanks!

safe_macros.c:62: WARN: hugemmap05.c:184: close(-1) failed: EBADF
safe_macros.c:360: WARN: hugemmap05.c:185: unlink(hugemmap05/file)
failed: ENOENT




-- 
Li Wang
liwang@redhat.com
