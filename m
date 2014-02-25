Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIMI7-00054n-NK
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 17:59:39 +0000
Date: Tue, 25 Feb 2014 18:59:23 +0100
From: chrubis@suse.cz
Message-ID: <20140225175923.GB17609@rei>
References: <1392969112-15851-1-git-send-email-francesco.rundo@st.com>
	<775921692.6959618.1392973731667.JavaMail.zimbra@redhat.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE401@SAFEX1NODE23.st.com>
	<1636908988.6999631.1392977205402.JavaMail.zimbra@redhat.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE486@SAFEX1NODE23.st.com>
	<387845948.7047521.1392980482074.JavaMail.zimbra@redhat.com>
	<1110699270.7050041.1392980994165.JavaMail.zimbra@redhat.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE578@SAFEX1NODE23.st.com>
	<1275798317.7097152.1392986267877.JavaMail.zimbra@redhat.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE5AE@SAFEX1NODE23.st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D2A2C37B00D2EA4CB1886D29B96695C55AE5AE@SAFEX1NODE23.st.com>
Subject: Re: [LTP] [PATCH] madvise/madvise03.c: Changed test exit code
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> > > > Now, "do_fallocate()" needs fallocate() op. but on ext3 this is 
> > > > not supported i.e. ENOTSUP.
> > 
> > >>Do you have kernel compiled with CONFIG_TMPFS=y?
> > 
> > No. I've just checked kernel with above option: the reported madvise03 
> > testcase worked fine (usage of shmem_fallocate()).
> > So your analysis of my scenario is corret.
> > Please , discard posted patch.
> 
> >>We can still handle this with some patch to skip first testcase if kernel is compiled without "CONFIG_TMPFS=y". I think that qualifies as TCONF.
> >>I'll leave it up to you.
> 
> Hmmm....yes... as TCONF(and not TFAIL) is of course the right exit code in case of TMPFS not enabled on kernel side.
> I let you know...

Generally LTP tests should handle gracefully when syscall returns ENOSYS
or ENOTSUP, in reality only cases that has been catched by somebody are
handled.

What about following patch?

madvise/madvise03: Return TCONF on ENOTSUP

If support for TMPFS (CONFIG_TMPFS) is not compiled in kernel madvise
will return ENOTSUP for these testcases. Return TCONF rather than TFAIL
int this case.

Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise03.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index aeae429..02b28d2 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -157,6 +157,11 @@ static void cleanup(void)
 static void check_and_print(char *advice)
 {
 	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == ENOTSUP && !strcmp(advice, "MADV_REMOVE")) {
+			tst_resm(TCONF, "madvise MADV_REMOVE returned ENOTSUP"
+			         " CONFIG_TMPFS=y not in kernel .config?");
+			return;
+		}
 		tst_resm(TFAIL,
 			 "madvise test for %s failed with "
 			 "return = %ld, errno = %d : %s",

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
