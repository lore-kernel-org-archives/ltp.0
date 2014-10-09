Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1Xc3wa-0005a0-Bn
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 02:59:08 +0000
Received: from mail-ig0-f179.google.com ([209.85.213.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Xc3wZ-0004bG-JC
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 02:59:08 +0000
Received: by mail-ig0-f179.google.com with SMTP id h18so1630924igc.6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Oct 2014 19:59:02 -0700 (PDT)
Date: Thu, 9 Oct 2014 10:58:08 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20141009025808.GC24933@Leo.nay.redhat.com>
References: <1411649975-17339-1-git-send-email-liuhangbin@gmail.com>
	<54298ACA.1050101@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54298ACA.1050101@oracle.com>
Subject: Re: [LTP] [PATCH v2] ltp-networking/tcp_cmds/finger: fix finger bad
 user and host test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, LTP List <ltp-list@lists.sourceforge.net>, Vincent Hsu <vincent.hsu@linaro.org>

On Mon, Sep 29, 2014 at 08:37:30PM +0400, Alexey Kodanev wrote:
> Hi!
> 
> On 09/25/2014 04:59 PM, Hangbin Liu wrote:
> >Finger always return 0 with bad user and host test. And it also return
> >different error message on different distros. So let's only check stderr
> >message and decide whether the test pass or fail.
> >
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >---
> >  testcases/network/tcp_cmds/finger/finger01 | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> >diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
> >index 203d746..89693ff 100755
> >--- a/testcases/network/tcp_cmds/finger/finger01
> >+++ b/testcases/network/tcp_cmds/finger/finger01
> >@@ -115,13 +115,10 @@ do_test2()
> >      finger -x 2>&1 1>/dev/null && end_testcase "finger -x should fail"
> 
> I would change redirection here to  > /dev/null 2>&1 as we don't need to
> print stderr.

Yes, will correct it.
> 
> >      tst_resm TINFO "finger -bad user "
> >-    finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"
> >-    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" \
> >-        || end_testcase "finger @$BADHOST"
> >-    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null \
> >-        | grep "finger: unknown host"; then
> >+    [ "finger $BADUSER 2>&1 1>/dev/null" ] || end_testcase "finger $BADUSER"
> >+    [ "finger @$BADHOST 2>&1 1>/dev/null" ] || end_testcase "finger @$BADHOST"
> >+    [ "finger $BADUSER@$BADHOST 2>&1 1>/dev/null" ] || \
> 
> Checking string constants... not command output, forgot to add '$()'?

Opps, sorry for the stupid mistake.

> 
> Besides, it'd be great to get rid of obsolete 'net_cmdlib.sh' in the test.

OK, I will send another patch to clean up net_cmdlib.sh and mv read_opts() to
test_net.sh

-- 

Thanks & Best Regards
Hangbin Liu <liuhangbin@gmail.com>

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
