Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S2mfz-0003eD-KK
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 16:46:51 +0000
Date: Wed, 29 Feb 2012 17:47:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120229164752.GA31644@saboteur.suse.cz>
References: <1329215581-26357-1-git-send-email-salvatore.cro@st.com>
	<1329217994-11574-1-git-send-email-salvatore.cro@st.com>
	<20120223182903.GG20855@saboteur.suse.cz> <4F474AF7.1070901@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F474AF7.1070901@st.com>
Subject: Re: [LTP] [PATCH V2] clone06: set child_env to getenv directly
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
To: Salvatore CRO' <salvatore.cro@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
> >>index 5db183b..50c8ef3 100644
> >>--- a/testcases/kernel/syscalls/clone/clone06.c
> >>+++ b/testcases/kernel/syscalls/clone/clone06.c
> >>@@ -192,18 +192,16 @@ void cleanup()
> >>  int child_environ(void)
> >>  {
> >>
> >>-	char var[MAX_LINE_LENGTH];
> >>+	char *child_env;
> >>
> >>  	/* Close read end from child */
> >>  	if ((close(pfd[0])) == -1) {
> >>  		tst_brkm(TBROK|TERRNO, cleanup, "close(pfd[0]) failed");
> >>  	}
> >>
> >>-	if ((sprintf(var, "%s", getenv("TERM") ? : ""))<= 0) {
> >>-		tst_resm(TWARN|TERRNO, "sprintf() failed");
> >>-	}
> >>+	child_env = getenv("TERM") ? : "";
> >>
> >>-	if ((write(pfd[1], var, MAX_LINE_LENGTH)) == -1) {
> >>+	if ((write(pfd[1], child_env, MAX_LINE_LENGTH)) == -1) {
> >>  		tst_resm(TWARN|TERRNO, "write to pipe failed");
> >Hmm, that one is wrong too, as you write MAX_LINE_LENGTH bytes
> >you write bytest __after__ the buffer.
> >
> I see...
> Whould then original patch
> 
> -       if ((sprintf(var, "%s", getenv("TERM") ? : "")) <= 0) {
> +       if ((sprintf(var, "%s", getenv("TERM") ? : "")) < 0) {
>                 tst_resm(TWARN|TERRNO, "sprintf() failed");
>         }
> 
> sounds more suitable?
> If yes you can directly apply it. Let me know if it needs me to resend it.

That one seems to be fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
