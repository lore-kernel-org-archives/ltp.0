From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 21 Nov 2016 04:10:57 -0500 (EST)
Subject: [LTP] [RFC] Cleanup of tools/ directory
In-Reply-To: <20161114140504.GE25055@rei.lan>
References: <20161114140504.GE25055@rei.lan>
Message-ID: <194063547.847310.1479719457351.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Monday, 14 November, 2016 3:05:04 PM
> Subject: [LTP] [RFC] Cleanup of tools/ directory
> 
> Hi!
> I've stumbled upon the tools/ directory and there is quite a lot of
> broken code that is not really useful for anything.
> 
> The Makefile skips netpipe*, pounder21 and top-LTP directories. Apart
> from automatic changes nobody touched the top-LTP and netpipe* code for
> more than six years, so I would say that it's safe enough to remove
> these. The pounder21 had some fixes that looks like somebody is using
> that so I guess that we should keep it.

I see pounder referenced occasionally in RH bugzilla reports, so
I'd keep it.

> 
> Then there are files that looks like they could be removed as well:
> 
> * STPfailure_report.pl - most likely no change since 2004, looks useless o me
> 
> * ltp_master, ltp_check, README, ltpoutput*
>   - remnants of some automated framework that used ltprun script that
>     used runalltests.sh script, I will remove these since there is no
>     reason to keep them now
> 
> In short has anybody anything agains removal of netpipe*, top-LTP,
> STPfailure_report.pl, ltp_master, ltp_check, README, and ltpoutput* from
> the tools/ directory?

My only hesitation was netpipe, which is referenced by couple scripts,
but looking at tools/Makefile comment and fact we are not building it for
so many years, I guess nobody will miss it.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
