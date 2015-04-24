Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Yle46-000061-QH
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 13:54:46 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yle43-0007Fv-Nm
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 13:54:46 +0000
Date: Fri, 24 Apr 2015 09:54:37 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
In-Reply-To: <1555406842.5673672.1429863249724.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] Coverity report for ltp-20150420
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
To: ltp-list <ltp-list@lists.sf.net>

Hi,

What is Coverity?
  Coverity Prevent is commercial enterprise level tool for static analysis
  (analysis based only on compiling of sources, not based on running of binary)
  of the C/C++ and Java code.
analyzer-version-coverity = 7.6.1

This run includes latest LTP release 20150420 (including open_posix_testsuite):
  http://jan.stancek.eu/coverity/ltp-20150420.err.xz

      1 ARRAY_VS_SINGLETON
      4 BAD_COMPARE
     17 BAD_FREE
      1 CHAR_IO
    319 CHECKED_RETURN
      6 CONSTANT_EXPRESSION_RESULT
      3 COPY_PASTE_ERROR
     29 DEADCODE
      1 EVALUATION_ORDER
     43 FORWARD_NULL
      3 IDENTICAL_BRANCHES
     21 MISSING_BREAK
    497 NEGATIVE_RETURNS
      7 NO_EFFECT
      6 NULL_RETURNS
      1 OVERFLOW_BEFORE_WIDEN
     27 OVERRUN
      1 PASS_BY_VALUE
    343 RESOURCE_LEAK
      1 RETURN_LOCAL
      1 REVERSE_INULL
      2 REVERSE_NEGATIVE
     19 SIZEOF_MISMATCH
      1 STRAY_SEMICOLON
     91 UNINIT
     14 UNREACHABLE
      6 UNUSED_VALUE
     48 USE_AFTER_FREE
      1 VARARGS

Regards,
Jan

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
