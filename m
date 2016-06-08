From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jun 2016 11:22:12 +0800
Subject: [LTP] [PATCH V4] syscalls/madvise02: reconstruct and convert to
	new API
In-Reply-To: <20160607142414.GA4397@rei.lan>
References: <1465287565-32639-1-git-send-email-liwang@redhat.com>
 <20160607142414.GA4397@rei.lan>
Message-ID: <20160608032212.GB5008@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Tue, Jun 07, 2016 at 04:24:14PM +0200, Cyril Hrubis wrote:
> 
> I've moved the setup-like parts from the filter function to setup, so
> that the filter function only filters the testcases.
> 
> And also used the LTP_ALIGN() macro to align the tmp_addr and pushed,
> thanks.

Thanks for reviewing. But seems the aligned address is not right, we need
to apply a new patch to fix that.

madvise02: correct the aligned address

Signed-off-by: Li Wang <liwang@redhat.com>

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 3a595c2..347d9cc 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -142,7 +142,7 @@ static void setup(void)
	nonalign = file1 + 100;

	ptr_addr = SAFE_MALLOC(st.st_size);
-       tmp_addr = (void*)LTP_ALIGN((long)tmp_addr, pagesize);
+       tmp_addr = (void*)LTP_ALIGN((long)ptr_addr, pagesize);

	SAFE_CLOSE(fd);


Regards,
Li Wang
