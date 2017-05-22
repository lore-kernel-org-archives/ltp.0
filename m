From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 22 May 2017 09:37:27 -0400 (EDT)
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <20170522120400.GB11771@rei.lan>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
 <20170515123556.GA8280@rei.lan>
 <1832031935.11522951.1494853219630.JavaMail.zimbra@redhat.com>
 <20170515131329.GA12586@rei.suse.de>
 <1308561590.18511159.1495442352952.JavaMail.zimbra@redhat.com>
 <20170522120400.GB11771@rei.lan>
Message-ID: <544511110.19115837.1495460247279.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > I'm seeing this test failing a lot now on RHEL6/7 as some cases are
> > now more strict.
> 
> What kind of a system is that (hardware/kernel)?

Moonshot M700, AMD Opteron(tm) X2150 APU, 3000.21 BogoMIPS
RHEL7.4 3.10.0-666.el7 and upstream 4.11

> Have you tried that measure.c program I've send you there as well?

3.10.0-666.el7
./measure
min 119 max 167 median 161 mean 160.91 0.1% 0.10
min 560 max 1149 median 567 mean 793.39 0.1% 0.50
min 1062 max 1668 median 1068 mean 1237.44 0.1% 1.00
min 2077 max 2679 median 2623 mean 2582.46 0.1% 2.00
min 3045 max 3758 median 3624 mean 3587.18 0.1% 3.00
min 4092 max 4687 median 4624 mean 4597.38 0.1% 4.00
min 10072 max 10705 median 10624 mean 10596.56 0.1% 10.00
min 100125 max 100796 median 100676 mean 100631.29 0.1% 100.00
min 500149 max 501168 median 501077 mean 501017.30 0.1% 500.00
min 1000341 max 1001713 median 1001578 mean 1001553.56 0.1% 1000.00

4.11
./measure
min 154 max 168 median 160 mean 160.41 0.1% 0.10
min 560 max 1180 median 568 mean 776.71 0.1% 0.50
min 1061 max 1718 median 1069 mean 1283.03 0.1% 1.00
min 2071 max 2706 median 2625 mean 2574.26 0.1% 2.00
min 3083 max 3738 median 3625 mean 3583.02 0.1% 3.00
min 4110 max 4719 median 4626 mean 4584.89 0.1% 4.00
min 10077 max 10768 median 10629 mean 10526.83 0.1% 10.00
min 100127 max 100780 median 100684 mean 100611.68 0.1% 100.00
min 500385 max 501144 median 501019 mean 500861.94 0.1% 500.00
min 1000239 max 1001655 median 1001580 mean 1001460.26 0.1% 1000.00

> 
> Maybe we should just try to discard something as 5% of the outliners as
> well. I.e. storing the measured times in an array, sort it and discard
> some of the measurements.

Based on output from measure.c it looks most values have very similar
offset - it's just slightly larger on this system.

I tried to discard 10%, but I'll re-run it with your v2 measure
program.

> 
> These are failing just by a small bit, does the test work fine there if
> you increase the static part of the threshold by 50?

I'm trying on moonshot system now, and I need to go as high as + ~350
to make it pass.

Regards,
Jan
