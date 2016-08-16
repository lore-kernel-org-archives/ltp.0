From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Aug 2016 18:58:57 +0800
Subject: [LTP] [PATCH v2 2/2] test.sh: make the loop device size can be
 customized
In-Reply-To: <20160815114054.GB20680@rei.lan>
References: <1469683059-6318-1-git-send-email-liwang@redhat.com>
 <20160815114054.GB20680@rei.lan>
Message-ID: <20160816105857.GB28657@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 15, 2016 at 01:40:54PM +0200, Cyril Hrubis wrote:
> Hi!
> >  tst_acquire_device()
> >  {
> > +	local acq_dev_size=${1:-150}
> > +
> >  	if [ -z ${TST_TMPDIR} ]; then
> >  		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
> >  	fi
> >  
> > -	if [ -n "${LTP_DEV}" ]; then
> > +	if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -eq 150 ]; then
> 
> This is, unfortunately, not as simple as this either.
> 
> The $LTP_DEV could be passed to runltp as a command line parameter and
> could point to a real block device backed up by a disk. So there is no
> guarantee that it will be 150MB in size.

Thanks for reminding me, I didn't think of that.

> 
> What we have to do is to get the size of whatever is in $LTP_DEV here
> and return it if it has at least the requested size.

Good proposal.

How about make the patch like:

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index bd66109..60f8836 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -258,11 +258,15 @@ ROD()

 tst_acquire_device()
 {
+       local acq_dev_size=${1:-150}
+
        if [ -z ${TST_TMPDIR} ]; then
                tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
        fi

-       if [ -n "${LTP_DEV}" ]; then
+       ltp_dev_size=$((`blockdev --getsize64 $LTP_DEV`/1024/1024))
+
+       if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -le ${ltp_dev_size} ]; then
                tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
                if [ ! -b ${LTP_DEV} ]; then
                        tst_brkm TBROK "${LTP_DEV} is not a block device"
@@ -275,7 +279,7 @@ tst_acquire_device()
                return
        fi
 
-       ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
+       ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
  
        TST_DEVICE=$(losetup -f)
        if [ $? -ne 0 ]; then


Regards,
Li Wang
