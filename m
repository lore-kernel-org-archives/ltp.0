From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Jan 2017 09:45:16 -0500 (EST)
Subject: [LTP] LTP release status
In-Reply-To: <20170116141326.GF26610@rei.lan>
References: <20170112142828.GC1208@rei.lan> <20170112153917.GB5381@rei.lan>
 <1054431302.3375878.1484571069128.JavaMail.zimbra@redhat.com>
 <20170116130237.GA26610@rei.lan>
 <1116838376.3405880.1484572780617.JavaMail.zimbra@redhat.com>
 <20170116133023.GB26610@rei.lan>
 <329006128.105238.1484575796946.JavaMail.zimbra@redhat.com>
 <20170116141326.GF26610@rei.lan>
Message-ID: <1077366077.198599.1484577916329.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "Artem Savkov" <asavkov@redhat.com>, "Eryu Guan" <eguan@redhat.com>
> Sent: Monday, 16 January, 2017 3:13:26 PM
> Subject: Re: [LTP] LTP release status
> 
> Hi!
> > I'm thinking revert until we figure out which one is correct. I checked
> > man-pages
> > mailing list, but I don't see any patches for utimensat.
> 
> Sounds good. Go ahead and revert it with my ack.

Reverted along with "utimensat_tests: Make use of tst_kvcmp".

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
