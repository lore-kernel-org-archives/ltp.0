Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RbCfL-00037B-AJ
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 14:52:11 +0000
Date: Thu, 15 Dec 2011 16:01:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111215150115.GA4046@saboteur.suse.cz>
References: <1321950888-11346-1-git-send-email-salvatore.cro@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1321950888-11346-1-git-send-email-salvatore.cro@st.com>
Subject: Re: [LTP] [PATCH] testcases: exit from signal handler in setrlimit01
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
> Signal hanlder is installed using default tst_sig function
> which sets sa_flags = SA_RESTART for sigaction. In this
> conditions the child gets stuck because at any SIGSEGV
> caught the hanlder ends-up restarting the function which
> raised the signal.
> Signal handler must give the child the chance to exit.

Good catch. Commited with change from tst_exit() to _exit(0);

As we are in child process (thus not using tst_exit()) and we also are
in signal handler so we should use _exit() rather than exit().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
