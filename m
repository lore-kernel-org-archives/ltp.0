Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OE6Zp-000773-6b
	for ltp-list@lists.sourceforge.net; Mon, 17 May 2010 20:06:13 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OE6Zm-0000rM-Sp
	for ltp-list@lists.sourceforge.net; Mon, 17 May 2010 20:06:13 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100512212031.GI30926@ghostprotocols.net>
References: <1273686023.4910.9.camel@subratamodak.linux.ibm.com>
	<20100512212031.GI30926@ghostprotocols.net>
Date: Tue, 18 May 2010 01:36:00 +0530
Message-Id: <1274126761.5106.14.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] Testcase for recvmmsg(),
	a syscall for	batching	recvmsg() calls
Reply-To: subrata@linux.vnet.ibm.com
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
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Wed, 2010-05-12 at 18:20 -0300, Arnaldo Carvalho de Melo wrote: 
> Em Wed, May 12, 2010 at 11:10:23PM +0530, Subrata Modak escreveu:
> > Hello Arnaldo,
> > 
> > Your code in 2.6.33 kernel introduced a new system call called
> > recvmmsg(), a syscall for batching recvmsg() calls. Would you like to
> > share the set of test cases you used to test this new code with the LTP
> > community ?
> 
> Forgive me my ignorance about the current state of the LTP
> infrastructure, but does it support requiring multiple clients and a
> server to test networking calls? Or is everything done over loopback?

Sorry for the very late reply. No, we also have something called LTP
network tests, which require a separate server and client, and is
designed to burn the network wires and not the loopback interface.

Your test seems interesting. I will like to integrate the code later in
our networking tests when i find time. If there is a more active
volunteer, he is welcome to do it before me ;-)

Regards--
Subrata

> 
> The tests I did were basically:
> 
> On several client machines:
> 
> use netcat to continuously send datagrams to a destination machine on
> a specified port (5001, the ttcp one is used as a default)
> 
> On the server:
> 
> run the attached testcase, then I was basically visually looking that
> every batch received packets from multiple clients.
> 
> I can envision a test where from the machine chosen to be the server a
> script like:
> 
> #!/bin/sh
> 
> ./recvmmsg &
> 
> for client in $CLIENTS ; do
> 	ssh client ./run-netcat-script.sh $SERVER
> done
> 
> # --- end ---
> 
> The attached recvmmsg would somehow get the list of clients, check that
> they are the sendeds in datagrams in the same batch, and if so, woud
> emit a PASSED as output.
> 
> Another question about the LTP infrastructure: Do it already supports
> collecting measurements in databases, associated to the kernel, libc,
> etc, versions, so that this can be used to generate plottings of metrics
> over time/kernel versions?
> 
> - Arnaldo


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
