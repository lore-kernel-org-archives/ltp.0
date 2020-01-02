From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jan 2020 14:31:22 +0800
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <b2b1b91e-4813-a281-6f56-0924d21bb103@cn.fujitsu.com>
References: <20200102015236.7400-1-liwang@redhat.com>
 <b2b1b91e-4813-a281-6f56-0924d21bb103@cn.fujitsu.com>
Message-ID: <CAEemH2cPJnbNeLRNmHPoGDjh5y_i6YicYPOyM7Vu+AM9t09Kyg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jan 2, 2020 at 10:10 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

>
>
> Hi Li
> > To avoid FS deferred IO metadata/cache interferes test result, so we
> > do sync simply before the tst_dev_bytes_written invocation.
> >
> Looks good, acked. Also, I think we can mention it in
> doc/test-writing-guidelines.txt when using this api.
>

Ok, I will append one line as:
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1072,7 +1072,9 @@ unsigned long tst_dev_bytes_written(const char *dev);
 -------------------------------------------------------------------------------

 This function reads test block device stat file (/sys/block/<device>/stat)
and
-returns the bytes written since the last invocation of this function.
+returns the bytes written since the last invocation of this function. To
avoid
+FS deferred IO metadata/cache interferes the test result, we suggest doing
sync()
+before the tst_dev_bytes_written first invocation.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200102/bbed2fbd/attachment-0001.htm>
