Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S2mja-0007l1-EZ
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 16:50:34 +0000
Date: Wed, 29 Feb 2012 17:51:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120229165135.GA31640@saboteur.suse.cz>
References: <1329215581-26357-1-git-send-email-salvatore.cro@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1329215581-26357-1-git-send-email-salvatore.cro@st.com>
Subject: Re: [LTP] [PATCH] clone06: legitimate zero as sprintf return value
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
> -	if ((sprintf(var, "%s", getenv("TERM") ? : "")) <= 0) {
> +	if ((sprintf(var, "%s", getenv("TERM") ? : "")) < 0) {
>  		tst_resm(TWARN|TERRNO, "sprintf() failed");

Commited, thanks.

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
