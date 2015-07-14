Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEz6M-0004vd-3J
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 12:14:22 +0000
Date: Tue, 14 Jul 2015 14:12:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714121250.GA6475@rei.suse.de>
References: <CANKSX+HUUC3aT+Pt-o=oqC1XismF-ErK8Ws79SAxKCOWE1g96w@mail.gmail.com>
	<20150714101634.GF3729@rei.suse.de>
	<CANKSX+GypbjxDozCzJFwDs0x3HmwZg6AbNEGCSDtyv2Cz1=FgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKSX+GypbjxDozCzJFwDs0x3HmwZg6AbNEGCSDtyv2Cz1=FgQ@mail.gmail.com>
Subject: Re: [LTP] Reg IO sched tests
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
To: "$rik@nth " <srikanth007m@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> But those are not  specific to IO scheduler governors like cfq, deadline,
> noop,vr and sio to find out.
> 
> I am looking for the tests which puts stress and calculate the average of
> below things to find out read index and write index.
> 
> MBRS =MB/s sequential reads
> MBWS =MB/s sequential writes
> RRIOPS =random reads IO's/sec
> RWIOPS=random writes IO's/sec

These would be rather called benchmarks and LTP does not include any of
these. Have a look at mmtests[1] instead.

[1] https://github.com/gormanm/mmtests/

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
