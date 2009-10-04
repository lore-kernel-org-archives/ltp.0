Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MuZOX-0002aE-9N
	for ltp-list@lists.sourceforge.net; Sun, 04 Oct 2009 22:17:33 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MuZOP-00052T-0X
	for ltp-list@lists.sourceforge.net; Sun, 04 Oct 2009 22:17:33 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 5 Oct 2009 00:18:12 +0200
References: <8368651DACC1964480F951191B94A0780142442B@svexch01.mvista.com>
In-Reply-To: <8368651DACC1964480F951191B94A0780142442B@svexch01.mvista.com>
MIME-Version: 1.0
Message-Id: <200910050018.12711.jpalecek@web.de>
Subject: Re: [LTP] [PATCH][openfile] file descriptors not cleaned up
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Hello,

On Wednesday 30 September 2009 04:06:46 Henry Yei wrote:
> This patch for openfile contains the following changes:
> - test output to use tst_resm functions
> - sets ups and cleans up tmp dir properly
> - closes all opened file descriptors before thread exit(fixes nfs issues on removing tmp dir)
> 
> Signed-off-by: Henry Yei <hyei@mvista.com>
> 
> 
> This test opens multiple file descriptors to the same file. Perhaps the author meant to open file handles for separate files?

This is suspicious, for me too. But maybe there is some logic behind opening the same file many times.

I just have a small remark about your patch: Shouldn't you call close_files() here, too? (With a partially full fd_list array handled, of course)

+void * threads(void* thread_id_) {
+	int thread_id = (uintptr_t) thread_id_;
+	char errmsg[80];
+	FILE *fd_list[MAXFILES];
+	int i;
+
+	/* Open files */
+	for (i = 0; i < numfiles; i++) {
+		if (debug)
+			printf("Thread  %d : Opening file number %d \n", thread_id, i);
+		if ((fd_list[i] = fopen(filename, "rw")) == NULL) {
+			sprintf(errmsg, "FAIL - Couldn't open file #%d", i);
+			perror(errmsg);

Regards
    Jiri Palecek

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
