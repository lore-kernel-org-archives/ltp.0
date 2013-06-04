Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ujtb3-0001Is-Nx
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 15:56:29 +0000
Date: Tue, 4 Jun 2013 17:57:46 +0200
From: chrubis@suse.cz
Message-ID: <20130604155746.GA13860@rei.Home>
References: <1763657579.728071.1368446381686.JavaMail.root@redhat.com>
	<1761588100.736663.1368446981907.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1761588100.736663.1368446981907.JavaMail.root@redhat.com>
Subject: Re: [LTP] Coverity report for ltp-20130503
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> What is Coverity?
> Coverity Prevent is commercial enterprise level tool for static analysis
> (analysis based only on compiling of sources, not based on running of binary)
> of the C/C++ and Java code.
> 
> analyzer: coverity
> analyzer-args: --wait-for-license -co BAD_FREE:allow_first_field:true
> analyzer-version: Coverity Static Analysis for C/C++ version 6.5.2 on Linux 2.6.32-279.el6.x86_64 x86_64
> 
> This run includes snapshot of LTP git tree from 20130503 (on top of RHEL6.4).
> Results include also Open Posix testcases and use default coverity flags:
> http://jan.stancek.eu/coverity/ltp-20130503-1.el6.err.xz

Thanks for the report. I've taken care of several bugs in mprotect
testcases and continue to look at the results.

We may consider disabling MISSING_BREAK check for switch() statements as
majority of the reports are false possitives because coverity does not
understand __attribute__ noreturn for tst_brkm()

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
