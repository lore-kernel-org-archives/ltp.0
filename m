Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WzOt1-0004Uu-HP
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 11:27:39 +0000
Date: Tue, 24 Jun 2014 13:27:23 +0200
From: chrubis@suse.cz
Message-ID: <20140624112722.GA6647@rei>
References: <1401286323-7364-1-git-send-email-alexey.kodanev@oracle.com>
	<20140623154912.GC982@rei.suse.cz> <53A950BC.2050203@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53A950BC.2050203@oracle.com>
Subject: Re: [LTP] [PATCH RFC] testscripts/network: uniform network
	parameters
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > A bit more documentation how to setup these would not harm. Do we have a
> > document that describes this?
> 
> Yes, there's a file which describes them, 'testcases/network/stress/README'.

Ok, looks good. What about we add this path in a comment to the script
with the settings?

> > Moreover we may want to create a script to query interface IP and HWaddr
> > (and possibly others we may need) because ifconfig is deprecated and
> > some distros does not install it by default. If we move it to a library
> > we may write a code to use either ifconfig of ip depending on what is
> > available.
> 
> Yes, e.g. many tests setting ipv4 and ipv6 addresses which can also be 
> moved to the library. Anyway, do you mean test-case library 
> 'test_net.sh'? If yes we will require setting TCID, ... variables in 
> configuration scripts, perhaps we can use "net_config" or other names 
> for ID. Will it be OK?

Yes, test_net.sh sounds like a good place for such functions.

Hmm, all the configuration and library scripts are in the end sourced to
some testcase which defines TCID and TST_TOTAL, or do I miss something?

> Most network tests use both 'ip' and 'ifconfig', so if we don't have one 
> of them, most tests will be broken. I would stay with 'ip' and try to 
> not using 'ifconfig'. What do you think?

Agreed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
