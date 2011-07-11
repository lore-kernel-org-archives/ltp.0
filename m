Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QgJ7J-0004OQ-Aj
	for ltp-list@lists.sourceforge.net; Mon, 11 Jul 2011 16:13:53 +0000
Date: Mon, 11 Jul 2011 18:15:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110711161513.GB31575@saboteur.suse.cz>
References: <20090512094631.26592.81609.sendpatchset@subratamodak.linux.ibm.com>
	<4E19987B.2030507@hartkopp.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E19987B.2030507@hartkopp.net>
Subject: Re: [LTP] Update for CAN LTP tests
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
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: ltp-list <ltp-list@lists.sf.net>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, netdev@vger.kernel.org, socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

Hi!
> > Would you also like to send a patch to update the testcases for CAN in LTP
> > (http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/network/can/filter-tests/) ?
> > These tests were originally picked up from:
> > http://svn.berlios.de/wsvn/socketcan/trunk/test/?rev=877&amp;sc=1
> 
> Dear Subrata,
> 
> attached you'll find a major update for the LTP tests dealing with CAN filters
> and the CAN frame flow down to the CAN netdevice and vice versa.
> 
> The patch removes all the obsolete stuff from the source code directory you
> originally picked the tests from. I added two new tools that also reside on
> the referenced SVN:
> 
> tst-filter: New filter test tool in *one* programm (easy to use & handle)
> tst-rcv-own-msgs: Checks the CAN frame flow inside the networking stack
> 
> Additionally the virtual CAN driver needs to be loaded with a special
> commandline option to perform the CAN frame flow test correctly.
> 
> The tests & the scripts are much clearer to me now. If it meets your
> requirements consider to apply this patch to the LTP repository.

Could you pretty please create signed patch(es) (git could create them
for you) so we could commit them into LTP repository.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
