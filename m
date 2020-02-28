From: Steve Muckle <smuckle@google.com>
Date: Fri, 28 Feb 2020 11:47:16 -0800
Subject: [LTP] use of pthread_cancel in tst_fuzzy_sync.h
Message-ID: <2365a007-02fe-c48c-2df5-04aedc076208@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

While integrating the latest LTP release into Android's VTS test suite I 
ran into trouble with this commit:

commit cad524797ba4cee2e40985043f113256419f4a90
Author: Li Wang <liwang@redhat.com>
Date:   Thu Sep 26 17:39:21 2019 +0800

     fzsync: revoke thread_b if parent hits accidental break

It introduces a dependency on pthread_cancel() which Android does not 
implement:

https://android.googlesource.com/platform/bionic/+/refs/heads/master/docs/status.md

In the short term I can work around this, taking out the 
pthread_cancel() should be fine as far as I can tell as it is just used 
to avoid a timeout in certain circumstances. Long term though, could 
this be reworked to use pthread_kill() or some other mechanism?

thanks,
Steve
