From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Oct 2018 12:15:28 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <20181008112855.5a7d3052@dell-desktop.home>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
 <20181004130611.GB32169@dell5510>
 <20181008112855.5a7d3052@dell-desktop.home>
Message-ID: <20181008101528.GA16364@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Myl=C3=A8ne,

> > > diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/test=
cases/kernel/containers/netns/netns_helper.sh =20
> > ...
> > > +			tst_brkm TCONF "Command not supported (maybe missing 'veth' suppo=
rt)" =20

> > ..
> > > diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testc=
ases/kernel/containers/netns/netns_sysfs.sh =20
> > ..
> > > +		tst_brkm TCONF "Command not supported (maybe missing 'dummy' suppo=
rt)" =20

> > Can you implement this patch with TST_NEEDS_DRIVERS (recently contribut=
ed by
> > Alexey Kodanev)? Thanks a lot!

> Yes, sure !

> I will implement it but not in the next weeks because I am going to be
> away until the end of November.
Both are pretty simple one liner patches, but no problem, it can wait for y=
ou :).

Kind regards,
Petr
