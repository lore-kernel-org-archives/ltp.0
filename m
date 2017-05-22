From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 May 2017 17:15:55 +0200
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <297220533.19197153.1495465050258.JavaMail.zimbra@redhat.com>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
 <20170515123556.GA8280@rei.lan>
 <1832031935.11522951.1494853219630.JavaMail.zimbra@redhat.com>
 <20170515131329.GA12586@rei.suse.de>
 <1308561590.18511159.1495442352952.JavaMail.zimbra@redhat.com>
 <20170522131944.GC11771@rei.lan>
 <297220533.19197153.1495465050258.JavaMail.zimbra@redhat.com>
Message-ID: <20170522151555.GD11771@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > New measure script attached, now with gnuplot frequency graphs.
> > 
> > Can you, pretty please run that on the slow x86 machine, so that we know
> > if the failure is caused by a few outliners of if the measured times are
> > simply skeewed there?
> 
> Attached.

Hmm, strange, it looks like for 100us we got more or less all samples
close to 160us but for 500us half of the samples are close to 560us and
about 400 is more than 1000us, that does not look right. I wonder what
happens there. And the same for the rest of the measurements everything
but 100us sleeps has two peaks that are more or less 500us apart. So far
my machines, even VMs, had one peak and some outliners.

Can you try to rerun the test with a realtime priority?

-- 
Cyril Hrubis
chrubis@suse.cz
