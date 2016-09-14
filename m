From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 14 Sep 2016 08:59:36 -0400 (EDT)
Subject: [LTP] LTP Release
In-Reply-To: <20160914112947.GA7366@rei>
References: <20160914112947.GA7366@rei>
Message-ID: <1752509375.543819.1473857976139.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Wednesday, 14 September, 2016 1:29:47 PM
> Subject: [LTP] LTP Release
> 
> Hi!
> I'm more or less finished with pre-release testing. What is the status
> for the rest of you?

Results from RHEL6.2/6.7, RHEL7.0/7.1/7.3 across all arches 
look good here.

> 
> I guess that we slould fix the lsmod test failing on NFS before the
> release.
> 
> Anything else?

There was a report about readahead02 using wrong path for "read_ahead_kb",
when running on raw partitions. Patch seems simple, I just need to test it,
I'll try to do that today.

Regards,
Jan

> Can we proceed with the release later this week?
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
